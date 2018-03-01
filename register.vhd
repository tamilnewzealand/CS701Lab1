library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity datapath is
    port (clk			: in std_logic;
          enable        : in std_logic;
		  data_in		: in std_logic_vector(7 downto 0);
          data_out		: out std_logic_vector(7 downto 0));
end entity datapath;

architecture behaviour of datapath is
begin
	process (clk)
		variable data : std_logic_vector(7 downto 0) := x"00";
	begin
        if(rising_edge(clk) AND enable = '1') then
            data := data_in;
		end if;
        data_out <= data;
	end process;
end architecture behaviour;