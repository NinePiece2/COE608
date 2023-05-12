library ieee;
USE ieee.std_logic_1164.all;

ENTITY LZE IS
PORT(
	lze_input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	lze_output: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end LZE;

ARCHITECTURE Behaviour OF LZE IS
BEGIN
	lze_output <= "0000000000000000" & lze_input(15 DOWNTO 0);
END Behaviour;