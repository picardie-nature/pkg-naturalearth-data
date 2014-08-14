#!/bin/bash

# GDAL Driver 
# http://www.gdal.org/drv_shapefile.html

# original encoding of ne files
export SHAPE_ENCODING=CP1252

# skip out of projection area objects
export OGR_ENABLE_PARTIAL_REPROJECTION=True

mydestdir=$1_$2_$3
for shp in $(find $1/*.shp); do
	destfile=$mydestdir/`basename $shp`
	echo -n "$shp -> $destfile"
	ogr2ogr -lco ENCODING=$3 -t_srs EPSG:$2 $destfile $shp
	echo "."
done
