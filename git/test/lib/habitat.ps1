
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Private Functions START
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function habitat::_install_inspec {
    hab pkg path stuartpreston/inspec
    if (!$?) { 
      Write-Host "installing stuartpreston/inspec"
      hab pkg install -b stuartpreston/inspec
    }
    Write-Host "stuartpreston/inspec already installed"
}

function habitat::_create_yaml_file_for {
    param (
        [Parameter(Mandatory=$true)][string]$Planroot
    )

    # Load the habitat build variables
    . $Planroot\results\last_build.ps1
    
    # Ensure last_build.yml is clean before filling it
    Out-File -FilePath $Planroot\results\last_build.yml -Force
    Add-Content $Planroot\results\last_build.yml "pkg_ident: '$pkg_ident'"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Private Functions END
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function habitat::build_git {
    Write-Host "Building plan at $PLAN_ROOT"
    $CURRENT_DIRECTORY = Get-Location
    cd $PLAN_ROOT; 
    Write-Host "hab pkg build ."
    hab pkg build .
    if (!$?) { Exit "Habitat build failed!!"; Exit 1 }
    Write-Host "Returning to $CURRENT_DIRECTORY"
    cd $CURRENT_DIRECTORY
}

function habitat::load_git {
    # Load the habitat build variables
    . $PLAN_ROOT\results\last_build.ps1

    # install habitat package
    $ARTIFACT = "$PLAN_ROOT\results\{0}" -f $pkg_artifact
    hab pkg install $ARTIFACT
    if (!$?) { Exit "Habitat installation failed!!"; Exit 1 }
}

function habitat::test_git {
    habitat::_install_inspec
    habitat::_create_yaml_file_for -Planroot $PLAN_ROOT

    inspec exec $PLAN_ROOT/test --attrs $PLAN_ROOT/results/last_build.yml
}