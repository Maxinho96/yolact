#!/bin/bash

start=`date +%s`

# handle optional download dir
if [ -z "$1" ]
  then
    # navigate to ./data
    echo "navigating to ./data/ ..."
    mkdir -p ./data
    cd ./data/
    mkdir -p ./coco
    cd ./coco
    mkdir -p ./images
    mkdir -p ./annotations
  else
    # check if specified dir is valid
    if [ ! -d $1 ]; then
        echo $1 " is not a valid directory"
        exit 0
    fi
    echo "navigating to " $1 " ..."
    cd $1
fi

if [ ! -d images ]
  then
    mkdir -p ./images
fi

cd ./images
# Download the val images.
echo "Downloading MSCOCO val images ..."
curl -LO http://images.cocodataset.org/zips/val2017.zip
# Unzip the val images.
echo "Extracting val images ..."
unzip -qqj val2017.zip
# Delete val images zip file.
echo "Removing val zip file ..."
rm val2017.zip

cd ../
if [ ! -d annotations ]
  then
    mkdir -p ./annotations
fi

# Download the annotation data.
cd ./annotations
echo "Downloading MSCOCO train/val annotations ..."
curl -LO http://images.cocodataset.org/annotations/annotations_trainval2014.zip
curl -LO http://images.cocodataset.org/annotations/annotations_trainval2017.zip
echo "Finished downloading. Now extracting ..."

# Unzip annotation data
echo "Extracting annotations ..."
unzip -qqd .. ./annotations_trainval2014.zip
unzip -qqd .. ./annotations_trainval2017.zip

# Delete annotazion zip files
rm ./annotations_trainval2014.zip
rm ./annotations_trainval2017.zip


end=`date +%s`
runtime=$((end-start))

echo "Completed in " $runtime " seconds"
 
