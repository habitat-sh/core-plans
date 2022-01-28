param(
  [Parameter()]
  [string]$PackageIdentifier = $(throw "Usage: test.ps1 [test_pkg_ident] e.g. test.ps1 ci/user-windows-default/1.0.0/20190812103929")
)

$PackageVersion = $PackageIdentifier.split('/')[2]

Describe "ruby25" {
  Context "ruby" {
    It "is an executable" {
      hab pkg exec $PackageIdentifier ruby.exe -v
      $? | Should be $true
    }

    It "is the expected version" {
      $version_output = (hab pkg exec $PackageIdentifier ruby.exe -v | Out-String)
      $version_output | Should MatchExactly "ruby ${PackageVersion}p"
    }
  }

  Context "gem" {
    It "is an executable" {
      hab pkg exec $PackageIdentifier gem.cmd -v
      $? | Should be $true
    }
  }

  Context "bundle" {
    It "is an executable" {
      hab pkg exec $PackageIdentifier bundle.cmd -v
      $? | Should be $true
    }
  }

  Context "setup environment paths" {
    $PackagePath = (hab pkg path $PackageIdentifier)
    It "pushes its gems onto GEM_PATH" {
      "${PackagePath}/RUNTIME_ENVIRONMENT" | Should FileContentMatchExactly "GEM_PATH"
    }
    It "does not include build studio kruft in paths" {
      "${PackagePath}/RUNTIME_ENVIRONMENT" | Should Not FileContentMatchExactly "\\hab\\studios"
    }
  }
}
