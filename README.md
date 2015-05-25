# hefner-postgis-v1
Docker configuration for a PostGIS 2.3/PostgreSQL-9.4 server containing data for the United Kingdom

## Building the image

To configure the base system, run `docker build .` Docker should emit something like the following as its final line:
<pre>Successfully built 42d950a4740d</pre>.

If it did not, [open an issue](https://github.com/Sentimentron/hefner-postgis-v1/issues).

### Loading data into the image
1. Install `osm2pgsql` on a host computer
2. Download some `.pbf` files from [GeoFabrik](http://www.geofabrik.de/data/download.html) or similar.
3. Identify the Docker container with `docker images`, or by re-using the "successfully built" code from earlier.
3. Start the Docker container with `docker run -p 5455:5432 -d 42d950a4740d`.
4. Use `docker ps` to retrieve the container ID.
4. Grab the Docker IP address with `docker inspect <container_id> | grep IPAddress` 
4. Use `osm2pgsql` to load the data, for example `osm2pgsql -s -C 15000 -U gis -W -H 172.17.0.52 -P 5455 -I great-britain-latest.osm.pbf`. Type `gis` when promtped for the password. This step may take a long time.
5. Run `docker commit` to get a push-able image.

