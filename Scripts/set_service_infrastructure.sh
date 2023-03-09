#!/usr/bin/env bash
set -e
set -x

OLD_PWD=${PWD}

service_name=$1
stage=$2

cd $PROJECT_DIR/$service_name

for comp in $(ls -1 components); do
    cd components/$comp
    ln -sf $PROJECT_DIR/input/${service_name}_infrastructure_${stage}.yml infrastructure.yml
    cd ../../
done

