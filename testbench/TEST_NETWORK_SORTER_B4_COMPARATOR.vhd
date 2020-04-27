--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   21:15:08 04/27/2020
-- Design Name:
-- Module Name:   /home/halfsinner/NetworkSorterVHDL/testbench/TEST_NETWORK_SORTER_B4_COMPARATOR.vhd
-- Project Name:  FPGA_learn
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: NETWORK_SORTER_B4_COMPARATOR
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity TEST_NETWORK_SORTER_B4_COMPARATOR is
end entity TEST_NETWORK_SORTER_B4_COMPARATOR;

architecture BEHAVIOR of TEST_NETWORK_SORTER_B4_COMPARATOR is

  -- Component Declaration for the Unit Under Test (UUT)

  component NETWORK_SORTER_B4_COMPARATOR is
    port (
      I_VALUE_A : in    std_logic_vector(3 downto 0);
      I_VALUE_A : in    std_logic_vector(3 downto 0);
      O_MIN     : out   std_logic_vector(3 downto 0);
      O_MAX     : out   std_logic_vector(3 downto 0)
    );
  end component;

  --Inputs
  signal r_value_a : std_logic_vector(3 downto 0) := (others => '0');
  signal r_value_b : std_logic_vector(3 downto 0) := (others => '0');

  signal r_min     : std_logic_vector(3 downto 0) := (others => '0');
  signal r_max     : std_logic_vector(3 downto 0) := (others => '0');

begin

  -- Instantiate the Unit Under Test (UUT)
  UUT : NETWORK_SORTER_B4_COMPARATOR
    port map (
      I_VALUE_A => r_value_a,
      I_VALUE_A => r_value_b,
      O_MIN     => r_min,
      O_MAX     => r_max
    );

  -- Clock process definitions

  -- Stimulus process
  STIM_PROC : process
  begin

    -- hold reset state for 100 ns.
    wait for 100 ns;

    r_value_b <= X"9";
    r_value_a <= r_value_b;
    wait for 5 ns;
    assert r_min <= r_max report "MIN must be less or equal to MAX" severity error;

    r_value_a <= X"2";
    wait for 5 ns;
    assert r_value_a = MIN report "Value must MIN" severity error;
    assert r_min <= r_max report "MIN must be less or equal to MAX" severity error;

    r_value_a <= X"C";
    wait for 5 ns;
    assert r_value_a = MAX report "Value must MAX" severity error;
    assert r_min <= r_max report "MIN must be less or equal to MAX" severity error;

    wait;

  end process STIM_PROC;

end architecture BEHAVIOR;
