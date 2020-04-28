--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   03:00:23 04/28/2020
-- Design Name:
-- Module Name:   /home/halfsinner/Programming/SelomoVHDL/testbench/TEST_SELOMO.vhd
-- Project Name:  FPGA_learn
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: SELOMO
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
  use work.COMMON.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

entity TEST_SELOMO is
end entity TEST_SELOMO;

architecture BEHAVIOR of TEST_SELOMO is

  -- Component Declaration for the Unit Under Test (UUT)

  component SELOMO is
    port (
      I_OPERATION    : in    t_selomo_operation;
      O_RESULT       : out   t_selomo_result;
      I_CLK          : in    std_logic;
      I_RST          : in    std_logic
    );
  end component;

  --Inputs
  signal r_operations : t_selomo_operation := t_stop;
  signal r_clk        : std_logic := '0';
  signal r_rst        : std_logic := '0';

  --Outputs
  signal r_result     : t_selomo_result;

  -- Clock period definitions
  constant r_clk_period : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  UUT : SELOMO
    port map (
      I_OPERATION => r_operations,
      O_RESULT    => r_result,
      I_CLK       => r_clk,
      I_RST       => r_rst
    );

  -- Clock process definitions
  CLK_PROCESS : process
  begin

    r_clk <= '0';
    wait for r_clk_period / 2;
    r_clk <= '1';
    wait for r_clk_period / 2;

  end process CLK_PROCESS;

  -- Stimulus process
  STIM_PROC : process
  begin

    -- hold reset state for 100 ns.
    wait for 100 ns;

    -- insert stimulus here

    wait for r_clk_period;
    assert r_result = t_even report "Initial state must be even/zero" severity error;

    r_operations <= t_add_one;
    wait for r_clk_period * 5;
    r_operations <= t_stop;
    wait for r_clk_period; -- stabilizing output
    assert r_result = t_odd report "Initial state must be odd/5" severity error;

    r_operations <= t_shift_right;
    wait for r_clk_period;
    r_operations <= t_stop;
    wait for r_clk_period; -- stabilizing output
    assert r_result = t_even report "Initial state must be even/2" severity error;

    r_operations <= t_stop;
    r_rst        <= '1';
    wait for r_clk_period * 5;

    r_rst <= '0';
    wait for r_clk_period;
    r_operations <= t_stop;
    wait for r_clk_period; -- stabilizing output
    assert r_result = t_even report "Initial state must be even/0" severity error;

    r_operations <= t_substract_one;
    wait for r_clk_period;
    r_operations <= t_stop;
    wait for r_clk_period; -- stabilizing output
    assert r_result = t_odd report "Initial state must be even/11" severity error;

    r_operations <= t_shift_right;
    wait for r_clk_period;
    r_operations <= t_stop;
    wait for r_clk_period; -- stabilizing output
    assert r_result = t_odd report "Initial state must be even/5" severity error;

    r_operations <= t_shift_right;
    wait for r_clk_period;
    r_operations <= t_stop;
    wait for r_clk_period; -- stabilizing output
    assert r_result = t_even report "Initial state must be even/2" severity error;

    wait;

  end process STIM_PROC;

end architecture BEHAVIOR;
