library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Reg is
	port(
	-- Write Port 1 prioritaire--
		wdata1		: in Std_Logic_Vector(31 downto 0);
		wadr1		: in Std_Logic_Vector(3 downto 0);
		wen1		: in Std_Logic;

	-- Write Port 2 non prioritaire--
		wdata2		: in Std_Logic_Vector(31 downto 0);
		wadr2		: in Std_Logic_Vector(3 downto 0);
		wen2		: in Std_Logic;

	-- Write CSPR Port--
		wcry		: in Std_Logic;
		wzero		: in Std_Logic;
		wneg		: in Std_Logic;
		wovr		: in Std_Logic;
		cspr_wb		: in Std_Logic;
		
	-- Read Port 1 32 bits--
		reg_rd1		: out Std_Logic_Vector(31 downto 0);
		radr1		: in Std_Logic_Vector(3 downto 0);
		reg_v1		: out Std_Logic;

	-- Read Port 2 32 bits--
		reg_rd2		: out Std_Logic_Vector(31 downto 0);
		radr2		: in Std_Logic_Vector(3 downto 0);
		reg_v2		: out Std_Logic;

	-- Read Port 3 32 bits--
		reg_rd3		: out Std_Logic_Vector(31 downto 0);
		radr3		: in Std_Logic_Vector(3 downto 0);
		reg_v3		: out Std_Logic;

	-- read CSPR Port--
		reg_cry		: out Std_Logic;
		reg_zero	: out Std_Logic;
		reg_neg		: out Std_Logic;
		reg_ovr		: out Std_Logic;
		reg_cznv	: out Std_Logic;
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
		reset_n		: in Std_Logic;
		vdd			: in bit;
		vss			: in bit);
end Reg;

architecture Behavior OF Reg is
type registers_array is array (15 downto 0) of std_logic_vector(31 downto 0);
signal REGS   : registers_array;
signal invals : std_logic_vector(15 downto 0); -- 1 c'est invalid, 0 est valid
signal cry,zero,neg,ovr,cznv,vv : std_logic;

signal wadr1_invalid : std_logic;
signal wadr2_invalid : std_logic;

signal inval_adr1_invalid : std_logic;
signal inval_adr2_invalid : std_logic;

begin 
process(ck, wadr1, wadr2, inval_adr1, inval_adr2, invals)-- write process (sync)
begin
	
	wadr1_invalid <= invals(to_integer(unsigned(wadr1)));
	wadr2_invalid <= invals(to_integer(unsigned(wadr2)));

	inval_adr1_invalid <= invals(to_integer(unsigned(inval_adr1)));
	inval_adr2_invalid <= invals(to_integer(unsigned(inval_adr2)));

	if(rising_edge(ck)) then
		--report "PC ink reg= " & std_logic'image(inc_pc);
		--active low reset
		if(reset_n = '0') then
			for i in invals'range loop
				  invals(i) <= '0';
				  REGS(i)   <= X"00000000";
			end loop;
			cznv   <= '1';
			vv     <= '1';
		else


			--report "wen1 "& std_logic'image(wen1);
			--report "invalw1" & std_logic'image(invals(to_integer(unsigned(wadr1))));
			--report "invalid1 " & integer'image(to_integer(unsigned(inval_adr1)));

			if( wen1 = '1' and wen2 = '1' and wadr1 = wadr2 
				and wadr1_invalid = '1'
				and wadr2_invalid = '1') 
			then
				--report "writing port 1 ("& to_hstring(wadr1) &")= " & to_hstring(wdata1);
				REGS(to_integer(unsigned(wadr1)))   <= wdata1;
				invals(to_integer(unsigned(wadr1))) <= '0';
			
			-- write 2 	
			elsif (wen2 = '1' and wadr2_invalid  = '1') then
				--report "writing port 2 ("& to_hstring(wadr2) &")= " & to_hstring(wdata2);
				REGS(to_integer(unsigned(wadr2)))   <= wdata2;
				invals(to_integer(unsigned(wadr2))) <= '0';

			-- write 1
			elsif(wen1 = '1' and wadr1_invalid = '1') then
				--report "writing port 1 ("& to_hstring(wadr1) &")= " & to_hstring(wdata1);
				REGS(to_integer(unsigned(wadr1)))   <= wdata1;
				invals(to_integer(unsigned(wadr1))) <= '0';	

			end if;

			--Flags write back
			if (cspr_wb = '1' and cznv = '0') then
				cry  <= wcry;
				zero <= wzero;
				neg  <= wneg;
				cznv <= '1';
			end if;
			if (cspr_wb = '1' and vv = '0') then
				ovr  <= wovr;
				vv   <= '1';
			end if;

			-- Increment PC
			if inc_pc = '1' and invals(15) = '0' then
				-- report "PC reg_incr = " & std_logic'image(Regs(15)(0));
				REGS(15) <= REGS(15) + 4;
			end if;

			--invalidate Regs and flags (on invalid si c'est valide)
			if 	inval1 = '1' and inval_adr1_invalid  = '0'then 
				--report "invalid1 " & integer'image(to_integer(unsigned(inval_adr1)));	
				invals(to_integer(unsigned(inval_adr1))) <= '1';
			elsif inval2 = '1' and inval_adr2_invalid = '0' then
				--report "invalid2 " & integer'image(to_integer(unsigned(inval_adr2)));
				invals(to_integer(unsigned(inval_adr2))) <= '1';
			end if;
			
			if inval_czn = '1' and cznv = '1' then
				cznv <= '0';
			end if;

			if inval_ovr = '1' and vv = '1' then
				vv <= '0';
			end if;

		end if;
	end if;
end process;

-- Read (async)
reg_rd1 <= REGS(to_integer(unsigned(radr1)));
reg_rd2 <= REGS(to_integer(unsigned(radr2)));
reg_rd3 <= REGS(to_integer(unsigned(radr3)));

reg_v2  <= not invals(to_integer(unsigned(radr2)));
reg_v1  <= not invals(to_integer(unsigned(radr1)));
reg_v3  <= not invals(to_integer(unsigned(radr3)));

reg_cry  <= cry;
reg_neg  <= neg;
reg_zero <= zero;
reg_ovr  <= ovr;

reg_cznv <= cznv;
reg_vv   <= vv;

reg_pc  <= REGS(15);
reg_pcv <= not invals(15);

end Behavior;