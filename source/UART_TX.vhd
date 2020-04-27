----------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
----------------------------------------------------------------------
-- This file contains the UART Transmitter.  This transmitter is able
-- to transmit 8 bits of serial data, one start bit, one stop bit,
-- and no parity bit.  When transmit is complete o_TX_Done will be
-- driven high for one clock cycle.
--
-- Set Generic g_CLKS_PER_BIT as follows:
-- g_CLKS_PER_BIT = (Frequency of i_Clk)/(Frequency of UART)
-- Example: 10 MHz Clock, 115200 baud UART
-- (10000000)/(115200) = 87
--

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity UART_TX is
  generic (
    -- 12MHz / 9600 baudrate
    G_CLKS_PER_BIT : integer := 1250     -- Needs to be set correctly
    --G_CLKS_PER_BIT : integer := 3     -- Needs to be set correctly
  );
  port (
    I_CLK       : in    std_logic;
    I_TX_DV     : in    std_logic;
    I_TX_BYTE   : in    std_logic_vector(7 downto 0);
    O_TX_ACTIVE : out   std_logic;
    O_TX_SERIAL : out   std_logic;
    O_TX_DONE   : out   std_logic
  );
end entity UART_TX;

architecture RTL of UART_TX is

  type t_sm_main is (
    s_Idle, s_TX_Start_Bit, s_TX_Data_Bits,
    s_TX_Stop_Bit, s_Cleanup
  );

  signal r_sm_main   : t_sm_main := s_Idle;

  signal r_clk_count : integer range 0 to g_CLKS_PER_BIT - 1 := 0;
  signal r_bit_index : integer range 0 to 7 := 0;  -- 8 Bits Total
  signal r_tx_data   : std_logic_vector(7 downto 0) := (others => '0');
  signal r_tx_done   : std_logic := '0';

begin

  P_UART_TX : process (i_Clk) is
  begin

    if (i_Clk'event and i_Clk = '1') then

      case r_sm_main is

        when s_Idle =>
          o_TX_Active <= '0';
          o_TX_Serial <= '1';         -- Drive Line High for Idle
          r_tx_done   <= '0';
          r_clk_count <= 0;
          r_bit_index <= 0;

          if (i_TX_DV = '1') then
            r_tx_data <= i_TX_Byte;
            r_sm_main <= s_TX_Start_Bit;
          else
            r_sm_main <= s_Idle;
          end if;

        -- Send out Start Bit. Start bit = 0
        when s_TX_Start_Bit =>
          o_TX_Active <= '1';
          o_TX_Serial <= '0';

          -- Wait g_CLKS_PER_BIT-1 clock cycles for start bit to finish
          if (r_clk_count < g_CLKS_PER_BIT - 1) then
            r_clk_count <= r_clk_count + 1;
            r_sm_main   <= s_TX_Start_Bit;
          else
            r_clk_count <= 0;
            r_sm_main   <= s_TX_Data_Bits;
          end if;

        -- Wait g_CLKS_PER_BIT-1 clock cycles for data bits to finish
        when s_TX_Data_Bits =>
          o_TX_Serial <= r_tx_data(r_bit_index);

          if (r_clk_count < g_CLKS_PER_BIT - 1) then
            r_clk_count <= r_clk_count + 1;
            r_sm_main   <= s_TX_Data_Bits;
          else
            r_clk_count <= 0;

            -- Check if we have sent out all bits
            if (r_bit_index < 7) then
              r_bit_index <= r_bit_index + 1;
              r_sm_main   <= s_TX_Data_Bits;
            else
              r_bit_index <= 0;
              r_sm_main   <= s_TX_Stop_Bit;
            end if;
          end if;

        -- Send out Stop bit.  Stop bit = 1
        when s_TX_Stop_Bit =>
          o_TX_Serial <= '1';

          -- Wait g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if (r_clk_count < g_CLKS_PER_BIT - 1) then
            r_clk_count <= r_clk_count + 1;
            r_sm_main   <= s_TX_Stop_Bit;
          else
            r_tx_done   <= '1';
            r_clk_count <= 0;
            r_sm_main   <= s_Cleanup;
          end if;

        -- Stay here 1 clock
        when s_Cleanup =>
          o_TX_Active <= '0';
          r_tx_done   <= '1';
          r_sm_main   <= s_Idle;

        when others =>
          r_sm_main <= s_Idle;

      end case;

    end if;

  end process P_UART_TX;

  o_TX_Done <= r_tx_done;

end architecture RTL;
