mkdir -p ./out
cat ./stream.s ./string.s ./io.s > ./out/lib.s
./bin/mnt ./out/lib.s ./out/lib.mif && ./bin/sim ./out/lib.mif ./bin/charmap.mif
