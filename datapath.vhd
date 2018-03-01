library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity datapath is 
  port(clk : in std_logic;
    enable : in std_logic;
    machine_code : in std_logic_vector(2 downto 0);
    index_mux_control : in std_logic;
    data_mux_control : in std_logic_vector(1 downto 0);
    data_in : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0));
end entity datapath

architecture bhv of datapath is  
  signal key_reg_out : std_logic_vector(7 downto 0);
  signal data_reg_out: std_logic_vector(7 downto 0);
  signal xor_out : std_logic_vector(7 downto 0);
  signal index_reg_out : std_logic_vector(7 downto 0);
  signal splitter_out : std_logic_vector(7 downto 0);
  signal incrementer_out : std_logic_vector(7 downto 0);
  signal shifter_out : std_logic_vector(7 downto 0);
  signal index_mux_out : std_logic_vector(7 downto 0);
  signal data_mux_out : std_logic_vector(7 downto 0);
  
  component regist
    port(clk, enable : in std_logic;
      data_in : in std_logic_vector(7 downto 0);
      data_out: out std_logic_vector(7 downto 0));
  end component
  
  component xor_gate
    port(clk : in std_logic;
      data_in_A : in std_logic_vector(7 downto 0);
      data_in_B : in std_logic_vector(7 downto 0);
      data_out: out std_logic_vector(7 downto 0));
  end component
  
  component splitter
    port(clk : in std_logic;
      data_in_A : in std_logic_vector(7 downto 0);
      data_in_B : in std_logic_vector(7 downto 0);
      data_out: out std_logic_vector(7 downto 0));
  end component
  
  component shifter
    port(clk : in std_logic;
      data_in : in std_logic_vector(7 downto 0);
      data_out: out std_logic_vector(7 downto 0));
  end component
  
  component incrementer
    port(clk : in std_logic;
      data_in : in std_logic_vector(7 downto 0);
      data_out: out std_logic_vector(7 downto 0));
  end component
  
  component index_mux
    port(clk : in std_logic;
      data_in_A, data_in_B : in std_logic_vector(7 downto 0);
      data_mux_ctrl : in std_logic;
      data_out : out std_logic_vector(7 downto 0));
  end component
  
  component data_mux
    port(clk : in std_logic;
      data_in_A, data_in_B, data_in_C, data_in_D : in std_logic_vector(7 downto 0);
      data_mux_ctrl : in std_logic_vector(1 downto 0);
      data_out : out std_logic_vector(7 downto 0));
  end component
  
  begin
    key_regist : regist port map (
      clk => clk,
      enable => enable,
      data_in => data_in,
      data_out => key_reg_out       
    );
    
    data_regist : regist port map (
      clk => clk,
      enable => enable,
      data_in => data_in,
      data_out => data_reg_out      
    );
    
    index_regist : regist port map (
      clk => clk,
      enable => enable,
      data_in => index_mux_out,
      data_out => index_reg_out
    );
    
    index_mux_1 : index_mux port map (
      clk => clk,
      data_in_A => data_in,
      data_in_B => incrementer_out,
      data_mux_ctrl => index_mux_control,
      data_out => index_mux_out
    );
    
    xor_gate_1 : xor_gate port map (
      clk => clk,
      data_in_A => key_reg_out,
      data_in_B => data_reg_out,
      data_out => xor_out
    );
    
    splitter_1 : splitter port map (
      clk => clk,
      data_in_A => index_reg_out,
      data_in_B => data_reg_out,
      data_out => splitter_out
    );
    
    shifter_1 : shifter port map (
      clk => clk,
      data_in => data_reg_out,
      data_out => shifter_out
    );
    
    data_mux_1 : data_mux port map (
      clk => clk,
      data_in_A = > splitter_out,
      data_in_B => xor_out,
      data_in_C => shifter_out,
      data_in_D => data_in,
      data_mux_ctrl => data_mux_control,
      data_out => data_out
    );
end architecture bhv

entity regist is
  port(clk : in std_logic;
    enable : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0));
end entity regist

architecture bhv of regist is
  begin
    process(clk)
      variable data_store : std_logic_vector(7 downto 0) := "00000000";
      if (rising_edge(clk) and enable = '1') then
        data_store := data_in;
      end if
      data_out <= data_store;
    end process
end architecture bhv
  
