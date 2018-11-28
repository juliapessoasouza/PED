
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity polyB is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           x1, x2 : in STD_LOGIC_VECTOR (11 downto 0);
           y : out STD_LOGIC_VECTOR (11 downto 0);
           ready : out STD_LOGIC);
end polyB;

architecture Behavioral of polyB is

component ula_fixp_nolatch is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);
           oper : in STD_LOGIC_VECTOR (11 downto 0);
           lopA : in STD_LOGIC;
           lopB : in STD_LOGIC;
           saida : out STD_LOGIC_VECTOR (11 downto 0);
           ready_oper : out STD_LOGIC;
           ready : out STD_LOGIC);
end component;

-- parametros
constant p1 :std_logic_vector(11 downto 0) := "000011000000";-- +3.0 --"111101000000";-- -3.0
constant p2 :std_logic_vector(11 downto 0) := "000010000000";-- +2.0 
 
-- sinais da FSM
type t_state is (inicio,e0a,e0b,e0c,e1a,e1b,e1c,e2a,e2b,e2c,e3a,e3b,e3c,e4a,e4b,e4c);
signal state : t_state := inicio;

-- sinais intermediarios
signal oper_ula1 : std_logic_vector(11 downto 0) := (others=>'0');
signal oper_ula2 : std_logic_vector(11 downto 0) := (others=>'0');
signal saida_ula1 : std_logic_vector(11 downto 0) := (others=>'0');
signal saida_ula2 : std_logic_vector(11 downto 0) := (others=>'0');
signal sel_ula1 : std_logic_vector(3 downto 0) := (others=>'0');
signal sel_ula2 : std_logic_vector(3 downto 0) := (others=>'0');
signal lopa_ula1 : std_logic := '0';
signal lopa_ula2 : std_logic := '0';
signal lopb_ula1 : std_logic := '0';
signal lopb_ula2 : std_logic := '0';
signal start_ula1 : std_logic := '0';
signal start_ula2 : std_logic := '0';
signal ready_ula1 : std_logic := '0';
signal ready_ula2 : std_logic := '0';
signal ready_oper1 : std_logic := '0';
signal ready_oper2 : std_logic := '0';
signal oper_ula3 : std_logic_vector(11 downto 0) := (others=>'0');
signal saida_ula3 : std_logic_vector(11 downto 0) := (others=>'0');
signal sel_ula3 : std_logic_vector(3 downto 0) := (others=>'0');
signal lopa_ula3 : std_logic := '0';
signal lopb_ula3 : std_logic := '0';
signal start_ula3 : std_logic := '0';
signal ready_ula3 : std_logic := '0';
signal ready_oper3 : std_logic := '0';

signal p1x2,x12,p2x12,x1x2,p1x2p2x12, aux : std_logic_vector(11 downto 0) := (others=>'0');

begin

ula1 : ula_fixp_nolatch port map(
    reset => reset,
    clk => clk,
    start => start_ula1,
    sel => sel_ula1,
    oper => oper_ula1,
    lopA => lopa_ula1,
    lopB => lopb_ula1,
    saida => saida_ula1,
    ready_oper => ready_oper1,
    ready => ready_ula1);

ula2 : ula_fixp_nolatch port map(
    reset => reset,
    clk => clk,
    start => start_ula2,
    sel => sel_ula2,
    oper => oper_ula2,
    lopA => lopa_ula2,
    lopB => lopb_ula2,
    saida => saida_ula2,
    ready_oper => ready_oper2,
    ready => ready_ula2);
    
ula3 : ula_fixp_nolatch port map(
        reset => reset,
        clk => clk,
        start => start_ula3,
        sel => sel_ula3,
        oper => oper_ula3,
        lopA => lopa_ula3,
        lopB => lopb_ula3,
        saida => saida_ula3,
        ready_oper => ready_oper3,
        ready => ready_ula3);

