# sql-dmo

## As of 2021-06-09, this package is no longer supported or updated. Microsoft SQL Server 2005 Backward Compatibility package is no longer maintained by Microsoft.

SQL Server Distributed Management Objects from the Microsoft SQL Server 2005 Backward Compatibility package. This package is used by applications that need to access SQL Server 2005's management object APIs.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

A Binary package containing the sql-dmo COM component

## Usage

Consuming applications will need to register the `sqldmo.dll` with the COM registry in their `init` hook:

```
."$env:SystemRoot\SysWow64\regsvr32.exe" /s "{{pkgPathFor "core/sql-dmo"}}\Program Files (x86)\Microsoft SQL Server\80\Tools\Binn\sqldmo.dll"
```

**Note:** If you have set the `HAB_FEAT_INSTALL_HOOK` environment variable, then the `install` hook packaged with this plan should automatically register the COM entries upon installation.
