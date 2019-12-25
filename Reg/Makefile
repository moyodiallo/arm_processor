GHDL = /home/jeanlou/Outils/ghdl/bin/ghdl
all :
	ghdl -a -v --ieee=synopsys -fexplicit reg.vhdl
	ghdl -a -v --ieee=synopsys -fexplicit reg_tb.vhdl
	ghdl -e -v --ieee=synopsys -fexplicit reg_tb
	ghdl -r --ieee=synopsys -fexplicit reg_tb --vcd=reg.vcd
