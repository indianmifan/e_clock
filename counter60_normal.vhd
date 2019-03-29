library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter60_normal is
	port(
		clk,sel: in std_logic;
		q1,q0: inout std_logic_vector(3 downto 0);
		C: out std_logic);
end counter60_normal;

architecture behave of counter60_normal is
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(sel = '0') then
				if(q0 = "1001") then 
					q0 <= "0000"; 
					if(q1 = "0101") then q1 <= "0000"; C <= '1';
					else q1 <= q1 + 1; C <= '0';
					end if;
				else q0 <= q0 + 1; C <= '0';
				end if;
			else 
				if(q0 = "0000") then 
					q0 <= "1001"; 
					if(q1 = "0000") then q1 <= "0101"; C <= '1';
					else q1 <= q1 - 1; C <= '0';
					end if;
				else q0 <= q0 - 1; C <= '0';
				end if;
			end if;
		end if;
	end process;
end behave;