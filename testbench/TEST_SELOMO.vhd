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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.COMMON.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TEST_SELOMO IS
END TEST_SELOMO;
 
ARCHITECTURE behavior OF TEST_SELOMO IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SELOMO
    PORT(
    I_OPERATION    : in t_selomo_operation;
    O_RESULT       : out t_selomo_result;
         I_CLK : IN  std_logic;
         I_RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal r_operations : t_selomo_operation;
   signal r_clk : std_logic := '0';
   signal r_rst : std_logic := '0';

 	--Outputs
   signal r_result : t_selomo_result;

   -- Clock period definitions
   constant r_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SELOMO PORT MAP (
          I_OPERATION => r_operations,
          O_RESULT => r_result,
          I_CLK => r_clk,
          I_RST => r_rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		r_clk <= '0';
		wait for r_clk_period/2;
		r_clk <= '1';
		wait for r_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for r_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
