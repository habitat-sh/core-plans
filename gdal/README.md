[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.gdal?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=109&branchName=master)

# gdal

GDAL is a translator library for raster and vector geospatial data formats that is released under an X/MIT style.  See [documentation](https://gdal.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/gdal as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/gdal)

##### Runtime dependency

> pkg_deps=(core/gdal)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/gdal --binlink``

will add the following binaries to the PATH:

* /bin/gdal-config
* /bin/gdal_contour
* /bin/gdal_grid
* /bin/gdal_rasterize
* /bin/gdal_translate
* /bin/gdaladdo
* /bin/gdalbuildvrt
* /bin/gdaldem
* /bin/gdalenhance
* /bin/gdalinfo
* /bin/gdallocationinfo
* /bin/gdalmanage
* /bin/gdalserver
* /bin/gdalsrsinfo
* /bin/gdaltindex
* /bin/gdaltransform
* /bin/gdalwarp
* /bin/gnmanalyse
* /bin/gnmmanage
* /bin/nearblack
* /bin/ogr2ogr
* /bin/ogrinfo
* /bin/ogrlineref
* /bin/ogrtindex
* /bin/testepsg


For example:

```bash
$ hab pkg install core/gdal --binlink» Installing core/gdal
☁ Determining latest version of core/gdal in the 'stable' channel
→ Found newer installed version (core/gdal/2.4.0/20200603152237) than remote version (core/gdal/2.4.0/20200319195235)
→ Using core/gdal/2.4.0/20200603152237
★ Install of core/gdal/2.4.0/20200603152237 complete with 0 new packages installed.
» Binlinking gnmanalyse from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gnmanalyse from core/gdal/2.4.0/20200603152237 to /bin/gnmanalyse
» Binlinking gdal-config from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdal-config from core/gdal/2.4.0/20200603152237 to /bin/gdal-config
» Binlinking gdalenhance from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdalenhance from core/gdal/2.4.0/20200603152237 to /bin/gdalenhance
» Binlinking gdallocationinfo from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdallocationinfo from core/gdal/2.4.0/20200603152237 to /bin/gdallocationinfo
» Binlinking gnmmanage from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gnmmanage from core/gdal/2.4.0/20200603152237 to /bin/gnmmanage
» Binlinking ogrinfo from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked ogrinfo from core/gdal/2.4.0/20200603152237 to /bin/ogrinfo
» Binlinking gdaltransform from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdaltransform from core/gdal/2.4.0/20200603152237 to /bin/gdaltransform
» Binlinking gdal_contour from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdal_contour from core/gdal/2.4.0/20200603152237 to /bin/gdal_contour
» Binlinking gdaldem from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdaldem from core/gdal/2.4.0/20200603152237 to /bin/gdaldem
» Binlinking gdalsrsinfo from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdalsrsinfo from core/gdal/2.4.0/20200603152237 to /bin/gdalsrsinfo
» Binlinking ogrlineref from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked ogrlineref from core/gdal/2.4.0/20200603152237 to /bin/ogrlineref
» Binlinking ogrtindex from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked ogrtindex from core/gdal/2.4.0/20200603152237 to /bin/ogrtindex
» Binlinking ogr2ogr from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked ogr2ogr from core/gdal/2.4.0/20200603152237 to /bin/ogr2ogr
» Binlinking gdalbuildvrt from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdalbuildvrt from core/gdal/2.4.0/20200603152237 to /bin/gdalbuildvrt
» Binlinking gdal_rasterize from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdal_rasterize from core/gdal/2.4.0/20200603152237 to /bin/gdal_rasterize
» Binlinking gdaltindex from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdaltindex from core/gdal/2.4.0/20200603152237 to /bin/gdaltindex
» Binlinking gdalinfo from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdalinfo from core/gdal/2.4.0/20200603152237 to /bin/gdalinfo
» Binlinking gdaladdo from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdaladdo from core/gdal/2.4.0/20200603152237 to /bin/gdaladdo
» Binlinking gdalwarp from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdalwarp from core/gdal/2.4.0/20200603152237 to /bin/gdalwarp
» Binlinking gdal_grid from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdal_grid from core/gdal/2.4.0/20200603152237 to /bin/gdal_grid
» Binlinking gdalmanage from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdalmanage from core/gdal/2.4.0/20200603152237 to /bin/gdalmanage
» Binlinking nearblack from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked nearblack from core/gdal/2.4.0/20200603152237 to /bin/nearblack
» Binlinking gdal_translate from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdal_translate from core/gdal/2.4.0/20200603152237 to /bin/gdal_translate
» Binlinking testepsg from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked testepsg from core/gdal/2.4.0/20200603152237 to /bin/testepsg
» Binlinking gdalserver from core/gdal/2.4.0/20200603152237 into /bin
★ Binlinked gdalserver from core/gdal/2.4.0/20200603152237 to /bin/gdalserver
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/gdalenhance --help`` or ``gdalenhance --help``

```bash
$ gdalenhance --help
Option --help incomplete, or not recognised.

Usage: gdalenhance [--help-general]
       [-of format] [-co "NAME=VALUE"]*
       [-ot {Byte/Int16/UInt16/UInt32/Int32/Float32/Float64/
             CInt16/CInt32/CFloat32/CFloat64}]
       [-equalize]
       [-config filename]
       src_dataset dst_dataset

GDAL 2.4.0, released 2018/12/14
```
