mkdir build
cp -v Exec/exec.vhdl       build/exec.vhdl
cp -v Makefile.txt         build/Makefile
cp -v Ram/ram.vhdl         build/ram.vhdl
cp -v Icache/icache.vhdl   build/icache.vhdl
cp -v Dcache/dcache.vhdl   build/decache.vhdl
cp -v Main/main_tb.vhdl    build/main_tb.vhdl
cp -v Core/arm_core.vhdl   build/arm_core.vhdl
cp -v Ifetch/ifetch.vhdl   build/ifetch.vhdl
cp -v Decod/decod.vhdl     build/decod.vhdl
cp -v Reg/reg.vhdl         build/reg.vhdl
cp -v Fifo/fifo_72b.vhdl   build/fifo_72b.vhdl
cp -v Fifo/fifo_127b.vhdl  build/fifo_127b.vhdl
cp -v Fifo/fifo_32b.vhdl   build/fifo_32b.vhdl
cp -v ALU/alu.vhdl         build/alu.vhdl
cp -v Shifter/shifter.vhdl build/shifter.vhdl
cp -v Mem/mem.vhdl         build/mem.vhdl
cd
echo "You can makefile and must have 'ghdl' command"