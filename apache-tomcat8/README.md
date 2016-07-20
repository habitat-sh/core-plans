# Habitat Plan for packaging up Apache Tomcat 8.x

This Habitat Plan is one of potentially many plans that produce Habitat packages for Apache Tomcat.
This particular plan focuses on the Tomcat 8 major release, specifically version 8.5.3.
If a Habitat Plan is needed for Apache Tomcat 7.x or the upcoming
Apache Tomcat 9, this plan can be forked and used as a starting point for those versions.

This plan uses configuration templates from the Tomcat 8.5.x release and, as such, is exclusive to that release of Tomcat.

Most other files (start up hooks, deployment directories, etc) have remained fairly consistent across major Tomcat releases
although this could change in the future.

Because of all this, the model is that there should be a Habitat Plan for each major release of Tomcat:

|Tomcat Version|Habitat Plan|Status|
|---|---|---|
|Tomcat 9|core/apache-tomcat9|To be developed|
|Tomcat 8|core/apache-tomcat8|Version 8.5.3 supported|
|Tomcat 7|core/apache-tomcat7|To be developed|
