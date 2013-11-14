LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY count IS
  GENERIC (w : positive := 8);
  PORT (a  : IN  std_logic_vector(w-1 DOWNTO 0);
        q : OUT integer);
END count;

ARCHITECTURE recursive OF count IS
  -- count bit with a balanced tree approach
  FUNCTION count_bits(vec: std_logic_vector) RETURN integer IS
    CONSTANT n: natural := vec'LENGTH;
    CONSTANT v: std_logic_vector(1 TO n) := vec;
  BEGIN
    CASE n IS
      WHEN 0      => RETURN 0;
      WHEN 1      => IF v(1) = '1' THEN
                      RETURN 1;
                     ELSE
                       RETURN 0;
                     END IF;
      WHEN OTHERS => RETURN count_bits(v(1     to n/2))
                          + count_bits(v(n/2+1 to n));
    END CASE;
  END count_bits;

BEGIN
  q <= count_bits(a);
END recursive;






