#!/bin/bash
#
# Functions related to RVM workflow for precompiled rubies

# Remove every RVM dependencies like symlinks to RVM folders in the downloaded
# ruby folder.
remove_rvm_dependencies() {
  local ruby_folder=$1
  unlink_rvm_rubygems_cache $ruby_folder
}

# RVM cache gems downloaded by rubygems in '/usr/local/rvm/gems/cache' for
# every versions of ruby.
# This function remove the link between rubygems cache and RVM gems cache.
unlink_rvm_rubygems_cache() {
  local ruby_folder=$1
  local cache_folder="${ruby_folder}/lib/ruby/gems/*/cache"
  if [ -L $cache_folder ]; then
    if [ "$(readlink $cache_folder)" == "/usr/local/rvm/gems/cache" ]; then
      cache_folder=$(ls $cache_folder)
      rm --force $cache_folder && mkdir $cache_folder
    fi
  fi
}
