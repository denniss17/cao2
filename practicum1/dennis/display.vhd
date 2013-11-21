-- Converts HEX to 7-SEGMENT display.
-- low active inputs and outputs

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY display IS
  PORT (
    hex : IN  std_logic_vector(3 DOWNTO 0);
    dig : OUT std_logic_vector(6 DOWNTO 0)
    );
END display;


ARCHITECTURE bhv OF display IS
  FUNCTION hex2display (n:std_logic_vector(3 DOWNTO 0)) RETURN std_logic_vector IS
  BEGIN
    CASE n IS  --       gfedcba
      WHEN "0000" => RETURN "0111111";
      WHEN "0001" => RETURN "0000110";
      WHEN "0010" => RETURN "1011011";
      WHEN "0011" => RETURN "1001111";
      WHEN "0100" => RETURN "1100110";
      WHEN "0101" => RETURN "1101101";
      WHEN "0110" => RETURN "1111101";
      WHEN "0111" => RETURN "0000111";
      WHEN "1000" => RETURN "1111111";
      WHEN "1001" => RETURN "1101111";
      WHEN "1010" => RETURN "1110111";
      WHEN "1011" => RETURN "1111100";
      WHEN "1100" => RETURN "0111001";
      WHEN "1101" => RETURN "1011110";
      WHEN "1110" => RETURN "1111001";
      WHEN OTHERS => RETURN "1110001";      
    END CASE;
  END hex2display;
BEGIN
  dig <= not(hex2display(not(hex)));       
END bhv;