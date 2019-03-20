# libmaxminddb

C library for the MaxMind DB file format

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary and library package

## Usage

This package includes The GeoLite2 City, Country, And ASN mmdb files.

Example usage:

```
mmdblookup --file $(hab pkg path core/libmaxminddb)/share/GeoIP/GeoLite2-City_20190409/GeoLite2-City.mmdb --ip 8.8.8.8
mmdblookup --file $(hab pkg path core/libmaxminddb)/share/GeoIP/GeoLite2-Country_20190409/GeoLite2-Country.mmdb --ip 8.8.8.8
mmdblookup --file $(hab pkg path core/libmaxminddb)/share/GeoIP/GeoLite2-ASN_20190402/GeoLite2-ASN.mmdb --ip 8.8.8.8
```

## Included GeoLite data

This product includes GeoLite data created by MaxMind, available from [http://www.maxmind.com](http://www.maxmind.com).
