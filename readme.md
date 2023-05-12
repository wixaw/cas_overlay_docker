
# CAS 

## Init 
```
mkdir -p /local/cas/compose/
cd /local/cas/compose/

git clone --recursive git@github.com:wixaw/cas_overlay_docker.git .

#replaces keys in
custom.d/etc/cas/config/cas.properties
```

## Build project 
```
chmod +x ./update_cas-overlay-template.sh
./update_cas-overlay-template.sh
```

## Theme custom
```
mkdir -p extract_war/war/
mkdir -p extract_war/thymeleaf/
docker cp cas:/cas-overlay/cas.war extract_war/war/cas.war
unzip cas.war
cp ./WEB-INF/lib/cas-server-support-thymeleaf-6* extract_war/thymeleaf/
cd  extract_war/thymeleaf/
unzip cas-server-support-thymeleaf-*.jar
#take need file and paste to custom.d/custom_theme, exemple : 
cp cas-server-support-thymeleaf-6.6.6/messages_fr.properties  custom.d/custom_theme/src/main/resources/
# apply ( rsync + rebuild )
./update_cas-overlay-template.sh

```


## Update
### Minor  6.6.6 to 6.6.7
```
git pull
git submodule deinit --all -f
git submodule update --init
cat cas-overlay-template/gradle.properties | grep version
# > version=6.6.7
git status

# diff to existe for see modifications 
vimdiff cas-overlay-template/log4j2.xml custom.d\etc\cas\config/log4j2_custom.xml
vimdiff cas-overlay-template/build.gradle custom.d\build.gradle

./update_cas-overlay-template.sh
```
### Major 6.6.x to 6.7.x
```
# set num version in .gitmodule
[submodule "cas-overlay-template"]
	path = cas-overlay-template
	url = https://github.com/apereo/cas-overlay-template
    branch = 6.7

git pull
git submodule deinit --all -f
git submodule update --init
cat cas-overlay-template/gradle.properties | grep version
# > version=6.7.x
git status

# diff to existe for see modifications 
vimdiff cas-overlay-template/log4j2.xml custom.d\etc\cas\config/log4j2_custom.xml
vimdiff cas-overlay-template/build.gradle custom.d\build.gradle

./update_cas-overlay-template.sh
```