library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ip_block is 
  port(clk : in std_logic;
    enable : in std_logic;
    machine_code : in std_logic_vector(2 downto 0);
    data_in : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0));
end entity ip_block;

architecture bhv of ip_block is  
  signal enable_key, enable_data, enable_index, index_mux_control : std_logic;
  signal data_mux_control : std_logic_vector(1 downto 0);

  component datapath
    port(clk : in std_logic;
      enable_key, enable_data, enable_index : in std_logic;
      index_mux_control : in std_logic;
      data_mux_control : in std_logic_vector(1 downto 0);
      data_in : in std_logic_vector(7 downto 0);
      data_out : out std_logic_vector(7 downto 0));
  end component;
  
  component fsm
    port(clk, enable : in std_logic;
      machine_code : in std_logic_vector(2 downto 0);
      index_mux_control : out std_logic;
      data_mux_control : out std_logic_vector(1 downto 0);
      enable_key, enable_data, enable_index : out std_logic);
  end component;
  
  begin
    datapath_1 : datapath port map (
      clk => clk,
      enable_key => enable_key,
      enable_data => enable_data,
      enable_index => enable_index,
      index_mux_control => index_mux_control,
      data_mux_control => data_mux_control,
      data_in => data_in,
      data_out => data_out
    );
    fsm_1: fsm port map( 
      clk => clk,
      enable => enable,
      machine_code => machine_code,
      enable_key => enable_key,
      enable_data => enable_data,
      enable_index => enable_index,
      index_mux_control => index_mux_control,
      data_mux_control => data_mux_control
    );
end architecture bhv;

