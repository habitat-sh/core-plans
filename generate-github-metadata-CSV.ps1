# Get all directories in the current workspace
$directories = Get-ChildItem -Path "." -Directory
$repoRootURL = "https://github.com/habitat-sh/core-plans"

# Create an array to store the results
$results = @()
# Directories to exclude
$excludeDirs = @('.github', '.deprecated', '.refresh', '.expeditor', "bin", "ci", "docs")

# Filter out excluded directories
$directories = $directories | Where-Object { $excludeDirs -notcontains $_.Name }

foreach ($dir in $directories) {
    $planSh = Test-Path (Join-Path $dir.FullName "plan.sh")
    $planPs1 = Test-Path (Join-Path $dir.FullName "plan.ps1")
    
    #  Read the content of the plan file, defaulting to Linux plan if both exist
    if ($planSh) {
        $planContent = Get-Content -Path (Join-Path $dir.FullName "plan.sh") -Raw
    } elseif ($planPs1) {
        $planContent = Get-Content -Path (Join-Path $dir.FullName "plan.ps1") -Raw
    } else {
        $planContent = ""
    }

    # Skip if no plan content found
    if ([string]::IsNullOrWhiteSpace($planContent)) { 
        Write-Error "No plan content found in $($dir.FullName), skipping..."
        continue 
    }

    # generate a CSV row for a given directory/package
    $results += [PSCustomObject]@{
        # generate package, origin + package columns
        FolderName = $dir.Name

        PackageOrigin =  if ($planContent -match 'pkg_origin\s*=\s*"?([^\s"]+)"?') {
            $matches[1]
        } else {
            "NO ORIGIN FOUND"
        }

        PackageName = if ($planContent -match 'pkg_name\s*=\s*"?([^\s"]+)"?') {
            $matches[1]
        } else {
            "NO PACKAGE NAME FOUND"
        }

        PackageFullName = if ($planContent -match 'pkg_origin\s*=\s*"?([^\s"]+)"?') {
            $temp = $matches[1]
            if ($planContent -match 'pkg_name\s*=\s*"?([^\s"]+)"?') {
                $temp += "/$($matches[1])"
            } else {
                $temp += "/NO PACKAGE NAME FOUND"
            }
            $temp
        } else {
            "NO ORIGIN FOUND/NO PACKAGE NAME FOUND"
        }
        
        # PackageFullName = $PackageOrigin + "/" + $PackageName

        # package version
        PackageVersion = if ($planSh) {
            if ($planContent -match 'pkg_version\s*=\s*"?([^\s"]+)"?') {
                $matches[1]
            } else {
                "NO VERSION FOUND"
            }
        } else {
            ""
        }

        GitHubURL = "$repoRootURL/tree/main/$($dir.Name)"
        LinuxPlanFileURL = if ($planSh) { "$repoRootURL/blob/main/$($dir.Name)/plan.sh" } else { "NO LINUX PLAN FILE" }
        WindowsPlanFileURL = if ($planPs1) { "$repoRootURL/blob/main/$($dir.Name)/plan.ps1" } else { "NO WINDOWS PLAN FILE" }

        # pkg_upstream_url="https://savannah.nongnu.org/projects/acl"
        SourceWebsite = if ($planContent -match 'pkg_upstream_url\s*=\s*"?([^"\n]+)"?') {
                $matches[1]
            } else {
                "NO upstream url found"
            }
        
        # pkg_source="http://download.savannah.gnu.org/releases/$pkg_name/$pkg_name-${pkg_version}.tar.gz"
        OriginalSource = if ($planContent -match 'pkg_source\s*=\s*"?([^"\n]+)"?') {
            $source = $matches[1]

            # Substitute ${pkg_filename}
            $pkgFilename = ""
            if ($planContent -match 'pkg_filename\s*=\s*"?([^"\n]+)"?') {
                $pkgFilename = $matches[1]
            }
            if ($source -match '\$\{pkg_filename\}' -and $pkgFilename) {
                $source = $source -replace '\$\{pkg_filename\}', $pkgFilename
            }

            # Substitute ${pkg_name}
            $pkgName = ""
            if ($planContent -match 'pkg_name\s*=\s*"?([^"\n]+)"?') {
                $pkgName = $matches[1]
            }
            if ($source -match '\$\{pkg_name\}' -and $pkgName) {
                $source = $source -replace '\$\{pkg_name\}', $pkgName
            }

            # Substitute ${pkg_version}
            $pkgVersion = ""
            if ($planContent -match 'pkg_version\s*=\s*"?([^"\n]+)"?') {
                $pkgVersion = $matches[1]
            }
            if ($source -match '\$\{pkg_version\}' -and $pkgVersion ) {
                $source = $source -replace '\$\{pkg_version\}', $pkgVersion
            }

            $source
        
        } else {
            "NO SOURCE FOUND"
        }
        
        # pkg_license=('lgpl')
        PackageLicense = if ($planContent -match 'pkg_license\s*=\s*\(([^)]+)\)') {
                ($matches[1] -replace "[`'`"]", '' -split '\s+') -join ','
            } elseif ($planContent -match 'pkg_license\s*=\s*"?([^\s"]+)"?') {
                $matches[1]
            } else {
                "NO LICENSE FOUND"
            }
        

        BuilderDownloadURL = if ($planContent -match 'pkg_origin\s*=\s*"?([^\s"]+)"?') {
            $temp = $matches[1]
            if ($planContent -match 'pkg_name\s*=\s*"?([^\s"]+)"?') {
                $temp += "/$($matches[1])"
            } else {
                $temp += "/NO PACKAGE NAME FOUND"
            }
            "https://bldr.habitat.sh/#/pkgs/$temp/latest"
        }
        else {
            "NO BUILDER PATH FOUND"
        }

        # package description
        PackageDescription = if ($planContent -match 'pkg_description\s*=\s*"?([^"\n]+)"?') {
                $matches[1]
            } else {
                "NO DESCRIPTION FOUND"
            }

        # TODO - add the dependencies, so we can map them later

        # TODO - add tasks for cleanup such as:
        # 1. verify folder name matches to package names, origins, etc.
        # 2. verify source website exists and is reachable, and that it is in both linux and windows plans
        # 2.b verify (manually) that this source is the real source and not a secondary/mirror URL
        # 3. verify the original source URL exists and is reachable
        # 4. verify that the package version is the same in both linux and windows plans and is correct with respect to the source site
        # 5. verify that the builder URL exists and is reachable
    }
}

# Export to CSV
$csvPath = "folder_plans_inventory.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "CSV file created at: $csvPath"
Write-Host "Total directories processed: $($results.Count)"