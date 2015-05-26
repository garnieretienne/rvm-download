#!/bin/bash
#
# General functions used by the primary binary

check_url() {
  url=$1
  curl --output /dev/null --silent --head --fail $url
}

download_and_extract_package() {
  url=$1
  dst=$2
  curl -C - -qsSLf $url | tar xj --directory $dst
}

erase_folder_if_exist() {
  folder=$1
  rm -rf $folder
}

rename_folder_if_exist() {
  src=$1
  dst=$2
  if [[ -d $src ]]; then
    mv $1 $2
  fi
}

ensure_folder_exists() {
  folder=$1
  mkdir --parents $folder
}
