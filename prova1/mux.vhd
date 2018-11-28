
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity MUX is
    Port (f1:  in STD_LOGIC;
          f2:  in STD_LOGIC;
          f3:  in STD_LOGIC;
          f4:  in STD_LOGIC;
          SEL: in STD_LOGIC_VECTOR (1 DOWNTO 0);
          led: OUT STD_LOGIC);
end MUX;

architecture Behavioral of MUX is

begin

PROCESS (SEL)
BEGIN
CASE SEL IS

WHEN "00" =>led<= f1;
WHEN "01" =>led<= f2;
WHEN "10" =>led<= f3;
WHEN "11" =>led<= f4;
when others =>led<= '0';


END CASE;
END PROCESS;



end Behavioral;
