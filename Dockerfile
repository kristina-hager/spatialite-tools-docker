##working on spatialite docker

FROM ubuntu:15.10

MAINTAINER Kristina Hager

RUN apt-get update
RUN apt-get install --yes libspatialite-dev spatialite-bin

COPY /Users/kristina/Desktop/GIS_project/GIS_data 

CMD spatialite --version
