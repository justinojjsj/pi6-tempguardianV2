#!/bin/bash

db_dir="/home/silvajunior/Área de trabalho/desenvolvimento/pi6-tempguardianV2/"
cd "$db_dir"
FileName=$(date '+%Y_%m_%d-%H_%M_%S')

git checkout updateDB
git add --all
git commit -a -m "Atualização do banco $FileName"
git push