----------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
----------------------------------------------------------------------
-- This file contains the UART Receiver.  This receiver is able to
-- receive 8 bits of serial data, one start bit, one stop bit,
-- and no parity bit.  When receive is complete o_rx_dv will be
-- driven high for one clock cycle.
--
-- Set Generic g_CLKS_PER_BIT as follows:
-- g_CLKS_PER_BIT = (Frequency of i_Clk)/(Frequency of UART)
-- Example: 10 MHz Clock, 115200 baud UART
-- (10000000)/(115200) = 87
--

library ieee;
  use ieee.std_logic_1164.ALL;
  use ieee.numeric_std.all;

entity UART_RX is
  generic (
    G_CLKS_PER_BIT : integer := 1250     -- Needs to be set correctly
    --    G_CLKS_PER_BIT : integer := 3     -- Needs to be set correctly in UUT
  );
  port (
    I_CLK       : in    std_logic;
    I_RX_SERIAL : in    std_logic;
    O_RX_DV     : out   std_logic;
    O_RX_BYTE   : out   std_logic_vector(7 downto 0)
  );
end entity UART_RX;

architecture RTL of UART_RX is

  type t_sm_main is (
    s_Idle, s_RX_Start_Bit, s_RX_Data_Bits,
    s_RX_Stop_Bit, s_Cleanup
  );

  signal r_sm_main   : t_sm_main := s_Idle;

  signal r_rx_data_r : std_logic := '0';
  signal r_rx_data   : std_logic := '0';

  signal r_clk_count : integer range 0 to g_CLKS_PER_BIT - 1 := 0;
  signal r_bit_index : integer range 0 to 7 := 0;  -- 8 Bits Total
  signal r_rx_byte   : std_logic_vector(7 downto 0);
  signal r_rx_dv     : std_logic := '0';

begin

  -- Purpose: Double-register the incoming data.
  -- This allows it to be used in the UART RX Clock Domain.
  -- (It removes problems caused by metastabiliy)
  P_SAMPLE : process (i_Clk, I_RX_SERIAL) is
  begin

    if (i_Clk'event and i_Clk = '1') then
      r_rx_data_r <= i_RX_Serial;
      r_rx_data   <= r_rx_data_r;
      o_RX_DV     <= r_rx_dv;
      o_RX_Byte   <= r_rx_byte;
    end if;

  end process P_SAMPLE;

  -- Purpose: Control RX state machine
  P_UART_RX : process (i_Clk, I_RX_SERIAL) is
  begin

    if (i_Clk'event and i_Clk = '1') then

      case r_sm_main is

        when s_Idle =>
          r_rx_dv     <= '0';
          r_clk_count <= 0;
          r_bit_index <= 0;

          if (r_rx_data = '0') then       -- Start bit detected
            r_sm_main <= s_RX_Start_Bit;
          else
            r_sm_main <= s_Idle;
          end if;

        -- Check middle of start bit to make sure it's still low
        when s_RX_Start_Bit =>
          if (r_clk_count = (g_CLKS_PER_BIT - 1) / 2) then
            if (r_rx_data = '0') then
              r_clk_count <= 0;           -- reset counter since we found the middle
              r_rx_byte   <= X"00";
              r_sm_main   <= s_RX_Data_Bits;
            else
              r_sm_main   <= s_Idle;
            end if;
          else
            r_clk_count <= r_clk_count + 1;
            r_sm_main   <= s_RX_Start_Bit;
          end if;

        -- Wait g_CLKS_PER_BIT-1 clock cycles to sample serial data
        when s_RX_Data_Bits =>
          if (r_clk_count < g_CLKS_PER_BIT - 1) then
            r_clk_count <= r_clk_count + 1;
            r_sm_main   <= s_RX_Data_Bits;
          else
            r_clk_count            <= 0;
            r_rx_byte(r_bit_index) <= r_rx_data;

            -- Check if we have sent out all bits
            if (r_bit_index < 7) then
              r_bit_index <= r_bit_index + 1;
              r_sm_main   <= s_RX_Data_Bits;
            else
              r_bit_index <= 0;
              r_sm_main   <= s_RX_Stop_Bit;
            end if;
          end if;

        -- Receive Stop bit.  Stop bit = 1
        when s_RX_Stop_Bit =>
          -- Wait g_CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if (r_clk_count < g_CLKS_PER_BIT - 1) then
            r_clk_count <= r_clk_count + 1;
            r_sm_main   <= s_RX_Stop_Bit;
          else
            r_rx_dv     <= '1';
            r_clk_count <= 0;
            r_sm_main   <= s_Cleanup;
          end if;

        -- Stay here 1 clock
        when s_Cleanup =>
          r_sm_main <= s_Idle;
          r_rx_dv   <= '0';

        when others =>
          r_sm_main <= s_Idle;

      end case;

    end if;

  end process P_UART_RX;

end architecture RTL;
