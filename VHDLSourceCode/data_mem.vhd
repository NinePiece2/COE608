LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY data_mem IS
PORT(
		clk		:IN STD_LOGIC;
		addr		:IN UNSIGNED(7 DOWNTO 0);
		data_in	:IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		wen		:IN STD_LOGIC;
		en			:IN STD_LOGIC;
		data_out :OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END data_mem;

ARCHITECTURE Description OF data_mem IS
TYPE memory_type IS ARRAY (0 TO 255) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL memory  : memory_type :=(OTHERS =>"00000000000000000000000000000000");
SIGNAL temp : INTEGER;

BEGIN
PROCESS (clk, addr, data_in, wen, en)
	BEGIN
	temp <= TO_INTEGER(unsigned(addr));
	IF ((clk'event AND clk = '0') AND (en = '1') AND (wen = '0')) THEN
		data_out <= memory(temp);
	ELSIF ((clk'event AND clk = '0') AND (en = '1')AND (wen = '1')) THEN
		memory(temp) <= data_in;
		data_out <= "00000000000000000000000000000000";
	ELSIF ((clk'event AND clk = '0') AND (en = '0')AND (wen = '1')) THEN
		data_out <= "00000000000000000000000000000000";
	ELSIF ((clk'event AND clk = '0') AND (en = '0')AND (wen = '0')) THEN
		data_out <= "00000000000000000000000000000000";
	END IF;
END PROCESS;
END Description;