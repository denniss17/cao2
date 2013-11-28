LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY display_test IS
END display_test;

ARCHITECTURE exhaustive OF display_test IS
  SIGNAL hex : unsigned(3 DOWNTO 0);
  SIGNAL displ,displ2 : std_logic_vector(6 DOWNTO 0);
  SIGNAL ok : std_logic;

BEGIN   
  PROCESS
  BEGIN
    ok <= '1';
    FOR i IN 0 TO 15 LOOP
      hex <= to_unsigned(i,4);
      WAIT FOR 20 ns;
      IF (displ=displ2 AND ok='1') THEN 
        ok <= '1'; 
      ELSE 
        ok <= '0'; 
      END IF;
      -- user has to verify the result. (or a check with golden unit here)
    END LOOP;
    WAIT;
  END PROCESS;

  golden_unit : ENTITY work.display_gold(bhv)
    PORT MAP (hex => std_logic_vector(hex), dig => displ);
  realization : ENTITY work.display(structure)     
    PORT MAP (hex => std_logic_vector(hex), dig => displ2);
END exhaustive;

