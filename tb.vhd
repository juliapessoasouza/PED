----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2017 11:44:32
-- Design Name: 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is

end tb;

architecture Behavioral of tb is
component polyB is 
    Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       start : in STD_LOGIC;
       x1, x2 : in STD_LOGIC_VECTOR (11 downto 0);
       y : out STD_LOGIC_VECTOR (11 downto 0);
       ready : out STD_LOGIC);
end component;
signal sclk, sreset, sstart, sready: std_logic;
signal sx1, sx2, sy: STD_LOGIC_VECTOR (11 downto 0);
begin

uut: polyB port map (clk => sclk, reset => sreset, start => sstart, x1 => sx1, x2 => sx2, y => sy, ready => sready);

estimulo: process
begin
sclk <= '0'; sreset <= '0'; sstart <= '0'; sx1 <= "000001111001"; sx2 <= "000001111001";
wait for 20ns;
 sclk <= '1'; sreset <= '0'; sstart <= '1'; sx1 <= "000001101001"; sx2 <= "000000111001";
 wait for 20ns
 
end Behavioral;
