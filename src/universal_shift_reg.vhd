----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2026 22:52:52
-- Design Name: 
-- Module Name: universal_shift_reg - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity universal_shift_reg is
    generic(
        WIDTH: natural := 4
        );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           ctrl: in STD_LOGIC_VECTOR(1 downto 0);
           d : in STD_LOGIC_VECTOR ((WIDTH -1) downto 0);
           q : out STD_LOGIC_VECTOR ((WIDTH -1) downto 0)
           );
end universal_shift_reg;

architecture Behavioral of universal_shift_reg is
signal r_reg : std_logic_vector((WIDTH -1) downto 0);
signal r_next : std_logic_vector((WIDTH -1) downto 0);
begin

with ctrl select
    r_next <= r_reg                                         when "00",  -- control for pausing the shift reg
              r_reg((WIDTH -2) downto 0) & d(0)             when "01",  -- control for shift left
              d((WIDTH -1)) & r_reg ((WIDTH -1) downto 1)   when "10",  -- control for shift right
              d                                             when others;-- control for loading d
q <= r_reg;
shifting_pr: process(clk)
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
end process shifting_pr;
end Behavioral;
