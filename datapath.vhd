library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity datapath is
    port (clk			: in std_logic;
		  data_in		: in std_logic_vector(7 downto 0);
          data_out		: out std_logic_vector(7 downto 0);
		  machine_code	: in std_logic_vector(2 downto 0));
end entity datapath;

architecture behaviour of datapath is
begin
	process (clk, machine_code)
		variable key_register : std_logic_vector(7 downto 0);
		variable data_register : std_logic_vector(7 downto 0);
		variable index_register : integer;
	begin
		if(rising_edge(clk)) then
			case machine_code is
				when "100" => key_register := data_in;
				when "101" => data_register := data_in;
				when "111" => index_register := to_integer(unsigned(data_in));
				when "000" => data_register := data_register(index_register downto 0) & data_register(7 downto index_register+1);
				when "001" => data_register := key_register xor data_register;
				when "010" => data_register := data_register(0) & data_register(7 downto 1);
				when "011" => index_register := index_register + 1;
				when others => index_register := index_register;
			end case;
		end if;
        data_out <= data_register;
	end process;
end architecture behaviour;