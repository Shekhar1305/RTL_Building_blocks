----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.07.2026 19:39:21
-- Design Name: 
-- Module Name: n_bit_modm_counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity n_bit_modm_counter is
generic(
            COUNTER_WIDTH: natural := 4
             );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en  : in STD_LOGIC;
           m   : in STD_LOGIC_VECTOR ((COUNTER_WIDTH - 1) downto 0);
           q   : out STD_LOGIC_VECTOR ((COUNTER_WIDTH - 1) downto 0));
end n_bit_modm_counter;

architecture Behavioral of n_bit_modm_counter is
signal r_inc, r_next, r_reg, m_uns: unsigned((COUNTER_WIDTH - 1) downto 0);
begin
m_uns <= unsigned(m);
r_inc <= r_reg + 1;
r_next <= (others => '0') when ( r_inc = m_uns ) or (m_uns = 0) else
           r_inc;
q <= std_logic_vector(r_reg);

next_reg_pr: process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
           r_reg <= (others => '0');
        else
            if en = '1' then
                r_reg <=  r_next;
            end if;
        end if;
    end if;
end process next_reg_pr;

end Behavioral;
