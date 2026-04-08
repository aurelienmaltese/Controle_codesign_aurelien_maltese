library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port (
        clk_50MHz    : in  std_logic;
        reset_n      : in  std_logic;
        op_sel       : in  std_logic_vector(1 downto 0);
        data_capture : in  std_logic
        -- ... autres ports si nécessaire
    );
end entity top_level;

architecture rtl of top_level is
    -- Déclarations internes (signaux, composants)
begin

    -- Instanciation des modules capteurs_sol et calculateur_cable
    -- Exemple :
    -- u_capteurs: entity work.capteurs_sol
    --     port map(
    --         clk => clk_50MHz,
    --         reset => reset_n,
    --         ...
    --     );

end architecture rtl;