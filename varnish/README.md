## Varnish

  A caching HTTP reverse proxy that can be found at https://www.varnish-cache.org/
It is primarily used for accelerating traffic from HTTP endpoint. The currently packaged version is 5.1.2

## About this plan
  This plan will provide a basic proxied/cache solution but by default it only exposes a minimum
set of configuration options. As varnish is highly configurable through VCL, the best way to
fully support your configuration is to import this plan into a new plan and provide your own vcl
configuration file

## Example usage
- `hab plan init myvarnish`
- Include this plan in `pkg_deps` in plan.sh
- Add your VCL file to the plan
- If you've changed the default file name you'll have to pass `files.vcl=newFileName`

## HA Considerations
HA Varnish is a separate product from the Varnish team but you can coordinate multiple Varnish servers in your VCL file by asking the supervisor for information about other service members. Because your vcl file will be pre-parsed via Handlebars, you can query for information from other service members.


### TODO

The plan currently builds varnish from source but one of the dependencies, Sphinx is being
installed in the prepare stage via `pip` and it should be moved to a core plan
