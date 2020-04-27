----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    21:04:52 04/27/2020
-- Design Name:
-- Module Name:    NETWORK_SORTER_B4_COMPARATOR - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NETWORK_SORTER_B4_COMPARATOR is
  port (
    I_VALUE_A : in    std_logic_vector(3 downto 0);
    I_VALUE_B : in    std_logic_vector(3 downto 0);
    O_MIN     : out   std_logic_vector(3 downto 0);
    O_MAX     : out   std_logic_vector(3 downto 0)
  );
end entity NETWORK_SORTER_B4_COMPARATOR;

architecture BEHAVIORAL of NETWORK_SORTER_B4_COMPARATOR is

begin

  O_MIN <= I_VALUE_A when I_VALUE_A < I_VALUE_B else
           I_VALUE_B;
  O_MAX <= I_VALUE_B when I_VALUE_A < I_VALUE_B else
           I_VALUE_A;

end architecture BEHAVIORAL;

