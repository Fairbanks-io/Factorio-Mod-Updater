#!/bin/bash

# Colors
RED='\033[0;91m';
GREEN='\033[0;92m';
YELLOW='\033[0;93m';
NC='\033[0m';

dir=$(pwd)
if [[ -e "$dir/mods/mod-list.json" ]]; then
	readarray -t arr < <(jq -c '.[] | .[] | .name' $dir/mods/mod-list.json | tr -d \");
	total=$(jq -r ".[]" $dir/mods/mod-list.json | jq length);
	count=0;
else
	echo -e "${RED}mods/mod-list.json not found${NC}";
	sleep 3;
	exit;
fi

echo -e "${YELLOW}Downloading $total Factorio Mods listed in mod-list.json...${NC}";
sleep 3;

mkdir -p mods;

for mod in "${arr[@]:1}"; 
do 
	base_url="https://mods.factorio.com/api/mods/$mod";
	download_url=$(curl --silent $base_url | jq -r '.releases | .[-1] | select( .info_json.factorio_version == "0.17" ) | .download_url');
	file_name=$(curl --silent $base_url | jq -r '.releases | .[-1] | select( .info_json.factorio_version == "0.17" ) | .file_name');
	if [ "$download_url" != "" ] && [ "$download_url" != "null" ]
	then
		wget -bqc -nc --quiet "https://mods.factorio.com/$download_url" -O "mods/$file_name" > /dev/null 2>&1;
		echo -e "\xF0\x9F\x96\xAB Downloaded: $file_name";
		count=$((count + 1));
	else
		echo -e "${RED}\xE2\x9D\x8C Unable to find a suitable download for $mod${NC}"
	fi
done

sleep 3;
echo -e "${GREEN}\xE2\x9C\x94 [Done]${NC} $count of $total Factorio Mods Downloaded!";

exit;