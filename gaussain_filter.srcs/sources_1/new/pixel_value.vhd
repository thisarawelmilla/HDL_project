----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2020 05:49:51 PM
-- Design Name: 
-- Module Name: pixel_value - Behavioral
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

entity pixel_value is
    Port ( clk: in STD_LOGIC;
           reset : in STD_LOGIC;
           start_flag : in STD_LOGIC;
           enable : in STD_LOGIC;
           read_en : out STD_LOGIC;
           direction : in STD_LOGIC_VECTOR (1 downto 0);
           bram_val_1 : in STD_LOGIC_VECTOR (7 downto 0);
           bram_val_2 : in STD_LOGIC_VECTOR (7 downto 0);
           bram_val_3 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_4 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_5 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_6 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_7 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_8 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_9 : out STD_LOGIC_VECTOR (7 downto 0));
end pixel_value;


architecture Behavioral of pixel_value is

signal value_1 :STD_LOGIC_VECTOR (7 downto 0);
signal value_2 :STD_LOGIC_VECTOR (7 downto 0);
signal value_3 :STD_LOGIC_VECTOR (7 downto 0);
signal value_4 :STD_LOGIC_VECTOR (7 downto 0);
signal value_5 :STD_LOGIC_VECTOR (7 downto 0);
signal value_6 :STD_LOGIC_VECTOR (7 downto 0);
signal old_value_2 : STD_LOGIC_VECTOR (7 downto 0);
signal old_value_3 : STD_LOGIC_VECTOR (7 downto 0);
signal count : integer := 4;

begin

process (CLK)
begin
  IF (CLK'EVENT AND CLK = '1' and enable = '1') THEN  
      if count = 0 then
            read_en <= '1';
      else
            count <= count - 1;
      end if;          
      if direction = "00" then
            pixel_1 <= value_1;
            pixel_2 <= value_4;
            pixel_3 <= bram_val_1;
            pixel_4 <= value_2;
            pixel_5 <= value_5;
            pixel_6 <= bram_val_2;
            pixel_7 <= value_3;
            pixel_8 <= value_6;
            pixel_9 <= bram_val_3;
            
            value_1 <= value_4;
            value_2 <= value_5;
            value_3 <= value_6;
            value_4 <= bram_val_1;
            value_5 <= bram_val_2;
            value_6 <= bram_val_3;
            old_value_2 <= value_2;
            old_value_3 <= value_3;
      


      elsif direction = "01" then
            pixel_1 <= bram_val_1;
            pixel_2 <= value_4;
            pixel_3 <= value_1;
            pixel_4 <= bram_val_2;
            pixel_5 <= value_5;
            pixel_6 <= value_2;
            pixel_7 <= bram_val_3;
            pixel_8 <= value_6;
            pixel_9 <= value_3;
            
            value_1 <= value_4;
            value_2 <= value_5;
            value_3 <= value_6;
            value_4 <= bram_val_1;
            value_5 <= bram_val_2;
            value_6 <= bram_val_3;
            old_value_2 <= value_2;
            old_value_3 <= value_3;
            


      elsif direction = "10" then
            pixel_1 <= old_value_2;
            pixel_2 <= value_2;
            pixel_3 <= value_5;
            pixel_4 <= old_value_3;
            pixel_5 <= value_3;
            pixel_6 <= value_6;
            pixel_7 <= bram_val_1;
            pixel_8 <= bram_val_2;
            pixel_9 <= bram_val_3;
            
            value_1 <= value_2;
            value_2 <= value_3;
            value_3 <= bram_val_2; 
            value_4 <= old_value_2;
            value_5 <= old_value_3;
            value_6 <= bram_val_1;



      elsif direction = "11" then
            pixel_1 <= value_5;
            pixel_2 <= value_2;
            pixel_3 <= old_value_2;
            pixel_4 <= value_6;
            pixel_5 <= value_3;
            pixel_6 <= old_value_3;
            pixel_7 <= bram_val_1;
            pixel_8 <= bram_val_2;
            pixel_9 <= bram_val_3;
            
            value_1 <= value_2;
            value_2 <= value_3;
            value_3 <= bram_val_2;
            value_4 <= old_value_2;
            value_5 <= old_value_3;
            value_6 <= bram_val_3; 
            
            
      end if;
    END IF;
end process;

end Behavioral;
