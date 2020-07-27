----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 10:30:08 AM
-- Design Name: 
-- Module Name: output_writer - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity output_writer is
 Port ( clk : in STD_LOGIC;
     start_flag : in STD_LOGIC;
     enable : in STD_LOGIC;
     results : in STD_LOGIC_VECTOR (7 downto 0);
     addra : out STD_LOGIC_VECTOR (7 downto 0);
     ena : OUT STD_LOGIC;
     wea : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
     dina : out STD_LOGIC_VECTOR (7 downto 0));
end output_writer;

architecture Behavioral of output_writer is

signal address : integer := 0;  
  
begin 

process (CLK)
begin
  IF (CLK'EVENT AND CLK = '1') THEN 
   if start_flag = '1' then     
      address <= 0;
  end if; 
  
  if (enable = '1') then
      ena <= '1';
      wea <= "1";
      dina <= results;
      addra <= std_logic_vector(to_unsigned(address, addra'length)); 
      address <= address + 1;
  ELSE
      ena <= '0';
      wea <= "0";
  end if;
   
    END IF;
end process;

end Behavioral;
