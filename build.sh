mkdir build
cp Exec/exec.vhdl       build/exec.vhdl
cp Makefile.txt         build/Makefile
cp Ram/ram.vhdl         build/ram.vhdl
cp Icache/icache.vhdl   build/icache.vhdl
cp Dcache/dcache.vhdl   build/decache.vhdl
cp Main/main_tb.vhdl    build/main_tb.vhdl
cp Core/arm_core.vhdl   build/arm_core.vhdl
cp Ifetch/ifetch.vhdl   build/ifetch.vhdl
cp Decod/decod.vhdl     build/decod.vhdl
cp Reg/reg.vhdl         build/reg.vhdl
cp Fifo/fifo_72b.vhdl   build/fifo_72b.vhdl
cp Fifo/fifo_127b.vhdl  build/fifo_127b.vhdl
cp Fifo/fifo_32b.vhdl   build/fifo_32b.vhdl
cp ALU/alu.vhdl         build/alu.vhdl
cp Shifter/shifter.vhdl build/shifter.vhdl
cp Mem/mem.vhdl         build/mem.vhdl
cd build
echo "You can makefile and must have 'ghdl' command"