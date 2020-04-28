--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   00:50:49 04/26/2020
-- Design Name:
-- Module Name:   /home/halfsinner/FPGA_learn/test_SELOMO_UI.vhd
-- Project Name:  FPGA_learn
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: SELOMO_UI
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

entity TEST_SELOMO_UI is
end entity TEST_SELOMO_UI;

architecture BEHAVIOR of TEST_SELOMO_UI is

  -- Component Declaration for the Unit Under Test (UUT)

  component SELOMO_UI is
    port (
      I_UART_RX     : in    std_logic;
      O_LED_CONTROL : out   std_logic;
      O_LED_SELOMO  : out   std_logic;
      I_CLK         : in    std_logic;
      I_RST         : in    std_logic
    );
  end component;

  signal r_clk : std_logic := '0';
  signal r_rst : std_logic := '0';

  signal r_uart_rx : std_logic := '1';
  signal w_led_control : std_logic;
  signal w_led_selomo : std_logic;

  -- Clock period definitions
  -- 1/12Mhz to ns
  constant r_clk_period : time := 83 ns;

  -- 1/buadrate = 1/9600 s to ns
  constant c_bit_period : time := 104167 ns;

  constant c_stop_uart : std_logic_vector(7 downto 0) := X"00";
  constant c_sub_one_uart : std_logic_vector(7 downto 0) := X"01";
  constant c_add_one_uart : std_logic_vector(7 downto 0) := X"02";
  constant c_shift_right_uart : std_logic_vector(7 downto 0) := X"03";

  signal byte_tmp  : std_logic_vector(7 downto 0);
  -- Low-level byte-write
  procedure UART_WRITE_BYTE (
    i_data_in       : in  std_logic_vector(7 downto 0);
    signal o_serial : out std_logic) is
  begin

    -- Send Start Bit
    o_serial <= '0';
    wait for c_BIT_PERIOD;

    -- Send Data Byte
    for ii in 0 to 7 loop
      o_serial <= i_data_in(ii);
      wait for c_BIT_PERIOD;
    end loop;  -- ii

    -- Send Stop Bit
    o_serial <= '1';
    wait for c_BIT_PERIOD;

    assert false report "Check finish one frame time stamp" severity warning;

  end PROCEDURE UART_WRITE_BYTE;

BEGIN

-- Instantiate the Unit Under Test (UUT)
   uut: SELOMO_UI PORT MAP (
          I_UART_RX => r_uart_rx,
          O_LED_CONTROL => w_led_control,
          O_LED_SELOMO => w_led_selomo,
          I_CLK => r_clk,
          I_RST => not r_rst
        );

-- Clock process definitions
R_CLK_PROCESS : process
begin

  r_clk <= '0';
  wait for r_clk_period / 2;
  r_clk <= '1';
  wait for r_clk_period / 2;

end process R_CLK_PROCESS;

-- Stimulus process
STIM_PROC : process
begin

  r_rst <= '1';
  wait for 100ns;
  -- Tell the UART to send a command.
  r_rst <= '0';
  wait until r_clk'event and r_clk = '1';
  wait until r_clk'event and r_clk = '1';

  -- Iterate over each state -> to eleventh
  for ii in 0 to 11 loop
    UART_WRITE_BYTE(c_sub_one_uart, r_uart_rx);
    wait until r_clk'event and r_clk = '1';
  end loop;  -- ii

  UART_WRITE_BYTE(c_stop_uart, r_uart_rx);
  wait until r_clk'event and r_clk = '1';
  assert w_led_selomo = '1' report "Initial state must be even/zeroth" severity error;

  -- Iterate to 6th and shift twice
  for ii in 0 to 6 loop
    UART_WRITE_BYTE(c_add_one_uart, r_uart_rx);
    wait until r_clk'event and r_clk = '1';
  end loop;

  UART_WRITE_BYTE(c_shift_right_uart, r_uart_rx);
  wait until r_clk'event and r_clk = '1';
  UART_WRITE_BYTE(c_shift_right_uart, r_uart_rx);
  wait until r_clk'event and r_clk = '1';
  assert w_led_selomo = '0' report "Initial state must be odd/2" severity error;

  wait;

end process STIM_PROC;

END;
