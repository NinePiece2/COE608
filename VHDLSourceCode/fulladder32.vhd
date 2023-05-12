library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fulladder32 is
port(
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(31 downto 0);
		cin: in std_logic;
		s: out std_logic_vector(31 downto 0);
		cout: out std_logic
);
end fulladder32;

architecture behaviour of fulladder32 is
	component fulladder 
		port(
			a: in std_logic;
			b: in std_logic;
			cin: in std_logic;
			s: out std_logic;
			cout: out std_logic
		);
	end component;
	
	signal carry: std_logic_vector(30 downto 0);

begin
	add0: fulladder port map(a(0), b(0), cin, s(0), carry(0)); -- result bit 0
	add1: fulladder port map(a(1), b(1), carry(0), s(1), carry(1));
	add2: fulladder port map(a(2), b(2), carry(1), s(2), carry(2));
	add3: fulladder port map(a(3), b(3), carry(2), s(3), carry(3));
	add4: fulladder port map(a(4), b(4), carry(3), s(4), carry(4));
	add5: fulladder port map(a(5), b(5), carry(4), s(5), carry(5));
	add6: fulladder port map(a(6), b(6), carry(5), s(6), carry(6));
	add7: fulladder port map(a(7), b(7), carry(6), s(7), carry(7));
	add8: fulladder port map(a(8), b(8), carry(7), s(8), carry(8));
	add9: fulladder port map(a(9), b(9), carry(8), s(9), carry(9));
	add10: fulladder port map(a(10), b(10), carry(9), s(10), carry(10));
	add11: fulladder port map(a(11), b(11), carry(10), s(11), carry(11));
	add12: fulladder port map(a(12), b(12), carry(11), s(12), carry(12));
	add13: fulladder port map(a(13), b(13), carry(12), s(13), carry(13));
	add14: fulladder port map(a(14), b(14), carry(13), s(14), carry(14));
	add15: fulladder port map(a(15), b(15), carry(14), s(15), carry(15));
	add16: fulladder port map(a(16), b(16), carry(15), s(16), carry(16));
	add17: fulladder port map(a(17), b(17), carry(16), s(17), carry(17));
	add18: fulladder port map(a(18), b(18), carry(17), s(18), carry(18));
	add19: fulladder port map(a(19), b(19), carry(18), s(19), carry(19));
	add20: fulladder port map(a(20), b(20), carry(19), s(20), carry(20));
	add21: fulladder port map(a(21), b(21), carry(20), s(21), carry(21));
	add22: fulladder port map(a(22), b(22), carry(21), s(22), carry(22));
	add23: fulladder port map(a(23), b(23), carry(22), s(23), carry(23));
	add24: fulladder port map(a(24), b(24), carry(23), s(24), carry(24));
	add25: fulladder port map(a(25), b(25), carry(24), s(25), carry(25));
	add26: fulladder port map(a(26), b(26), carry(25), s(26), carry(26));
	add27: fulladder port map(a(27), b(27), carry(26), s(27), carry(27));
	add28: fulladder port map(a(28), b(28), carry(27), s(28), carry(28));
	add29: fulladder port map(a(29), b(29), carry(28), s(29), carry(29));
	add30: fulladder port map(a(30), b(30), carry(29), s(30), carry(30));
	add31: fulladder port map(a(31), b(31), carry(30), s(31), cout);
end behaviour;