
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity cont is
  Port (clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        sentido: in std_logic;
        saida: out std_logic_vector (15 downto 0));
end cont;

architecture Behavioral of cont is
-- Dia do nascimento: 23 (?10111?)
signal count: std_logic_vector (15 downto 0) := (others => '0');
signal ref: std_logic_vector (4 downto 0);

begin
--process (sentido, clk)
--begin
--if enable = '1'then
--if rising_edge (clk) then
--if sentido = '0' then

--    if reset='1' then
--    count <= (others => '0');
--    saida <= count;
    
--    else
--    while  count < "10011100001111" loop
--    count <= (count+ "10111" );
--    saida <= count;
--    end loop;

   
--    end if;
--    end if;
--if rising_edge (clk) then
--else 

--    if reset='1' then
--    count <= "10011100001111";
--    saida <= count;
   
--    else
--    while  count > "00000000000000" loop
--    count <= (count-"10111");
--    saida <= count;
--    end loop;
--    end if;
--end if;
--end if;
--end if;
--end process;
process(clk, sentido)
begin
    if rising_edge(clk) and enable = '0' then
        if reset = '1' then
            count <= (others => '0');
        elsif sentido = '0' then
            count <= count + "10111";
        elsif sentido = '1' then
            count <= count - "10111";
        end if;
    end if;
end process;
end Behavioral;