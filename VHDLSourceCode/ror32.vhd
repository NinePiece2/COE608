library ieee;
use ieee.std_logic_1164.all;

entity ror32 is
port(
	a: in std_logic_vector(31 downto 0);
	result: out std_logic_vector(31 downto 0)
);
end ror32;

architecture behaviour of ror32 is
begin
	result <= '0' & a(31 downto 1); -- keep top 31 bits
end behaviour;