-- FSM em um unico processo
process(clk,reset)
begin
    if reset ='1' then
        state <= inicio;
        y <= (others=>'0');
        ready <= '0';
    elsif rising_edge(clk) then    
        case state is
            when inicio =>
                ready <= '0';
                if start = '1' then
                    oper_ula1 <= x2;
                    oper_ula2 <= x1;
                    oper_ula3 <= x1;
                    lopa_ula1 <= '1';
                    lopa_ula2 <= '1';
                    lopa_ula3 <= '1';
                    state <= e0a;
                end if;
            when e0a => 
                lopa_ula1 <= '0';
                lopa_ula2 <= '0';
                lopa_ula3 <= '0';
                if ready_oper2='1' then
                    oper_ula1 <= p1;
                    oper_ula2 <= x1;
                    oper_ula3 <= x2;
                    lopb_ula1 <= '1';
                    lopb_ula2 <= '1';
                    lopb_ula3 <= '1';
                    state <= e0b;
                end if;

            when e0b =>
                lopb_ula1 <= '0';
                lopb_ula2 <= '0';
                lopb_ula3 <= '0';
                if ready_oper2='1' then
                    sel_ula1 <= "0010";
                    sel_ula2 <= "0010";
                    sel_ula3 <= "0010";
                    start_ula1 <= '1';
                    start_ula2 <= '1';
                    start_ula3 <= '1';
                    state <= e0c;
                end if;

            when e0c =>
                start_ula1 <= '0';
                start_ula2 <= '0';
                start_ula3 <= '0';
                if ready_ula2 = '1' then
                    oper_ula1 <= saida_ula1;
                    oper_ula2 <= saida_ula2;
                    oper_ula3 <= saida_ula3;
                    lopa_ula1 <= '1';
                    lopa_ula2 <= '1';
                    lopa_ula3 <= '1';
                    p1x2 <= saida_ula1;
                    x12 <= saida_ula2;
                    x1x2 <= saida_ula3;
                    state <= e1a;
                end if; 
            when e1a =>
                lopa_ula1 <= '0';
                if ready_oper2='1' then
                    oper_ula1 <= p2;
                    lopb_ula1 <= '1';
                    state <= e1b;
                end if;

            when e1b =>
                lopb_ula1 <= '0';
                if ready_oper2='1' then
                    sel_ula1 <= "0010";
                    start_ula1 <= '1';
                    state <= e1c;
                end if;

            when e1c => 
                start_ula1 <= '0';
                if ready_ula2 = '1' then
                    oper_ula1 <= saida_ula1;
                    lopa_ula1 <= '1';
                    p2x12 <= saida_ula1;
                    state <= e2a;
                end if; 

            when e2a =>
                lopa_ula1 <= '0';
                if ready_oper2='1' then
                    oper_ula1 <= p1x2;
                    lopb_ula1 <= '1';
                    state <= e2b;
                end if;

            when e2b =>
                lopb_ula1 <= '0';
                if ready_oper2='1' then
                    sel_ula1 <= "0000";
                    start_ula1 <= '1';
                    state <= e2c;
                end if;

            when e2c => 
                start_ula1 <= '0';
                if ready_ula1 = '1' then
                    oper_ula1 <= saida_ula1;
                    lopa_ula1 <= '1';
                    p1x2p2x12<= saida_ula1;

                    state <= e3a;
                end if; 
     
            when e3a =>
                lopa_ula2 <= '0';
                if ready_oper2='1' then
                    oper_ula2 <= x1x2;
                    lopb_ula2 <= '1';
                    state <= e3b;
                end if;

            when e3b =>
                lopb_ula2 <= '0';
                if ready_oper2='1' then
                    sel_ula2 <= "0000";
                    start_ula2 <= '1';
                    state <= e4c;
                end if;

--            when e3c => 
--                start_ula2 <= '0';
--                if ready_ula2 = '1' then
--                    oper_ula2 <= saida_ula2;
--                    lopa_ula2 <= '1';
--                    aux <= saida_ula2;
--                    state <= e4a;
--                end if;

--            when e4a =>
--                lopa_ula2 <= '0';
--                if ready_oper2='1' then
--                    oper_ula2 <= d;
--                    lopb_ula2 <= '1';
--                    state <= e4b;
--                 end if;

--            when e4b =>
--                lopb_ula2 <= '0';
--                if ready_oper2='1' then
--                    sel_ula2 <= "0000";
--                    start_ula2 <= '1';
--                    state <= e4c;
--                 end if;

            when e4c =>
                start_ula2 <= '0';
                if ready_ula2 = '1' then
                    ready <= '1';
                    y <= saida_ula2;
                    state <= inicio;
                end if;
                
            when others => state <= inicio; 
        end case;
    end if;
end process;

end Behavioral;
