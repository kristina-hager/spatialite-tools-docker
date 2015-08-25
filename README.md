# spatialite-tools-docker

One way you can use this Docker container is to run spatialite command-line tools interactively.
I use this to avoid the hassle of settings things up on my personal laptop.

Here's an example scenario:
Download some shapefiles to your desktop to a path like:
~/Desktop/GIS_project/GIS_data/Single_Member_Council_Districts

Invoke the container like this giving the docker read only access to those shapefiles:
docker run -v ~/Desktop/GIS_project/GIS_data/Single_Member_Council_Districts:/mnt:ro -i -t docker-spatialite /bin/bash

Once the container has started, here are some example commands. Please see spatialite docs for more options and explanations:
spatialite city_districts.sqlite
.loadshp /mnt/single_member_districts districts cp1252 2277
docs: https://www.gaia-gis.it/fossil/libspatialite/wiki?name=tools-4.0
========
Loading shapefile at '/mnt/single_member_districts' into SQLite table 'districts'

BEGIN;
CREATE TABLE "districts" (
"PK_UID" INTEGER PRIMARY KEY AUTOINCREMENT,
"SINGLE_MEM" INTEGER,
"CREATED_DA" DOUBLE,
"CREATED_BY" TEXT,
"MODIFIED_D" DOUBLE,
"MODIFIED_B" TEXT,
"COUNCIL_DI" INTEGER,
"SHAPE_AREA" DOUBLE,
"SHAPE_LEN" DOUBLE);
SELECT AddGeometryColumn('districts', 'Geometry', -1, 'MULTIPOLYGON', 'XY');
COMMIT;

Inserted 10 rows into 'districts' from SHAPEFILE
select * from districts;
1|1|2456810.5|meekss|2457219.5|DrescherA|1|1272664566.63|599544.609967|
2|2|2456810.5|meekss|2457219.5|DrescherA|2|1263833912.62|680488.027708|
3|3|2456810.5|meekss|2456810.5|meekss|3|502791105.936|153982.266685|
4|4|2456810.5|meekss|2456810.5|meekss|4|330875387.854|105092.713667|
5|5|2456810.5|meekss|2457219.5|DrescherA|5|660839756.698|342350.0903|
6|6|2456810.5|meekss|2456810.5|meekss|6|1374405322.5|749161.180799|
7|7|2456810.5|meekss|2456810.5|meekss|7|782497876.307|285534.759773|
8|8|2456810.5|meekss|2457219.5|DrescherA|8|1219474429.14|495355.425095|
9|9|2456810.5|meekss|2456810.5|meekss|9|348217049.758|135780.24555|
10|10|2456810.5|meekss|2457219.5|DrescherA|10|1193325385.08|456486.67025|

select * from districts where within(ST_Transform(GeomFromText('POINT(-97.837543 30.418986)', 4326), 2277),districts.Geometry);
6|6|2456810.5|meekss|2456810.5|meekss|6|1374405322.5|749161.180799|
