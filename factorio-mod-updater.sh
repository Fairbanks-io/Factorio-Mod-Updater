#!/bin/bash

# Colors
RED='\033[0;31m';
GREEN='\033[0;32m';
NC='\033[0m';

dir=$(pwd)
if [[ -e "$dir/mods/mod-list.json" ]]; then
	readarray -t arr < <(jq -c '.[] | .[] | .name' $dir/mods/mod-list.json | tr -d \");
	total=$(jq -r ".[]" $dir/mods/mod-list.json | jq length);
	count=0;
else
	echo -e "${RED}mods/mod-list.json not found${NC}";
	sleep 2;
	exit;
fi

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
		wget -bqc -nc --quiet "https://mods.factorio.com/$download_url" -O "mods/$file_name" > /dev/null 2>&1;
		echo "Downloaded: $file_name";
		count=$((count + 1));
	else
		echo -e "${RED}Unable to find a suitable download for $mod${NC}"
	fi
done

sleep 2;
echo -e "${GREEN}[Done]${NC} $count of $total Factorio Mods Downloaded!";

exit;