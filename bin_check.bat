ECHO "CHECK BIN FILES ..."
ruby BinCheck.rb /c 2096-RAM.BIN 2096_16K.bin 2048 16383
ruby BinCheck.rb /x 2096-RAM.BIN 0x7f8 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0x4000 200 0
ruby BinCheck.rb /x 2096-RAM.BIN 0x7000 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0x8FF6 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0x9000 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0x9FF6 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0xAFF6 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0xBFF6 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0xCFF6 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0xDFF6 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0xEFF6 8 0
ruby BinCheck.rb /x 2096-RAM.BIN 0xFFF6 8 0