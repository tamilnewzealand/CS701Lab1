library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity xor_gate is
    port (clk			: in std_logic;
          data_in_a		: in std_logic_vector(7 downto 0);
          data_in_b		: in std_logic_vector(7 downto 0);
          data_out		: out std_logic_vector(7 downto 0));
end entity xor_gate;

architecture behaviour of xor_gate is
begin
	process (clk)
		variable data : std_logic_vector(7 downto 0) := x"00";
	begin
        if(rising_edge(clk)) then
            data := data_in_a xor data_in_b;
		end if;
        data_out <= data;
	end process;
end architecture behaviour;