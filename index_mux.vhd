library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity index_mux is
 port(data_in_a, data_in_b : in STD_LOGIC_VECTOR(7 downto 0);
     data_mux_ctrl: in STD_LOGIC;
     data_out: out STD_LOGIC_VECTOR(7 downto 0)
  );
end index_mux;
 
architecture bhv of index_mux is
begin
process (data_in_a, data_in_b, data_mux_ctrl) is
begin
  if (data_mux_ctrl = '0') then
      data_out <= data_in_a;
  elsif (data_mux_ctrl = '1') then
      data_out <= data_in_b;
 end if;
end process;
end bhv;