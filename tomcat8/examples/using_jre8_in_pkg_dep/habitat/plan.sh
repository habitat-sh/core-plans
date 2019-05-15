# source the core/tomcat8 plan
. "../../../plan.sh"

# add core/jre8, the one of 4 possible java dependencies
pkg_deps+=(core/jre8)
