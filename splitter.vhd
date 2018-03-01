library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity splitter is
    port (clk			: in std_logic;
          data_in_a		: in std_logic_vector(7 downto 0);
          data_in_b		: in std_logic_vector(7 downto 0);
          data_out		: out std_logic_vector(7 downto 0));
end entity splitter;

architecture behaviour of splitter is
begin
	process (clk)
        variable data : std_logic_vector(7 downto 0) := x"00";
        variable count : integer;
	begin
        if(rising_edge(clk)) then
            count := to_integer((unsigned(data_in_b)));
            data := data_in_a(count downto 0) & data_in_a(7 downto count+1);
		end if;
        data_out <= data;
	end process;
end architecture behaviour;