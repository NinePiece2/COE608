LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY register32 IS
PORT (
		d   : IN STD_LOGIC_VECTOR(31 DOWNTO 0) ;
		ld  : IN STD_LOGIC ;
		clr : IN STD_LOGIC ; 
		clk : IN STD_LOGIC ;
		Q   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)) ;
END register32;

ARCHITECTURE description OF register32 IS
BEGIN
	PROCESS (ld, clr, clk)
	BEGIN
		if clr = '1' then
			Q <= "00000000000000000000000000000000" ;
		elsif ((clk'event and clk = '1') and (ld = '1')) then
			Q <= d;
		END if;
	END PROCESS;
END description;