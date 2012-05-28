#!/bin/bash

# Arguments:
## $1: R install root directory (e.g. /usr/local/bin/)
## $2: R library root (e.g. /usr/local/lib64) 
## $3: string argument for --with-blas arg to make
## $4: R package upgrade script location (full path)

## Sample: ./upgrade_R.sh /usr/local/bin /home/username/admin/R-2.15.tar.gz "-L/usr/local/lib64 -lgoto -lpthreads" /home/username/admin/R_package_upgrade.R

## Designed to be run in the directory containing the 
## following files:
## The R source tar.gz file
## The Rmpi source tar.gz file
## The doMPI source tar.gz file

## Get the old version
old_version=`R --version |  grep -o '[0-9]*\.[0-9]*\.[0-9]*'`
new_version=`ls | grep R | grep -v mpi | grep -v sh`

echo "Old version:"
echo $old_version
echo "New version:"
echo $new_version

## Move the old files to backup files

old_version_name="R_"$old_version
old_script_version_name="Rscript_"$old_version
echo $old_version_name
echo $old_script_version_name

sudo mv $1/R $1/$old_version_name
sudo mv $1/Rscript $1/$old_script_version_name
sudo mv $2/R $2/$old_version_name

echo "Old versions moved to backup"

## Configure and compile R

## Untar the source tarball and move into that directory
tar -xvf $new_version
new_version_dir=`ls | grep R | grep -v mpi | grep -v .sh`
echo "Moving to source directory"
echo $new_version_dir
cd $new_version_dir

## Configure R.
## Note what this assumes about the location of GOTO BLAS
./configure --with-x --disable-R-profiling --with-blas=$3
echo "Configure done"

make
make check

echo "Make complete"
echo "Make install starting"
sudo make install

echo "Install complete"

## Get out of the R source directory
cd ..

## Install the package set
## Change the location of the script as need be
sudo R CMD BATCH $4

echo "Done installing R"


