library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter24_normal is
	port(
		clk,sel: in std_logic;
		q1,q0: inout std_logic_vector(3 downto 0));
end counter24_normal;

architecture behave of counter24_normal is
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(sel = '0') then
				if(q0 = "1001") then 
					q0 <= "0000"; 
					q1 <= q1 + 1;
				elsif(q0 = "0011" and q1 = "0010") then
					q0 <= "0000";
					q1 <= "0000";
				else q0 <= q0 + 1;
				end if;
			else 
				if(q0 = "0000") then 
					if(q1 = "0000") then q1 <= "0010"; q0 <= "0011";
					else q1 <= q1 - 1; q0 <= "1001";
					end if;
				else q0 <= q0 - 1;
				end if;
			end if;
		end if;
	end process;
end behave;