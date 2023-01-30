#!/bin/bash
set -e

sudo apt install p7zip-full

bucket_name=$(cat config)
aws s3api create-bucket --bucket $bucket_name --acl private

data_directory="data"

FILE=ai.stackexchange.com.7z
if [ -f "$FILE" ]; then
    echo "$FILE already exists."
else 
    wget https://archive.org/download/stackexchange/ai.stackexchange.com.7z
fi

7z x ai.stackexchange.com.7z -o$data_directory

aws s3 sync $data_directory s3://$bucket_name/$data_directory
