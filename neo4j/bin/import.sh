#!/bin/bash

# calculate path to directory
# https://stackoverflow.com/a/630645
prg=$0
if [ ! -e "$prg" ]; then
  case $prg in
    (*/*) exit 1;;
    (*) prg=$(command -v -- "$prg") || exit;;
  esac
fi
dir=$(
  cd -P -- "$(dirname -- "$prg")" && pwd -P
) || exit
prg=$dir/$(basename -- "$prg") || exit 

# select docker container
echo "Select running neo4j docker container." 
echo "(If none are running, you're SOL.)"

PS3="What container should we import to?"
QUIT="QUIT THIS PROGRAM - I feel safe now."
touch "/tmp/$QUIT"

# set string to one line with spaces
containers=$(docker container ls -a --format "{{.Names}}"| sed -e ':a' -e 'N;$!ba' -e 's/\n/ /g')

# select container from containers array
select CONTAINER in $containers; do
break
done

# import seed-example.cypher into container
cat $dir/../cypher/seed-example.cypher | docker exec -i $CONTAINER cypher-shell -u neo4j -p letmein ;

# cleanup
rm "/tmp/$QUIT"