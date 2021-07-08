#!/bin/zsh
size=$1

rm -rf ./build/*
echo "Compile"
time (zokrates compile -i main.zok -o build/out -s build/abi.json)

echo "\nSetup"
time (zokrates setup -i build/out -p build/proving.key -v build/verification.key)

echo "\nWitness"
time (zokrates compute-witness -i build/out -o build/witness -s build/abi.json -a $(echo {1..$size}))

echo "\nProof"
time (zokrates generate-proof -i build/out -p build/proving.key -w build/witness -j build/proof.json)