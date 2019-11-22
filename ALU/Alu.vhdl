library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Alu is
  port ( op1  : in  Std_Logic_Vector(31 downto 0);
         op2  : in  Std_Logic_Vector(31 downto 0);
         cin  : in  Std_Logic;
         cmd  : in  Std_Logic_Vector(1 downto 0);
         res  : out Std_Logic_Vector(31 downto 0);
         cout : out Std_Logic;
         z    : out Std_Logic;
         n    : out Std_Logic;
         v    : out Std_Logic;
         vdd  : in  bit;
         vss  : in  bit );
  end Alu;

architecture archi of Alu is
signal a,b,s : std_logic_vector(32 downto 0);
begin
a<= '0' & op1;
b<= '0' & op2;

with cmd select 
	s <=    (a + b + ("0000000000000000000000000000000" & cin)) when "00",
		(a and b) when "01",
		(a or b) when  "10",
		(a xor b) when "11",
		(others => '0') when others;

res <= s(31 downto 0);
cout <= s(32);
v <= (op1(31) xnor op2(31)) and (op1(31) xor s(31));
z <= '1' when s(31 downto 0) = "00000000000000000000000000000000" else 
     '0';
n <= s(31);
end archi;
