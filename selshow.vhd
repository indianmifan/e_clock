library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity selshow is port(
	input:in std_logic_vector(26 downto 0);	--输入时钟频率 目前�?00K
	output:out std_logic_vector(26 downto 0);		--启动信号 高有效，默认应当�? 
	ch,cm,cs,main:in std_logic
		--扬声器频率输�?
);
end entity;

architecture behav of selshow is
begin 
	process(ch,cm,cs,main)
	begin 
 if main='0' then	
	if(ch='1')then output(15 downto 0)<=input(15 downto 0);  output(26 downto 16)<="11111100000";end if;
	if(cm='1')then output(15 downto 8)<="00000000"; output(26 downto 16)<=input(26 downto 16);output(7 downto 0)<=input(7 downto 0);end if;
	if(cs='1')then output(7 downto 0)<="00000000"; output(26 downto 8)<=input(26 downto 18);end if;
else output<=input;
 end if;
	end process;
end architecture;