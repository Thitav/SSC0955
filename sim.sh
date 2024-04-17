mkdir -p ./out
./bin/mnt $1 ./out/$1.mif && ./bin/sim ./out/$1.mif ./bin/charmap.mif
