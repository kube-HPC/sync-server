#!/bin/bash
cp /syncthing/configOrg/config.xml /var/syncthing/config/config.xml
/syncthing/syncthing -home /var/syncthing/config -gui-apikey hkubectl