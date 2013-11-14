LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY funny IS
  GENERIC (w : positive := 8);
  PORT (a   : IN  std_logic_vector(w-1 DOWNTO 0);
        clk : IN  std_logic;
        q   : OUT integer RANGE 0 TO w);
END funny;

ARCHITECTURE behaviour OF funny IS
  FUNCTION cnt (a:std_logic_vector) RETURN integer IS
    VARIABLE nmb : INTEGER RANGE 0 TO a'LENGTH;
  BEGIN
    nmb := 0;
    FOR i IN a'RANGE LOOP
      IF a(i)='1' THEN nmb:=nmb+1; END IF;
    END LOOP;
    RETURN nmb;
  END cnt;

  SIGNAL qi, q_prev : integer := 0;
BEGIN

-- PSL default clock is falling_edge(clk);
-- PSL assert always  ( not stable(a) -> countones(a)=qi );

  PROCESS
  BEGIN
    WAIT UNTIL rising_edge(clk);
    qi <= cnt(a);
  END PROCESS;

  q <= qi;


END behaviour;






