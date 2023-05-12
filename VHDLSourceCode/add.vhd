LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY add IS
PORT (
		A : IN STD_LOGIC_VECTOR(31 DOWNTO 0) ; 
		B : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) ) ; 
END add;

ARCHITECTURE Behavior OF add IS
BEGIN
	B <= A + 1 ; 
END Behavior;