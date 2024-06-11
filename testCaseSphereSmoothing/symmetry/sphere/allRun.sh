#!/bin/bash
#SBATCH -p bigmem
#SBATCH -t 3:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --mail-user=p969f559@wichita.edu
#SBATCH --mail-type=end

module load openfoam/v2112 
surfaceFeatureExtract
rm -r 100 200 300 400 500 pro*
blockMesh
decomposePar
mpirun -np 32 snappyHexMesh -overwrite -parallel
reconstructParMesh -constant
rm -r pro*
decomposePar
mpirun -np 32 simpleFoam -parallel
reconstructPar


