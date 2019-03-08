#!/bin/bash

# Colors
GREEN='\033[0;32m';
NC='\033[0m';

readarray -t arr < <(jq -c '.[] | .[] | .name' mod-list.json | tr -d \");
total=$(jq -r ".[]" mod-list.json | jq length);
count=1; # Start at 1 since "base" won't ever need downloaded

echo "Downloading $total Factorio Mods listed in mod-list.json...";
sleep 2;

mkdir -p mods;

for mod in "${arr[@]}"; 
	do 
		echo "Found: $mod";
		base_url="https://mods.factorio.com/api/mods/$mod";
		download_url=$(curl --silent $base_url | jq -r '.releases | .[0].download_url');
		file_name=$(curl --silent $base_url | jq -r '.releases | .[0].file_name');
		if [ "$download_url" != "null" ]
		then
			wget -nc --quiet "https://mods.factorio.com/$download_url" -O "mods/$file_name";
			echo "Downloaded: $file_name";
			count=$((count + 1));
		fi
	done

echo -e "${GREEN}[Success]${NC} $count of $total Factorio Mods Downloaded!";

exit;