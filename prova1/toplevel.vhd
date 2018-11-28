
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity toplevel is
    Port ( clk100 : in STD_LOGIC;
           preset : in STD_LOGIC_VECTOR (22 DOWNTO 0);
           sel : in STD_LOGIC_VECTOR (1 DOWNTO 0);
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           sentido : in STD_LOGIC);
end toplevel;

architecture Behavioral of toplevel is
signal led: STD_LOGIC;
signal saida: STD_LOGIC_VECTOR (13 DOWNTO 0);
signal f1: STD_LOGIC;
signal f2: STD_LOGIC;
signal f3: STD_LOGIC;
signal f4: STD_LOGIC;

component mux is
    Port (f1:  in STD_LOGIC;
      f2:  in STD_LOGIC;
      f3:  in STD_LOGIC;
      f4:  in STD_LOGIC;
      SEL: in STD_LOGIC_VECTOR (1 DOWNTO 0);
      led: OUT STD_LOGIC);
       
end component;

component DivisorClk is 
    Port ( clk100 : in STD_LOGIC;
       CLKout1 : out STD_LOGIC);
end component;

component cont is
  Port (clk: in std_logic;
      reset: in std_logic;
      enable: in std_logic;
      sentido: in std_logic;
      saida: out std_logic_vector (13 downto 0));
end component;

component DivClk2 is
    Port ( clk100 : in STD_LOGIC;
       CLKout2 : out STD_LOGIC);
end component;

component DivClk3 is
    Port ( clk100 : in STD_LOGIC;
       CLKout3 : out STD_LOGIC);
end component;


begin
DiviClk1: DivisorClk port map(
            clk100 => clk100, 
            clkout1 => f1);
DiviClk2: DivClk2 port map(
            clk100 => clk100, 
            clkout2 => f2);
DiviClk3: DivClk3 port map(
            clk100 => clk100, 
            clkout3 => f3);
DiviClk4: DivisorClk port map(
            clk100 => clk100, 
            clkout1 => f4);
Multiplexador: MUX port map(
             f1 => f1, 
             f2 => f2, 
             f3 => f3, 
             f4 => f4, 
             sel => sel, 
             led => led);
Contador: cont port map(
             enable => enable, 
             clk => led, 
             reset => reset, 
             sentido => sentido, 
             saida => saida);

end Behavioral;
