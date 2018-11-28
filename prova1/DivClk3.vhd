library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity DivClk3 is
    
    Port ( clk100 : in STD_LOGIC;
           CLKout3 : out STD_LOGIC);
end DivClk3;

architecture Behavioral of DivClk3 is
 --?10011000100101101000000?  para 1Hz
 --?01001100010010110100000? para 2HZ
 --?00010011000100101101000? para 8Hz

signal count : std_logic_vector (22 downto 0) :=(others => '0');
signal clock : std_logic :='0';
constant preset : std_logic_vector(22 downto 0) := "00010011000100101101000"; --numero de bits que precisa para a frequencia desejada

begin
process (clk100)
begin
if rising_edge (clk100) then

   
  if count=preset then
  clock <= not clock;
  count <= (others =>'0');
  
  else 
  count <= (count+1);
   end if;
   
   end if;
   end process;
CLKout3 <= clock;

end Behavioral;
