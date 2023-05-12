library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY RED IS
PORT(
	red_input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	red_output: OUT UNSIGNED(7 DOWNTO 0)
);
end RED;

ARCHITECTURE Behaviour OF RED IS
SIGNAL temp : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	temp <= red_input(7 DOWNTO 0);
	red_output <= unsigned(temp);
END Behaviour;