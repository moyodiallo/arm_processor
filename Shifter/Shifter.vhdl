library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
signal s : std_logic_vector(32 downto 0);
begin
	shift <=  shift_rrx & shift_ror & shift_asr & shift_lsr &  shift_lsl;
	s<= din & cin;
	process(shift,din,shift_val)
	begin
	
	dout<=(others => '0');
	case shift_val is 
	when "00000"=>  cout <= cin;
			dout <= din;
	when others =>
		case shift is
		when "00001" => cout <= din(32-to_integer( unsigned(shift_val) ) );--LSL
			dout(31 downto to_integer(unsigned(shift_val))) <= din(31-to_integer(unsigned(shift_val)) downto 0);
		when "00010" =>	cout <= din(to_integer(unsigned(shift_val)-1));--LSR
			dout( 31-to_integer(unsigned(shift_val)) downto 0) <= din(31 downto to_integer(unsigned(shift_val)) );
		when "00100" => cout <= din(to_integer(unsigned(shift_val)-1));--ASR
			dout(31 downto (31-to_integer(unsigned(shift_val))))<= (others => din(31));
			dout ((30-to_integer(unsigned(shift_val))) downto 0)<= din(30 downto to_integer(unsigned(shift_val)));
		when "01000" => cout <= din(to_integer(unsigned(shift_val)-1));--ROR
			dout(31 downto (32-to_integer(unsigned(shift_val))))<= din(to_integer(unsigned(shift_val))-1 downto 0);			
			dout((31-to_integer(unsigned(shift_val))) downto 0) <= din(31 downto to_integer(unsigned(shift_val)));	
		when "10000" => cout <= din(to_integer(unsigned(shift_val)-1));--RRX
			dout(32-to_integer(unsigned(shift_val))) <= cin;
			case shift_val is
			when "00001" => dout(30 downto 0) <= din(31 downto 1);
			when others =>  dout(31 downto 33-to_integer(unsigned(shift_val)))<= din(to_integer(unsigned(shift_val))-2 downto 0);	
					dout(31-to_integer(unsigned(shift_val)) downto 0)<= din(31 downto to_integer(unsigned(shift_val)));	
			end case;
			--dout<=s(31 downto 0);			
			--dout(32-to_integer(unsigned(shift_val))) <= cin;
			--dout(32-to_integer(unsigned(shift_val))) <= cin;
			--dout(31 downto (32-to_integer(unsigned(shift_val)))) <= s(to_integer(unsigned(shift_val))-1 downto 0);	
			--dout((31-to_integer(unsigned(shift_val))) downto 0) <= din(31 downto to_integer(unsigned(shift_val)));		
		when others =>  cout <= cin;
			dout <= din;
		end case;
	end case;
end process;
end archi;
