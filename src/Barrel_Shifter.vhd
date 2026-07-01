----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2026 20:39:03
-- Design Name: 
-- Module Name: Barrel_Shifter - Behavioral
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

entity Barrel_Shifter is
  Port (a: in std_logic_vector (7 downto 0) ; 
        amt : in std_logic_vector (2 downto 0) ; 
        y: out std_logic_vector (7 downto 0);
        b0: in  std_logic_vector(3 downto 0);
        g1: out  std_logic_vector(3 downto 0)
        );
end Barrel_Shifter;

architecture Behavioral of Barrel_Shifter is
signal le0, le1, le2 : std_logic_vector(7 downto 0);
constant WIDTH : natural := 4;
signal b,b1 : std_logic_vector((WIDTH-1) downto 0);
signal g : std_logic_vector((WIDTH-1) downto 0);
begin

le0 <= a(0) & a(7 downto 1) when (amt(0) = '1') else a;
le1 <= le0(1 downto 0) & le0(7 downto 2) when (amt(1) = '1') else le0;
le2 <= le1(3 downto 0) & le1(7 downto 4) when (amt(2) = '1') else le1;
y <= le2;

b <= g xor ( '0' & b0 ((WIDTH-1) downto 1));
b1 <= std_logic_vector(unsigned(b) + 1);
g1 <= b1 xor ('0' & b1 ((WIDTH-1) downto 1));

end Behavioral;
