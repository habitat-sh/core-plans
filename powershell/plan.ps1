$pkg_name="powershell"
$pkg_origin="core"
$pkg_version="6.0.0-beta.5"
$pkg_license=@("MIT")
$pkg_upstream_url="https://msdn.microsoft.com/powershell"
$pkg_description="PowerShell is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized for dealing with structured data (e.g. JSON, CSV, XML, etc.), REST APIs, and object models. It includes a command-line shell, an associated scripting language and a framework for processing cmdlets."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/PowerShell/PowerShell/archive/v$pkg_version.zip"
$pkg_shasum="cdfa8da4f05310b78e09dedaa455770508c30ec9e5992b838046b1869085fb75"
$pkg_filename="powershell-$pkg_version-win7-win2k8r2-x64.zip"
$pkg_build_deps=@("core/visual-cpp-build-tools-2015", "core/dotnet-core-sdk-preview", "core/cmake")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function invoke-Build() {
  ################################################################################
  # These are all needed for the MSBUILD native compilation
  $env:VCTargetsPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\Microsoft.Cpp\v4.0\v140"
  $ENV:WindowsSdkDir_81="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Windows Kits\8.1\"
  
  $env:CLTrackerSdkPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\14.0\bin\amd64"
  $env:CLTrackerFrameworkPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\14.0\bin\amd64"
  $env:LinkTrackerSdkPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\14.0\bin\amd64"
  $env:LinkTrackerFrameworkPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\14.0\bin\amd64"
  $env:LibTrackerSdkPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\14.0\bin\amd64"
  $env:LibTrackerFrameworkPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\14.0\bin\amd64"
  $env:RCTrackerSdkPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\14.0\bin\amd64"
  $env:RCTrackerFrameworkPath="$(Get-HabPackagePath visual-cpp-build-tools-2015)\Program Files\MSBuild\14.0\bin\amd64"
  
  $env:LibraryPath = $env:LIB
  $env:IncludePath = $env:INCLUDE
  ################################################################################

  $build_root = "$HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_dirname"
  $pkg_version > "$build_root/powershell.version"
  $null = new-item -force -type file "$build_root/DELETE_ME_TO_DISABLE_CONSOLEHOST_TELEMETRY"

  Write-BuildLine "running dotnet restore"
  $srcProjectDirs = @("$build_root/src/powershell-win-core", "$build_root/src/TypeCatalogGen", "$build_root/src/ResGen")
  $testProjectDirs = Get-ChildItem "$build_root/test/*.csproj" -Recurse | ForEach-Object { [System.IO.Path]::GetDirectoryName($_) }
  ($srcProjectDirs + $testProjectDirs) | ForEach-Object { dotnet restore $_ }

  Push-Location "$build_root/src/ResGen"
  try {
      Write-BuildLine "building resgen"
      dotnet run
  } finally {
      Pop-Location
  }

  Push-Location "$build_root/src/powershell-native"
  try {
      Write-BuildLine "building native binaries"
      Get-ChildItem "nativemsh/pwrshplugin" -Filter "*.mc" | ForEach-Object {
        Write-BuildLine "calling mc"
        & "$(Get-HabPackagePath visual-cpp-build-tools-2015)\Windows Kits\8.1\bin\x64\mc.exe" -o -d -c -U "$($_.FullName)" -h "nativemsh/pwrshplugin" -r "nativemsh/pwrshplugin"
        Write-BuildLine "mc called"
      }

      Write-BuildLine "calling cmake"
      & cmake -DBUILD_ONECORE=ON -DBUILD_TARGET_ARCH=x64 -G "Visual Studio 14 2015 Win64" .
      Write-BuildLine "calling msbuild with inc $env:include"
      & msbuild ALL_BUILD.vcxproj /p:Configuration=Release
      @('pwrshplugin.dll', 'pwrshplugin.pdb') | % {
        $dstPath = "$build_root/src/powershell-win-core"
        $srcPath = Join-Path (Join-Path (Join-Path (Get-Location) "bin") "Release") "CoreClr/$_"
        Write-BuildLine "Copying $srcPath to $dstPath"
        Copy-Item $srcPath $dstPath
      }

      Copy-Item .\Install-PowerShellRemoting.ps1 "$build_root/src/powershell-win-core"
  } finally {
      Pop-Location
  }

  Write-BuildLine "building typegen"
  $GetDependenciesTargetPath = "$build_root/src/Microsoft.PowerShell.SDK/obj/Microsoft.PowerShell.SDK.csproj.TypeCatalog.targets"
  $GetDependenciesTargetValue = @'
<Project>
    <Target Name="_GetDependencies"
            DependsOnTargets="ResolveAssemblyReferencesDesignTime">
        <ItemGroup>
            <_RefAssemblyPath Include="%(_ReferencesFromRAR.ResolvedPath)%3B" Condition=" '%(_ReferencesFromRAR.Type)' == 'assembly' And '%(_ReferencesFromRAR.PackageName)' != 'Microsoft.Management.Infrastructure' " />
        </ItemGroup>
        <WriteLinesToFile File="$(_DependencyFile)" Lines="@(_RefAssemblyPath)" Overwrite="true" />
    </Target>
</Project>
'@
  Set-Content -Path $GetDependenciesTargetPath -Value $GetDependenciesTargetValue -Force -Encoding Ascii

  Push-Location "$build_root/src/Microsoft.PowerShell.SDK"
  try {
      $ps_inc_file = "$build_root/src/TypeCatalogGen/powershell.inc"
      dotnet msbuild .\Microsoft.PowerShell.SDK.csproj /t:_GetDependencies "/property:DesignTimeBuild=true;_DependencyFile=$ps_inc_file" /nologo
  } finally {
      Pop-Location
  }

  Push-Location "$build_root/src/TypeCatalogGen"
  try {

      dotnet run ../Microsoft.PowerShell.CoreCLR.AssemblyLoadContext/CorePsTypeCatalog.cs powershell.inc
  } finally {
      Pop-Location
  }
}

