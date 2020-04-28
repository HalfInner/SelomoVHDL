----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    02:06:52 04/28/2020
-- Design Name:
-- Module Name:    SELOMO - Behavioral
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
  use work.COMMON.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SELOMO is
  port (
    I_OPERATION      : in    t_selomo_operation;
    O_RESULT         : out   t_selomo_result;

    I_CLK            : in    std_logic;
    I_RST            : in    std_logic
  );
end entity SELOMO;

architecture BEHAVIORAL of SELOMO is

  type fsm_selomo_type is (
    ZEROTH, FIRST, SECOND,
    THIRD, FOURTH, FIVETH,
    SIXTH, SEVENTH, EIGHTH,
    NINETH, TENTH, ELEVENTH,
    INIT
  );

  signal fsm_selomo             : fsm_selomo_type := INIT;

begin

  SELOMO_PROCESS : process (I_CLK, I_RST) is
  begin

    if (I_RST = '1') then
      fsm_selomo <= INIT;
    elsif (I_CLK'event and I_CLK = '1') then

      case fsm_selomo is

        when INIT =>
          fsm_selomo <= ZEROTH;

        when ZEROTH =>
          O_RESULT <= t_even;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= ZEROTH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= ZEROTH;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= FIRST;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= ELEVENTH;
          else
            fsm_selomo <= INIT;
          end if;

        when FIRST =>
          O_RESULT <= t_odd;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= FIRST;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= ZEROTH;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= SECOND;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= ZEROTH;
          else
            fsm_selomo <= INIT;
          end if;

        when SECOND =>
          O_RESULT <= t_even;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= SECOND;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= FIRST;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= THIRD;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= FIRST;
          else
            fsm_selomo <= INIT;
          end if;

        when THIRD =>
          O_RESULT <= t_odd;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= THIRD;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= FIRST;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= FOURTH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= SECOND;
          else
            fsm_selomo <= INIT;
          end if;

        when FOURTH =>
          O_RESULT <= t_even;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= FOURTH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= SECOND;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= FIVETH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= THIRD;
          else
            fsm_selomo <= INIT;
          end if;

        when FIVETH =>
          O_RESULT <= t_odd;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= FIVETH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= SECOND;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= SIXTH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= FOURTH;
          else
            fsm_selomo <= INIT;
          end if;

        when SIXTH =>
          O_RESULT <= t_even;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= SIXTH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= THIRD;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= SEVENTH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= FIVETH;
          else
            fsm_selomo <= INIT;
          end if;

        when SEVENTH =>
          O_RESULT <= t_odd;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= SEVENTH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= THIRD;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= EIGHTH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= SIXTH;
          else
            fsm_selomo <= INIT;
          end if;

        when EIGHTH =>
          O_RESULT <= t_even;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= EIGHTH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= FOURTH;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= NINETH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= SEVENTH;
          else
            fsm_selomo <= INIT;
          end if;

        when NINETH =>
          O_RESULT <= t_odd;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= NINETH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= FOURTH;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= TENTH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= EIGHTH;
          else
            fsm_selomo <= INIT;
          end if;

        when TENTH =>
          O_RESULT <= t_even;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= TENTH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= FIVETH;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= ELEVENTH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= NINETH;
          else
            fsm_selomo <= INIT;
          end if;

        when ELEVENTH =>
          O_RESULT <= t_odd;
          if (I_OPERATION = t_stop) then
            fsm_selomo <= ELEVENTH;
          elsif (I_OPERATION = t_shift_right) then
            fsm_selomo <= FIVETH;
          elsif (I_OPERATION = t_add_one) then
            fsm_selomo <= ZEROTH;
          elsif (I_OPERATION = t_substract_one) then
            fsm_selomo <= TENTH;
          else
            fsm_selomo <= INIT;
          end if;

        when others =>
          fsm_selomo <= INIT;

      end case;

    end if;

  end process SELOMO_PROCESS;

end architecture BEHAVIORAL;

