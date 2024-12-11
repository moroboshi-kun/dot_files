#!/usr/bin/env bash

# ===========================================
# script to quickly copy Unity unit 
# testing framework files to a directory
# so I don't have to keep messing around
# ===========================================

UNITY_REPO="https://github.com/ThrowTheSwitch/Unity.git"
REPO_DIR="/home/mike/repos/tools"
UNITY_DIR="Unity"
FILE1="${REPO_DIR}/${UNITY_DIR}/src/unity.c"
FILE2="${REPO_DIR}/${UNITY_DIR}/src/unity.h"
FILE3="${REPO_DIR}/${UNITY_DIR}/src/unity_internals.h"
UNITY_ARCHIVE="unity.framework.tar.gz"
# UNITY_DIR="/home/mike/archive"
# UNITY_FILE="unity.framework.tar.gz"
CWD=$(pwd)

if [[ -d ${REPO_DIR} ]]; then 
  if [[ ! -d ${REPO_DIR}/${UNITY_DIR} ]]; then
    echo "Cloning repository..."
    git clone ${UNITY_REPO} ${REPO_DIR}/${UNITY_DIR}
    sleep 2
    echo "Creating file archive..."
    tar czvf ${UNITY_ARCHIVE} -C ${REPO_DIR}/${UNITY_DIR}/src unity.c unity.h unity_internals.h
    echo "Unpacking files..."
    tar xzf ${UNITY_ARCHIVE}
    rm ${UNITY_ARCHIVE}
    echo "Finished!"
  else
    cd ${REPO_DIR}/${UNITY_DIR}
    echo "Making sure repository is up to date..."
    git pull
    sleep 2
    cd -
    echo "Creating file archive..."
    tar czvf ${UNITY_ARCHIVE} -C ${REPO_DIR}/${UNITY_DIR}/src unity.c unity.h unity_internals.h
    echo "Unpacking files..."
    tar xzf ${UNITY_ARCHIVE}
    rm ${UNITY_ARCHIVE}
    echo "Finished!"
  fi
else
  echo "Unity directory does not exits..."
  echo "I will create it now..."
  mkdir ${REPO_DIR}
  echo "Try running $(basename ${0}) again."
fi
