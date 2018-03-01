library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fsm is 
  port(clk, enable : in std_logic;
    machine_code : in std_logic_vector(2 downto 0);
    index_mux_control : out std_logic;
    data_mux_control : out std_logic_vector(1 downto 0);
    enable_key, enable_data, enable_index : out std_logic);
end entity fsm;

architecture beh of fsm is
    TYPE State_type IS (Idle, LoadK, LoadD, LoadI, DataSplit, DataShift, DataXOR, IndexM);  -- Define the states
        SIGNAL State : State_Type;    -- Create a signal that uses 
                                      -- the different states
    BEGIN 
      PROCESS (clk, enable) 
      BEGIN 
        IF (rising_edge(clk)) THEN
        If (enable = '1') THEN

        -- The CASE statement checks the value of the State variable,
        -- and based on the value and any other control signals, changes
        -- to a new state.
        CASE State IS
     
            -- If the current state is A and P is set to 1, then the
            -- next state is B
            WHEN Idle => 
                case machine_code is
                    when "100" => State <= LoadK;
                    when "101" => State <= LoadD;
                    when "110" => State <= LoadI;
                    when "000" => State <= DataSplit;
                    when "001" => State <= DataXOR;
                    when "010" => State <= DataShift;
                    when "011" => State <= IndexM;
                    when others => State <= Idle;
                end case;
            WHEN OTHERS => 
                State <= Idle;
        END CASE;
        ELSE
            State <= Idle;
        END IF; 
        END IF;
      END PROCESS;
    
    -- Decode the current state to create the output
    -- if the current state is D, R is 1 otherwise R is 0
    enable_key <= '1' WHEN State=LoadK ELSE '0';
    enable_data <= '1' WHEN State=LoadD ELSE '0';
    enable_index <= '1' WHEN (State=LoadI OR State=DataSplit OR State=DataShift OR State=DataXOR) ELSE '0';
    index_mux_control <= '0' WHEN (State=LoadI) ELSE '1';
    data_mux_control <= "11" WHEN State=DataSplit ELSE "01" WHEN State=DataXOR ELSE "10" WHEN State=DataShift ELSE "00";

    END beh;