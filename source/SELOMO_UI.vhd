----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    18:44:04 04/25/2020
-- Design Name:
-- Module Name:    SELOMO_UI - Behavioral
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
  use ieee.numeric_std.all;
  use work.COMMON.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SELOMO_UI is
  port (
    I_UART_RX            : in    std_logic;

    O_LED_CONTROL        : out   std_logic;
    O_LED_SELOMO         : out   std_logic;

    I_CLK                : in    std_logic;
    I_RST                : in    std_logic
  );
end entity SELOMO_UI;

architecture BEHAVIORAL of SELOMO_UI is

  type fsm_ui_type is (
    INIT, READ_VALUE,
    OPERATE,
    UNDEFINED
  );

  signal fsm_ui               : fsm_ui_type := INIT;

  signal w_read_uart_byte     : std_logic_vector(7 downto 0);
  signal r_read_uart_byte     : std_logic_vector(7 downto 0) := (others => '0');

  -- uart
  signal w_receive_done       : std_logic;

  signal rx_running_clock     : std_logic := '0';

  -- new signals
  signal r_operation          : t_selomo_operation := t_stop;
  signal w_result             : t_selomo_result;

  constant c_stop_uart        : std_logic_vector(7 downto 0) := X"00";
  constant c_sub_one_uart     : std_logic_vector(7 downto 0) := X"01";
  constant c_add_one_uart     : std_logic_vector(7 downto 0) := X"02";
  constant c_shift_right_uart : std_logic_vector(7 downto 0) := X"03";

begin

  uart_rx_module : entity work.UART_RX port map (
      I_CLK       => I_CLK,
      I_RX_SERIAL => I_UART_RX,
      O_RX_DV     => w_receive_done,
      O_RX_BYTE   => w_read_uart_byte
    );

  selomo_module : entity work.SELOMO port map (
      I_OPERATION    => r_operation,
      O_RESULT       => w_result,
      I_CLK          => I_CLK,
      I_RST          => not I_RST
    );

  O_LED_CONTROL <= NOT I_UART_RX;
  O_LED_SELOMO  <= '1' when (w_result = t_even) else
                   '0';

  process (I_CLK, I_RST, I_UART_RX) is

    variable counter : integer := 0;

  begin

    if (I_RST = '0') then
      counter := 0;
      fsm_ui    <= INIT;
    elsif (I_CLK'event and I_CLK = '1') then

      case fsm_ui is

        when INIT =>
          counter := 0;
          rx_running_clock <= '1';
          counter := 0;
          fsm_ui <= READ_VALUE;

        when READ_VALUE =>
          r_operation <= t_stop;
          if (w_receive_done = '1') then
            r_read_uart_byte <= w_read_uart_byte;
            fsm_ui           <= OPERATE;
          else
            fsm_ui <= READ_VALUE;
          end if;

        when OPERATE =>

          case r_read_uart_byte is

            when c_stop_uart =>
              r_operation <= t_stop;
            when c_sub_one_uart =>
              r_operation <= t_substract_one;
            when c_add_one_uart =>
              r_operation <= t_add_one;
            when c_shift_right_uart =>
              r_operation <= t_shift_right;
            when others =>
              r_operation <= t_stop;

          end case;

          fsm_ui <= READ_VALUE;

        when others =>
          fsm_ui <= INIT;

      end case;

    end if;

  end process;

end architecture BEHAVIORAL;

