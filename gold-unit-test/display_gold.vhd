-- Converts HEX to 7-SEGMENT display.
-- low active inputs and outputs

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.utilities.all;
ENTITY display_gold IS
  PORT (
    hex : IN  std_logic_vector(3 DOWNTO 0);
    dig : OUT std_logic_vector(6 DOWNTO 0)
    );
END display_gold;

--     a
--  f     b
--     g
--  e     c
--     d

ARCHITECTURE bhv OF display_gold IS
BEGIN
  dig <= not(hex2display(not(hex)));       
END bhv;