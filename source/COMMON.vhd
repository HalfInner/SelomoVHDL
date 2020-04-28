--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package COMMON is

 type t_selomo_operation is (t_substract_one, t_add_one, t_shift_right, t_stop);
 type t_selomo_result is (t_even, t_odd);
 
end COMMON;

package body COMMON is

 
end COMMON;