function Invoke-Install {
  try {
    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_dirname/src/powershell-win-core"
    dotnet publish --configuration Release --framework netcoreapp2.0 --runtime win7-x64 --output "$pkg_prefix/bin"
  }
  finally {
    Pop-Location
  }

  Write-BuildLine "restoring modules"
  $modulesDir = "$pkg_prefix/bin/Modules"
  Restore-PSModule -Destination $modulesDir -Name @(
      # PowerShellGet depends on PackageManagement module, so PackageManagement module will be installed with the PowerShellGet module.
      'PowerShellGet'
  )

  # Restore modules from powershellgallery feed
  Restore-PSModule -Destination $modulesDir -Name @(
      'Microsoft.PowerShell.Archive'
  ) -SourceLocation "https://www.powershellgallery.com/api/v2/"
}

function Invoke-Check() {
  $versionTable = ./powershell.exe -command '$PSVersionTable'
  $passed = $false

  $versionTable | % {
    if($_.Trim().StartsWith('GitCommitId')) {
        $passed = $_.Trim().EndsWith($pkg_version)
    }
  }

  if(!$passed) {
    Write-Error "Check failed to confirm powershell version as $pkg_version"
  }
}

# Install PowerShell modules such as PackageManagement, PowerShellGet
function Restore-PSModule
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Destination,

        [string]$SourceLocation="https://powershell.myget.org/F/powershellmodule/api/v2/",

        [string]$RequiredVersion
        )

    $needRegister = $true
    $RepositoryName = "mygetpsmodule"

    # Check if the PackageManagement works in the base-oS or PowerShellCore
    Get-PackageProvider -Name NuGet -ForceBootstrap -Verbose:$VerbosePreference
    Get-PackageProvider -Name PowerShellGet -Verbose:$VerbosePreference

    # Get the existing registered PowerShellGet repositories
    $psrepos = PowerShellGet\Get-PSRepository

    foreach ($repo in $psrepos)
    {
        if(($repo.SourceLocation -eq $SourceLocation) -or ($repo.SourceLocation.TrimEnd("/") -eq $SourceLocation.TrimEnd("/")))
        {
            # found a registered repository that matches the source location
            $needRegister = $false
            $RepositoryName = $repo.Name
            break
        }
    }

    if($needRegister)
    {
        $regVar = PowerShellGet\Get-PSRepository -Name $RepositoryName -ErrorAction SilentlyContinue
        if($regVar)
        {
            PowerShellGet\UnRegister-PSRepository -Name $RepositoryName
        }

        Write-BuildLine "Registering PSRepository with name: $RepositoryName and sourcelocation: $SourceLocation"
        PowerShellGet\Register-PSRepository -Name $RepositoryName -SourceLocation $SourceLocation -ErrorVariable ev -verbose
        if($ev)
        {
            throw ("Failed to register repository '{0}'" -f $RepositoryName)
        }

        $regVar = PowerShellGet\Get-PSRepository -Name $RepositoryName
        if(-not $regVar)
        {
            throw ("'{0}' is not registered" -f $RepositoryName)
        }
    }

    # do not output progress
    $ProgressPreference = "SilentlyContinue"
    $Name | ForEach-Object {

        $command = @{
                        Name=$_
                        Path = $Destination
                        Repository =$RepositoryName
                    }

        if($RequiredVersion)
        {
            $command.Add("RequiredVersion", $RequiredVersion)
        }

        # pull down the module
        Write-BuildLine "running save-module $_"
        PowerShellGet\Save-Module @command -Force

        # Remove PSGetModuleInfo.xml file
        Find-Module -Name $_ -Repository $RepositoryName -IncludeDependencies | ForEach-Object {
            Remove-Item -Path $Destination\$($_.Name)\*\PSGetModuleInfo.xml -Force
        }
    }

    # Clean up
    if($needRegister)
    {
        $regVar = PowerShellGet\Get-PSRepository -Name $RepositoryName -ErrorAction SilentlyContinue
        if($regVar)
        {
            Write-BuildLine "Unregistering PSRepository with name: $RepositoryName"
            PowerShellGet\UnRegister-PSRepository -Name $RepositoryName
        }
    }
}