--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : registerfile.vhd
--
-- Related File(s)  : utilities.vhd
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : registerfile
--
-- Change Log 
--   Author         : 
--   Email          : 
--   Date           :  
--   Changes        :
--
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.utilities.ALL;
ENTITY registerfile IS
  GENERIC (window_depth : integer := 3);
  PORT (
    Clk : IN std_logic;
    Reset : IN  std_logic; -- async, low active
    
    BusA : OUT std_logic_vector(31 DOWNTO 0);
    SelA : IN  std_logic_vector( 5 DOWNTO 0);  
    BusB : OUT std_logic_vector(31 DOWNTO 0);
    SelB : IN  std_logic_vector( 5 DOWNTO 0);  
    BusC : IN  std_logic_vector(31 DOWNTO 0);
    SelC : IN  std_logic_vector( 5 DOWNTO 0);
    --CWP  : IN std_logic_vector(window_depth-1 DOWNTO 0);
    
    window_ov : OUT std_logic;
    window_un : OUT std_logic;
    IR   : OUT std_logic_vector(31 DOWNTO 0)
  );
END ENTITY registerfile;

ARCHITECTURE three_port OF registerfile IS

  TYPE reg_file_type IS ARRAY (15 + 24*(2**window_depth) DOWNTO 0) OF std_logic_vector(31 DOWNTO 0);
  SIGNAL reg_file : reg_file_type := (OTHERS=>(OTHERS=>'0'));
  SIGNAL CWP : std_logic_vector(window_depth-1 DOWNTO 0);
  ATTRIBUTE ram_block: boolean;
  ATTRIBUTE ram_block OF reg_file: SIGNAL IS true;  
 
BEGIN

  -- check that register file does not have enable in signals
  registers:PROCESS(clk)
    VARIABLE index : natural;
  BEGIN
    IF Reset='0' THEN
      reg_file(38-24) <= (OTHERS=>'0');
      CWP <= (OTHERS=>'0');
      window_ov <= '0';
      window_un <= '0';
    ELSIF falling_edge(clk) THEN  
      reg_file(0) <= (OTHERS=>'0');  --%r0 constant zero
      index := decoder(SelC);
      
      -- underflow
      IF to_integer(signed(reg_file(38-24))) < 0 THEN
        window_un <= '1';
      ELSE
        window_un <= '0';
      END IF;
      
      -- overflow
      IF to_integer(unsigned(reg_file(38-24))) < (2**window_depth) THEN
        window_ov <= '0';
      ELSE
        window_ov <= '1';
      END IF;
      
      
      IF index>0 THEN
        IF index > 31 THEN
          -- 32 till 37 is mapped to 8 till 15
          reg_file(index-24)<= BusC;
        ELSIF index > 7 THEN
          reg_file(index + 8 + 24*to_integer(unsigned(CWP)))<= BusC;
        ELSE
          -- r0 t/m r7
          reg_file(index)<= BusC;
        END IF;
      END IF;
    END IF;
  END PROCESS registers;
  
  lol:PROCESS(selA, selB)
  BEGIN
      IF to_integer(unsigned(SelA)) > 31 THEN
        BusA <= reg_file(to_integer(unsigned(SelA))-24);
      ELSIF to_integer(unsigned(SelA)) > 7 THEN
        BusA <= reg_file(to_integer(unsigned(SelA))+8+24*to_integer(unsigned(CWP)));
      ELSE
        BusA <= reg_file(to_integer(unsigned(SelA)));
      END IF;
      
      IF to_integer(unsigned(SelB)) > 31 THEN
        BusB <= reg_file(to_integer(unsigned(SelB))-24);
      ELSIF to_integer(unsigned(SelB)) > 7 THEN
        BusB <= reg_file(to_integer(unsigned(SelB))+8+24*to_integer(unsigned(CWP)));
      ELSE
        BusB <= reg_file(to_integer(unsigned(SelB)));
      END IF;
  END PROCESS lol;
  
  -- BusA <= reg_file(to_integer(unsigned(SelA)));
  -- BusB <= reg_file(to_integer(unsigned(SelB)));  
 
  IR  <= reg_file(37-24);
  CWP <= reg_file(38-24)(window_depth-1 DOWNTO 0);
    
END ARCHITECTURE three_port;
