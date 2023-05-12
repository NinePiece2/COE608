LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.All;
USE ieee.std_logic_unsigned.ALL;

ENTITY register1 IS
PORT (d, ld, clr, clk : IN STD_LOGIC ;
		Q : OUT STD_LOGIC ) ;
END register1;

ARCHITECTURE description OF register1 IS
BEGIN
	PROCESS (ld, clr, clk)
	BEGIN
		if clr = '1' then
			Q <= '0';
		elsif ((clk'event and clk = '1') and (ld = '1')) then
			Q <= d;
		end if;
END PROCESS;
END description;