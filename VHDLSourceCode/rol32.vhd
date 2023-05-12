library ieee;
use ieee.std_logic_1164.all;

entity rol32 is
port(
	a: in std_logic_vector(31 downto 0);
	result: out std_logic_vector(31 downto 0)
);
end rol32;

architecture behaviour of rol32 is
begin
	result <= a(30 downto 0) & '0'; -- keep bottom 31 bits
end behaviour;