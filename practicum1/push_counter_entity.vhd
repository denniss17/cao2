LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY push_counter IS
  PORT (button   : IN std_logic;
        cnt_eenh : OUT std_logic_vector(6 DOWNTO 0);
        cnt_tien : OUT std_logic_vector(6 DOWNTO 0);
        clk    : IN std_logic;
        reset  : IN std_logic
        );
END push_counter;
