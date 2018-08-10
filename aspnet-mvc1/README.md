# ASP.NET MVC 1.0

The ASP.NET MVC framework provides an alternative to the ASP.NET Web Forms pattern for creating MVC-based Web applications.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

A binary package containing the ASP.NET MVC 1.0 assemblies

## Usage

Consuming applications will need to have .NET 3.5 installed to consume this assembly. You will also need to update your ".csproj" references to point to the new location for building.
This can be done on the fly as shown in the example below:

```
    $csprojPath = "$HAB_CACHE_SRC_PATH\$pkg_dirname\src\MovieApp\MovieApp\MovieApp.csproj"

    $proj = [xml](get-content $csprojPath)
    $mvcAssemblyHintPathNode = $proj.CreateElement("HintPath", "http://schemas.microsoft.com/developer/msbuild/2003")
    $mvcAssemblyHintPath = "$(Get-HabPackagePath aspnet-mvc1)\Assemblies\System.Web.Mvc.dll"
    $mvcAssemblyHintPathNode.InnerText = $mvcAssemblyHintPath
    $proj.GetElementsByTagName("Reference") | foreach {
        if($_.Include -eq 'System.Web.Mvc, Version=1.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35, processorArchitecture=MSIL'){
            $_.AppendChild($mvcAssemblyHintPathNode)
        }
    }
    $proj.Save($csprojPath)
```