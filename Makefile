shapepath=/usr/share/shapefile/naturalearth/
encoding=utf8
projection=3857

# dl url name proj encoding
define dl=
	test -f $2.zip||wget -O $2.zip $1
	test -d $2||(mkdir $2 && cd $2 && unzip ../$2.zip)
	$(eval proj_path=$2_$3_$4)
	test -d $(proj_path)||mkdir $(proj_path)
	/bin/bash reproj_and_encode.sh $2 $3 $4
endef

define ins=
	install $1/*.sh[px] $1/*.dbf $1/*.prj $(DESTDIR)$(shapepath)
endef

themes=10m-physical 10m-cultural_populated_places 110m-physical 110m-cultural


all: $(themes)
10m-physical:
	$(call dl,http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/10m_physical.zip,$@,$(projection),$(encoding))
10m-cultural_populated_places:
	$(call dl,http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places.zip,$@,$(projection),$(encoding))
110m-physical:
	$(call dl,http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/physical/110m_physical.zip,$@,$(projection),$(encoding))
110m-cultural:
	$(call dl,http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip,$@,$(projection),$(encoding))

install: $(themes)
	install -d $(DESTDIR)$(shapepath)
	$(call ins,10m-physical_$(projection)_$(encoding))
	$(call ins,10m-cultural_populated_places_$(projection)_$(encoding))
	$(call ins,110m-physical_$(projection)_$(encoding))
clean:
	rm -rf $(themes)
	rm -rf *_$(projection)_$(encoding)
