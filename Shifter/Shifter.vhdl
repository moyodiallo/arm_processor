library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all; 
use ieee.Numeric_STD.all;

entity Shifter is
  port(
    shift_lsl : in  Std_Logic;
    shift_lsr : in  Std_Logic;
    shift_asr : in  Std_Logic;
    shift_ror : in  Std_Logic;
    shift_rrx : in  Std_Logic;
    shift_val : in  Std_Logic_Vector(4 downto 0);
    din       : in  Std_Logic_Vector(31 downto 0);
    cin       : in  Std_Logic;
    dout      : out Std_Logic_Vector(31 downto 0);
    cout      : out Std_Logic;
    -- global interface
    vdd       : in  bit;
    vss       : in  bit );
end Shifter;

architecture archi of Shifter is
signal shift : std_logic_vector(4 downto 0);
begin
	shift <= shift_asr & shift_ror & shift_rrx & shift_lsr &  shift_lsl;
	process(shift,din)
	begin
	dout<=(others => '0');
	case shift is
	when "00001" => cout <= din(31-to_integer(unsigned(shift_val));
			dout(31 downto to_integer(unsigned(shift_val))) <= din(31-to_integer(unsigned(shift_val)) downto 0);
	when "00010" =>	cout <= din(to_integer(unsigned(shift_val));
			dout(31-to_integer(unsigned(shift_val)) downto 0) <= din(31 downto to_integer(unsigned(shift_val)));
	when "00100" => cout <= '0';
			dout <= (others => '0');
	when "01000" => cout <= '0';
			dout <= (others => '0');
	when "10000" => cout <= '0';
			dout <= (others => '0');
	when others =>  cout <= '0';
			dout <= din;
end case;
end process;

end archi;
