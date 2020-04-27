--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   16:40:05 04/25/2020
-- Design Name:
-- Module Name:   /home/halfsinner/NetworkSorterVHDL/testbench/TEST_NETWORK_SORTER_N5.vhd
-- Project Name:  FPGA_learn
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: NETWORK_SORTER_N5
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

entity TEST_NETWORK_SORTER_N5 is
end entity TEST_NETWORK_SORTER_N5;

architecture BEHAVIOR of TEST_NETWORK_SORTER_N5 is

  -- Component Declaration for the Unit Under Test (UUT)

  component NETWORK_SORTER_N5 is
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
  end component;

  --Inputs
  signal r_value_0      : std_logic_vector(3 downto 0) := (others => '0');
  signal r_value_1      : std_logic_vector(3 downto 0) := (others => '0');
  signal r_value_2      : std_logic_vector(3 downto 0) := (others => '0');
  signal r_value_3      : std_logic_vector(3 downto 0) := (others => '0');
  signal r_value_4      : std_logic_vector(3 downto 0) := (others => '0');

  --Outputs
  signal r_value_sort_0 : std_logic_vector(3 downto 0);
  signal r_value_sort_1 : std_logic_vector(3 downto 0);
  signal r_value_sort_2 : std_logic_vector(3 downto 0);
  signal r_value_sort_3 : std_logic_vector(3 downto 0);
  signal r_value_sort_4 : std_logic_vector(3 downto 0);

begin

  -- Instantiate the Unit Under Test (UUT)
  UUT : NETWORK_SORTER_N5
    port map (
      I_VALUE_0      => r_value_0,
      I_VALUE_1      => r_value_1,
      I_VALUE_2      => r_value_2,
      I_VALUE_3      => r_value_3,
      I_VALUE_4      => r_value_4,

      O_VALUE_SORT_0 => r_value_sort_0,
      O_VALUE_SORT_1 => r_value_sort_1,
      O_VALUE_SORT_2 => r_value_sort_2,
      O_VALUE_SORT_3 => r_value_sort_3,
      O_VALUE_SORT_4 => r_value_sort_4
    );

  -- Stimulus process
  STIM_PROC : process
  begin

    wait for 100ns;

    -- full iteration begin
    -- sorted asceding
    r_value_0 <= X"0";
    r_value_1 <= X"1";
    r_value_2 <= X"2";
    r_value_3 <= X"3";
    r_value_4 <= X"4";
    wait for 10ns;
    assert r_value_sort_0 < r_value_sort_1 report "Not sorted" severity error;
    assert r_value_sort_1 < r_value_sort_2 report "Not sorted" severity error;
    assert r_value_sort_2 < r_value_sort_3 report "Not sorted" severity error;
    assert r_value_sort_3 < r_value_sort_4 report "Not sorted" severity error;
    -- full iteration end

    -- full iteration begin
    -- sorted descending
    r_value_0 <= X"F";
    r_value_1 <= X"E";
    r_value_2 <= X"D";
    r_value_3 <= X"C";
    r_value_4 <= X"B";
    wait for 10ns;
    assert r_value_sort_0 < r_value_sort_1 report "Not sorted" severity error;
    assert r_value_sort_1 < r_value_sort_2 report "Not sorted" severity error;
    assert r_value_sort_2 < r_value_sort_3 report "Not sorted" severity error;
    assert r_value_sort_3 < r_value_sort_4 report "Not sorted" severity error;
    -- full iteration end

    -- full iteration begin
    -- first element not sorted
    r_value_0 <= X"F";
    r_value_1 <= X"0";
    r_value_2 <= X"1";
    r_value_3 <= X"2";
    r_value_4 <= X"3";
    wait for 10ns;
    assert r_value_sort_0 < r_value_sort_1 report "Not sorted" severity error;
    assert r_value_sort_1 < r_value_sort_2 report "Not sorted" severity error;
    assert r_value_sort_2 < r_value_sort_3 report "Not sorted" severity error;
    assert r_value_sort_3 < r_value_sort_4 report "Not sorted" severity error;
    -- full iteration end

    -- full iteration begin
    -- last element not sorted
    r_value_0 <= X"B";
    r_value_1 <= X"C";
    r_value_2 <= X"D";
    r_value_3 <= X"E";
    r_value_4 <= X"0";
    wait for 10ns;
    assert r_value_sort_0 < r_value_sort_1 report "Not sorted" severity error;
    assert r_value_sort_1 < r_value_sort_2 report "Not sorted" severity error;
    assert r_value_sort_2 < r_value_sort_3 report "Not sorted" severity error;
    assert r_value_sort_3 < r_value_sort_4 report "Not sorted" severity error;
    -- full iteration end

    -- full iteration begin
    -- shuffled
    r_value_0 <= X"4";
    r_value_1 <= X"2";
    r_value_2 <= X"C";
    r_value_3 <= X"6";
    r_value_4 <= X"9";
    wait for 10 ns;
    assert r_value_sort_0 < r_value_sort_1 report "Not sorted" severity error;
    assert r_value_sort_1 < r_value_sort_2 report "Not sorted" severity error;
    assert r_value_sort_2 < r_value_sort_3 report "Not sorted" severity error;
    assert r_value_sort_3 < r_value_sort_4 report "Not sorted" severity error;
    -- full iteration end

    wait;

  end process STIM_PROC;

end architecture BEHAVIOR;
