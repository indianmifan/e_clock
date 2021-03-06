LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter24 IS
	PORT(clk,clr,stop,enable: IN std_logic;
	q1,q0: INOUT std_logic_vector(3 downto 0));
END counter24;

ARCHITECTURE behav OF counter24 IS
BEGIN
	process(clk,clr,stop,enable)
	BEGIN
		IF(enable = '1') THEN
			IF(clr='1') THEN q0 <= "0000"; q1 <= "0000";
			ELSIF(stop='1') THEN q0 <= q0; q1 <= q1;
			ELSIF(clk'event AND clk='1') THEN
					IF (q0 = "1001") THEN q0 <= "0000"; q1 <= q1 + 1;
					ELSIF (q0 = "0011" and q1 = "0010") THEN q0 <= "0000"; q1 <= "0000";
					ELSE q0 <= q0 + 1;
					END IF;
			END IF;
		END IF;
	END process;
END behav;