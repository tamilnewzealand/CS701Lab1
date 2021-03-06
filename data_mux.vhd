library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity data_mux is
 port(data_in_a, data_in_b, data_in_c, data_in_d : in STD_LOGIC_VECTOR(7 downto 0);
     data_mux_ctrl: in STD_LOGIC_VECTOR(1 downto 0);
     data_out: out STD_LOGIC_VECTOR(7 downto 0)
  );
end data_mux;
 
architecture bhv of data_mux is
begin
process (data_in_a, data_in_b, data_in_c, data_in_d,data_mux_ctrl) is
begin
  if (data_mux_ctrl = "00") then
      data_out <= data_in_a;
  elsif (data_mux_ctrl = "01") then
      data_out <= data_in_b;
  elsif (data_mux_ctrl = "10") then
      data_out <= data_in_c;
  else
      data_out <= data_in_d;
  end if;
 
end process;
end bhv;