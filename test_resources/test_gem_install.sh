#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMP_DIR=$SCRIPT_DIR/temp/test_gem_install

rm -Rf $TEMP_DIR 2>&1 > /dev/null
mkdir -p $TEMP_DIR
export GEM_HOME=$TEMP_DIR

gem build ios_dev_tools.gemspec
gem install ios_dev_tools