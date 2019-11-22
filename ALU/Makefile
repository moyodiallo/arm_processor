GHDL = /home/jeanlou/Outils/ghdl/bin/ghdl
all :
	ghdl -a -v --ieee=synopsys -fexplicit Alu.vhdl
	ghdl -a -v --ieee=synopsys -fexplicit Alu_tb.vhdl
	ghdl -e -v --ieee=synopsys -fexplicit Alu_tb
	ghdl -r --ieee=synopsys -fexplicit Alu_tb --vcd=Alu.vcd
