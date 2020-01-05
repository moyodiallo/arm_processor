LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY fifo_32b_tb IS
END entity;

architecture dataflow of fifo_32b_tb is

	component fifo_32b 
	port(
	din		: in std_logic_vector(31 downto 0);
	dout	: out std_logic_vector(31 downto 0);

	-- commands
	push	: in std_logic;
	pop		: in std_logic;

	-- flags
	full		: out std_logic;
	empty		: out std_logic;

	reset_n	: in std_logic;
	ck		: in std_logic;
	vdd		: in bit;
	vss		: in bit
	);
	end component;

	signal din	: std_logic_vector(31 downto 0);
	signal dout	: std_logic_vector(31 downto 0);

	-- commands
	signal push	: std_logic;
	signal pop	: std_logic;

	-- flags
	signal full		: std_logic;
	signal empty	: std_logic;

	signal reset_n	: std_logic;
	signal ck		: std_logic;
	signal vdd		: bit;
	signal vss		: bit;

	signal count : std_logic_vector(31 downto 0);
	signal dcount : std_logic_vector(31 downto 0);
begin

	fifo: fifo_32b port map(
		din => din	,
		dout => dout,


		-- commands
		push	=> push,
		pop		=> pop,

		-- flags
		full	=> full,
		empty	=> empty,

		reset_n	=> reset_n,
		ck		=> ck,
		vdd		=> vdd,
		vss		=> vss);

		process
		begin
					wait for 3 ns;
					for i in 1 to 32 loop
						din <= count;
						if empty = '1' then
							push   <= '1';
							dcount <= count;
						else push <= '0';
						end if;

						if full = '1' then pop <= '1'; else pop <= '0'; end if;

						wait for 1 ns;

					end loop;

					report "cool";
					wait;

		end process;

		process 
		begin
			count <= X"00000000";
			reset_n <= '0';
			wait for 1 ns;
			reset_n <= '1';
			wait for 1 ns;

			for i in 1 to 16 loop
				ck <= '0';
				wait for 1 ns;
				ck <= '1';
				wait for 1 ns;
				count <= count + X"00000001";
			end loop;

			wait;
		end process;

end dataflow;
