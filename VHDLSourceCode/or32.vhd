library ieee;
use ieee.std_logic_1164.all;

entity or32 is
port(
	a: in std_logic_vector(31 downto 0);
	result: out std_logic
);
end or32;

architecture behaviour of or32 is
begin
	result <= a(0) or a(1) or a(2) or a(4) or
					a(5) or a(6) or a(7) or a(8) or
					a(9) or a(10) or a(11) or a(12) or
					a(13) or a(14) or a(15) or a(16) or
					a(17) or a(18) or a(19) or a(20) or
					a(21) or a(22) or a(23) or a(24) or
					a(25) or a(26) or a(27) or a(28) or
					a(29) or a(30) or a(31);
end behaviour;