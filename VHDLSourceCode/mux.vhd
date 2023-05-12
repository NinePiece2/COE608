LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY mux IS
PORT (
		s : IN std_logic ; 
		w0, w1 : std_logic_vector(31 DOWNTO 0) ; 
		f : OUT std_logic_vector(31 DOWNTO 0) ) ; 
END mux;

ARCHITECTURE Behavior of mux is
BEGIN
WITH s SELECT
	f <= w0 WHEN '0', w1 WHEN OTHERS;
END Behavior;