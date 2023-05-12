library ieee;
USE ieee.std_logic_1164.all;

ENTITY UZE IS
PORT(
	uze_input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	uze_output: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end UZE;

ARCHITECTURE Behaviour OF UZE IS
BEGIN
	uze_output <= uze_input(15 DOWNTO 0) & "0000000000000000";
END Behaviour;