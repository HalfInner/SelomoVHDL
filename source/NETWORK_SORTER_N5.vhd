----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    15:11:12 04/25/2020
-- Design Name:
-- Module Name:    network_sorter_n5 - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
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
  use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NETWORK_SORTER_N5 is
  port (
    I_VALUE_0      : in    std_logic_vector(3 downto 0);
    I_VALUE_1      : in    std_logic_vector(3 downto 0);
    I_VALUE_2      : in    std_logic_vector(3 downto 0);
    I_VALUE_3      : in    std_logic_vector(3 downto 0);
    I_VALUE_4      : in    std_logic_vector(3 downto 0);

    O_VALUE_SORT_0 : out   std_logic_vector(3 downto 0);
    O_VALUE_SORT_1 : out   std_logic_vector(3 downto 0);
    O_VALUE_SORT_2 : out   std_logic_vector(3 downto 0);
    O_VALUE_SORT_3 : out   std_logic_vector(3 downto 0);
    O_VALUE_SORT_4 : out   std_logic_vector(3 downto 0)
  );
end entity NETWORK_SORTER_N5;

architecture BEHAVIORAL of NETWORK_SORTER_N5 is

  signal w_comparator_0_level_0_3 : std_logic_vector(3 downto 0);
  signal w_comparator_0_level_3_4 : std_logic_vector(3 downto 0);

  signal w_comparator_1_level_0_2 : std_logic_vector(3 downto 0);
  signal w_comparator_1_level_2_4 : std_logic_vector(3 downto 0);
  signal w_comparator_1_level_4_5 : std_logic_vector(3 downto 0);

  signal w_comparator_2_level_1_2 : std_logic_vector(3 downto 0);
  signal w_comparator_2_level_2_4 : std_logic_vector(3 downto 0);
  signal w_comparator_2_level_4_5 : std_logic_vector(3 downto 0);

  signal w_comparator_3_level_0_2 : std_logic_vector(3 downto 0);
  signal w_comparator_3_level_2_3 : std_logic_vector(3 downto 0);
  signal w_comparator_3_level_3_4 : std_logic_vector(3 downto 0);

  signal w_comparator_4_level_0_1 : std_logic_vector(3 downto 0);
  signal w_comparator_4_level_1_2 : std_logic_vector(3 downto 0);

begin

  -- level 0
  comparator_0_1_level_0 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => I_VALUE_0,
      I_VALUE_B => I_VALUE_1,
      O_MIN     => w_comparator_0_level_0_3,
      O_MAX     => w_comparator_1_level_0_2
    );

  comparator_3_4_level_0 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => I_VALUE_3,
      I_VALUE_B => I_VALUE_4,
      O_MIN     => w_comparator_3_level_0_2,
      O_MAX     => w_comparator_4_level_0_1
    );

  -- level 1
  comparator_2_4_level_1 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => I_VALUE_2,
      I_VALUE_B => w_comparator_4_level_0_1,
      O_MIN     => w_comparator_2_level_1_2,
      O_MAX     => w_comparator_4_level_1_2
    );

  -- level 2
  comparator_2_3_level_2 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => w_comparator_2_level_1_2,
      I_VALUE_B => w_comparator_3_level_0_2,
      O_MIN     => w_comparator_2_level_2_4,
      O_MAX     => w_comparator_3_level_2_3
    );

  comparator_1_4_level_2 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => w_comparator_1_level_0_2,
      I_VALUE_B => w_comparator_4_level_1_2,
      O_MIN     => w_comparator_1_level_2_4,
      O_MAX     => O_VALUE_SORT_4
    );

  -- level 3
  comparator_0_3_level_3 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => w_comparator_0_level_0_3,
      I_VALUE_B => w_comparator_3_level_2_3,
      O_MIN     => w_comparator_0_level_3_4,
      O_MAX     => w_comparator_3_level_3_4
    );

  -- level 4
  comparator_0_2_level_4 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => w_comparator_0_level_3_4,
      I_VALUE_B => w_comparator_2_level_2_4,
      O_MIN     => O_VALUE_SORT_0,
      O_MAX     => w_comparator_2_level_4_5
    );

  comparator_1_3_level_4 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => w_comparator_1_level_2_4,
      I_VALUE_B => w_comparator_3_level_3_4,
      O_MIN     => w_comparator_1_level_4_5,
      O_MAX     => O_VALUE_SORT_3
    );

  -- level 5
  comparator_1_2_level_5 : entity work.NETWORK_SORTER_B4_COMPARATOR port map (
      I_VALUE_A => w_comparator_1_level_4_5,
      I_VALUE_B => w_comparator_2_level_4_5,
      O_MIN     => O_VALUE_SORT_1,
      O_MAX     => O_VALUE_SORT_2
    );

end architecture BEHAVIORAL;

