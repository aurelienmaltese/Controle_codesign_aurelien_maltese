--------------------------------------------------------------------------------
-- Bloc calculateur câblé : addition, soustraction, amplification, atténuation
-- Entrées : data_in (8 bits), op_sel (2 bits)
-- Sorties : result (8 bits), data_ready_out (1 bit)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculateur_cable is
    port (
        clk             : in  std_logic;
        reset_n         : in  std_logic;
        data_in         : in  std_logic_vector(7 downto 0);  -- Donnée d'entrée (ex: data0r)
        op_sel          : in  std_logic_vector(1 downto 0);  -- "00"=add, "01"=sub, "10"=ampl, "11"=att
        result          : out std_logic_vector(7 downto 0);  -- Résultat (8 bits)
        data_ready_out  : out std_logic
    );
end calculateur_cable;

architecture RTL of calculateur_cable is

    signal result_reg     : std_logic_vector(7 downto 0) := (others => '0');
    signal data_ready_reg : std_logic := '0';

begin

    process(clk, reset_n)
        variable sum_16bits : unsigned(15 downto 0);
    begin
        if reset_n = '0' then
            result_reg <= (others => '0');
            data_ready_reg <= '0';
        elsif rising_edge(clk) then
            case op_sel is
                when "00" =>  -- Addition
                    sum_16bits := ('0' & unsigned(data_in)) + ('0' & unsigned(data_in));
                    result_reg <= std_logic_vector(sum_16bits(7 downto 0));  -- Tronquage à 8 bits
                when "01" =>  -- Soustraction
                    sum_16bits := ('0' & unsigned(data_in)) - ('0' & unsigned(data_in));
                    result_reg <= std_logic_vector(sum_16bits(7 downto 0));
                when "10" =>  -- Amplification (ex: *2)
                    sum_16bits := ('0' & unsigned(data_in)) * 2;
                    result_reg <= std_logic_vector(sum_16bits(7 downto 0));
                when "11" =>  -- Atténuation (ex: /2)
                    sum_16bits := ('0' & unsigned(data_in)) / 2;
                    result_reg <= std_logic_vector(sum_16bits(7 downto 0));
                when others => null;
            end case;
            data_ready_reg <= '1';
        end if;
    end process;

    result <= result_reg;
    data_ready_out <= data_ready_reg;

end RTL;