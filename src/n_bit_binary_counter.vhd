----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.07.2026 18:55:30
-- Design Name: 
-- Module Name: n_bit_binary_counter - Behavioral
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

entity n_bit_binary_counter is
    generic(
            COUNTER_WIDTH: natural := 4
             );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en  : in STD_LOGIC;
           ctrl : in STD_LOGIC_VECTOR (1 downto 0);
           d : in STD_LOGIC_VECTOR ((COUNTER_WIDTH - 1) downto 0);
           q : out STD_LOGIC_VECTOR ((COUNTER_WIDTH - 1) downto 0));
end n_bit_binary_counter;

architecture Behavioral of n_bit_binary_counter is
signal r_reg, r_next : unsigned ((COUNTER_WIDTH - 1) downto 0);
begin

with ctrl select
    r_next <= (others => '0')      when "00",    -- Clear count
              unsigned(d)          when "01",    -- Load start
              r_reg + 1            when "10",    -- Up count
              r_reg - 1            when "11",    -- Down Count 
             (others => 'X')       when others;
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
