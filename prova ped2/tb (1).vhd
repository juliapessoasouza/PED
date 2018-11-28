library ieee;
use ieee.std_logic_1164.all;

entity tb_polyB is
end tb_polyB;

architecture tb of tb_polyB is

    component polyB
        port (clk   : in std_logic;
              reset : in std_logic;
              start : in std_logic;
              x1    : in std_logic_vector (11 downto 0);
              x2    : in std_logic_vector (11 downto 0);
              y     : out std_logic_vector (11 downto 0);
              ready : out std_logic);
    end component;

    signal clk   : std_logic;
    signal reset : std_logic;
    signal start : std_logic;
    signal x1    : std_logic_vector (11 downto 0);
    signal x2    : std_logic_vector (11 downto 0);
    signal y     : std_logic_vector (11 downto 0);
    signal ready : std_logic;

    constant TbPeriod : time := 400 ns; 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : polyB
    port map (clk   => clk,
              reset => reset,
              start => start,
              x1    => x1,
              x2    => x2,
              y     => y,
              ready => ready);

    TbClock <= not TbClock after TbPeriod/8 when TbSimEnded /= '1' else '0';
    clk <= TbClock;

    estimulo : process
    begin
        start <= '0';
        x1 <= (others => '0');
        x2 <= (others => '0');

        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for TbPeriod/4;
        start <= '1';
        x1 <= "000011001010";
        x2 <= "000010101010";
        wait for TbPeriod/4;
        x1 <= "000010001010";
        x2 <= "000010111010";
        wait for TbPeriod/4;
        x1 <= "000010111010";
        x2 <= "000010101000";

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;