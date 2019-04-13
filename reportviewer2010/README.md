# Microsoft Report Viewer 2010 Redistributable Package

Microsoft Report Viewer control enables applications that run on the .NET Framework to display reports designed using Microsoft reporting technology. This redistributable package contains Windows and Web versions of the Report Viewer.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

A binary package containing the ReportViewer assemblies

## Usage

Consuming applications will need to have .NET 4 installed to consume these assemblies. You will also need to update your ".csproj" to point to the packaged Report Viewer assemblies you need to reference.

For example, to refernce the `Microsoft.ReportViewer.WebForms` assembly you can include this in your application's plan:

```
    $csprojPath = "MyApp.csproj"

    $proj = [xml](get-content $csprojPath)
    $assemblyHintPathNode = $proj.CreateElement("HintPath", "http://schemas.microsoft.com/developer/msbuild/2003")
    $assemblyHintPath = "$(Get-HabPackagePath reportviewer2010)\bin\Microsoft.ReportViewer.WebForms.dll"
    $assemblyHintPathNode.InnerText = $assemblyHintPath
    $proj.GetElementsByTagName("Reference") | foreach {
        if($_.StartsWith('Microsoft.ReportViewer.WebForms.dll')){
            $_.AppendChild($assemblyHintPathNode)
        }
    }
    $proj.Save($csprojPath)
```
