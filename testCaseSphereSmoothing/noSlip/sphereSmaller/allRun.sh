#!/bin/bash
#SBATCH -p batch
#SBATCH -t 2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --mail-user=p969f559@wichita.edu
#SBATCH --mail-type=end

module load openfoam/v2112 

rm -r 100 200 300 400 500 pro*
blockMesh
decomposePar
mpirun -np 32 snappyHexMesh -overwrite -parallel
reconstructParMesh -constant
rm -r pro*
decomposePar
mpirun -np 32 simpleFoam -parallel
reconstructPar


