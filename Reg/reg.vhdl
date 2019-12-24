library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Reg is
	port(
	-- Write Port 1 prioritaire--
		wdata1		: in Std_Logic_Vector(31 downto 0);
		wadr1			: in Std_Logic_Vector(3 downto 0);
		wen1			: in Std_Logic;

	-- Write Port 2 non prioritaire--
		wdata2		: in Std_Logic_Vector(31 downto 0);
		wadr2			: in Std_Logic_Vector(3 downto 0);
		wen2			: in Std_Logic;

	-- Write CSPR Port--
		wcry			: in Std_Logic;
		wzero			: in Std_Logic;
		wneg			: in Std_Logic;
		wovr			: in Std_Logic;
		cspr_wb			: in Std_Logic;
		
	-- Read Port 1 32 bits--
		reg_rd1		: out Std_Logic_Vector(31 downto 0);
		radr1			: in Std_Logic_Vector(3 downto 0);
		reg_v1		: out Std_Logic;

	-- Read Port 2 32 bits--
		reg_rd2		: out Std_Logic_Vector(31 downto 0);
		radr2			: in Std_Logic_Vector(3 downto 0);
		reg_v2		: out Std_Logic;

	-- Read Port 3 32 bits--
		reg_rd3		: out Std_Logic_Vector(31 downto 0);
		radr3			: in Std_Logic_Vector(3 downto 0);
		reg_v3		: out Std_Logic;

	-- read CSPR Port--
		reg_cry		: out Std_Logic;
		reg_zero	: out Std_Logic;
		reg_neg		: out Std_Logic;
		reg_cznv	: out Std_Logic;
		reg_ovr		: out Std_Logic;
		reg_vv		: out Std_Logic;
		
	-- Invalidate Port --
		inval_adr1	: in Std_Logic_Vector(3 downto 0);
		inval1		: in Std_Logic;

		inval_adr2	: in Std_Logic_Vector(3 downto 0);
		inval2		: in Std_Logic;

		inval_czn	: in Std_Logic;
		inval_ovr	: in Std_Logic;

	-- PC--
		reg_pc		: out Std_Logic_Vector(31 downto 0);
		reg_pcv		: out Std_Logic;
		inc_pc		: in Std_Logic;
	
	-- global interface--
		ck			: in Std_Logic;
		reset_n			: in Std_Logic;
		vdd			: in bit;
		vss			: in bit);
end Reg;

architecture Behavior OF Reg is
type registers_array is array (15 downto 0) of std_logic_vector(31 downto 0);
type inval_array is array (15 downto 0) of std_logic;
signal REGS : registers_array;
signal invals : inval_array;
signal cry,zero,neg,ovr,cznv,vv : std_logic;
begin 
process(ck)-- write process (sync)
begin
	if(ck'event and ck = '1') then
		--active low reset
		if(reset_n = '0') then
			for i in invals'range loop
				  invals(i) <= '0';
			end loop; 	
			cznv <= '0';
			vv <= '0';
		end if;
		-- write 2 	
		if(wen2 = '1') then
			REGS(to_integer(unsigned(wadr2))) <= wdata2;
		end if;
		-- write 1
		if(wen1 = '1') then
			REGS(to_integer(unsigned(wadr1))) <= wdata1;
		end if;
		--Flags write back
		if(cspr_wb = '1') then
			cry <= wcry;
			zero <= wzero;
			neg <= wneg;
			ovr <= wovr;
		end if;
		-- Increment PC
		if(inc_pc = '1') then
			REGS(15) <= REGS(15) + 4;
		end if;
		--invalidate Regs and flags
		invals(to_integer(unsigned(inval_adr1))) <= inval1;
		invals(to_integer(unsigned(inval_adr2))) <= inval2;
		cznv <= inval_czn;
		vv <= inval_ovr;
		
	end if;
end process;
-- Read (async)
reg_rd1 <= REGS(to_integer(unsigned(radr1)));
reg_v1 <= invals(to_integer(unsigned(radr1)));
reg_rd2 <= REGS(to_integer(unsigned(radr2)));
reg_v2 <= invals(to_integer(unsigned(radr2)));
reg_rd3 <= REGS(to_integer(unsigned(radr3)));
reg_v3 <= invals(to_integer(unsigned(radr3)));

reg_cry <= cry;
reg_neg <= neg;
reg_zero <= zero;
reg_ovr <= cry;
reg_cznv <= cznv;
reg_vv <= vv;

reg_pc <= REGS(15);
reg_pcv <= invals(15);
end Behavior;
