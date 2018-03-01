library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_bench is
    end entity test_bench;
    
    architecture test of test_bench is
        signal t_clk, t_enable : std_logic;
        signal t_machine_code : std_logic_vector(2 downto 0);
        signal t_data_in, t_data_out : std_logic_vector(7 downto 0);
        
        component ip_block is
            port(clk : in std_logic;
            enable : in std_logic;
            machine_code : in std_logic_vector(2 downto 0);
            data_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0));
        end component;
        
        begin
            my_design: ip_block port map (t_clk, t_enable, t_machine_code, t_data_in, t_data_out);
    
            -- Initialization process (code that executes only once).
            init: process
            begin
                -- enable signal
                t_Enable <= '0', '1' after 90 ns, '0' after 240 ns;
                t_machine_code <= "100", "100" after 30 ns, "101" after 60 ns, "110" after 90 ns, "011" after 120 ns, "010" after 150 ns, "001" after 180 ns, "000" after 210 ns;
                t_data_in <= x"22", x"33" after 60 ns, x"44" after 90 ns, x"66" after 90 ns;
                wait;
            end process init;

            -- clock generation
            clk_gen: process
            begin
                wait for 15 ns;
                t_clk <= '1';
                wait for 15 ns;
                t_clk <= '0';
            end process clk_gen;
    end architecture test;