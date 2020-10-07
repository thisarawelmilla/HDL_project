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

entity pixel_value_provider is


  -- pin descriptions

  -- clk: Clock signal
  -- reset: Reset signal
  -- start_flag: Start the reading pixel values
  -- enable: Enable to read the pixel values
  -- direction: Direction of the window sliding path
  -- bram_val_1: New pixel value 1 for next window
  -- bram_val_2: New pixel value 2 for next window
  -- bram_val_3: New pixel value 3 for next window
  -- pixel_value_1: pixel value 1 for next window
  -- pixel_value_2: pixel value 2 for next window
  -- pixel_value_3: pixel value 3 for next window
  -- pixel_value_4: pixel value 4 for next window
  -- pixel_value_5: pixel value 5 for next window
  -- pixel_value_6: pixel value 6 for next window
  -- pixel_value_7: pixel value 7 for next window
  -- pixel_value_8: pixel value 8 for next window
  -- pixel_value_9: pixel value 9 for next window
  -- read_en: Enable the gaussian_fliter module to read the pixel values

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
end pixel_value_provider;


architecture Behavioral of pixel_value_provider is

  -- The pixel value provider outputs all the required pixel values of the image to perform 
  -- the convolution operation. It gets the newly read pixel values by the bram accessor 
  -- module and relevant pixel values of the previous window, the pixel values provider gives 
  -- the all pixel values for the next convolution operation. For all the convolution windows, 
  -- the following pixel position convention followed regardless of the current state of the 
  -- window sliding path.

-- to hold the pixel values of previous window which are going to required
-- for next window. Each time new three pixel values will be use along with 
-- this six pixel values accordingly.
signal value_1 :STD_LOGIC_VECTOR (7 downto 0);
signal value_2 :STD_LOGIC_VECTOR (7 downto 0);
signal value_3 :STD_LOGIC_VECTOR (7 downto 0);
signal value_4 :STD_LOGIC_VECTOR (7 downto 0);
signal value_5 :STD_LOGIC_VECTOR (7 downto 0);
signal value_6 :STD_LOGIC_VECTOR (7 downto 0);

-- at the edges of the image, some pixel values from 2 windows before (previous 
-- window of the previous window). This holds that old pixel values accordingly.
signal old_value_2 : STD_LOGIC_VECTOR (7 downto 0);
signal old_value_3 : STD_LOGIC_VECTOR (7 downto 0);

-- as the three pixel values inputs to this modele at a one clk cycle, have to wait
-- until total nine pixel values to arrive to provide pixel values of complete window
signal count : integer := 4;

begin

process (CLK,enable,reset, start_flag)
begin
  IF (CLK'EVENT AND CLK = '1') THEN 
       
      if reset = '1' or start_flag = '1' then 
        count <= 4;
        read_en <= '0';
      else   
        if enable = '1' then  
            if count = 1 then
              read_en <= '1';
            else
              count <= count - 1;
            end if;  
      -- when the window slide to the right side     
          if direction = "00" then
                -- assign the pixel values for the output pin
                pixel_1 <= value_1;
                pixel_2 <= value_4;
                pixel_3 <= bram_val_1;
                pixel_4 <= value_2;
                pixel_5 <= value_5;
                pixel_6 <= bram_val_2;
                pixel_7 <= value_3;
                pixel_8 <= value_6;
                pixel_9 <= bram_val_3;
                
                -- keep pixel value which may required to next window
                value_1 <= value_4;
                value_2 <= value_5;
                value_3 <= value_6;
                value_4 <= bram_val_1;
                value_5 <= bram_val_2;
                value_6 <= bram_val_3;
                old_value_2 <= value_2;
                old_value_3 <= value_3;
            
          -- when the window slide to the left side
          elsif direction = "01" then
                -- assign the pixel values for the output pin
                pixel_1 <= bram_val_1;
                pixel_2 <= value_4;
                pixel_3 <= value_1;
                pixel_4 <= bram_val_2;
                pixel_5 <= value_5;
                pixel_6 <= value_2;
                pixel_7 <= bram_val_3;
                pixel_8 <= value_6;
                pixel_9 <= value_3;
                
                -- keep pixel value which may required to next window
                value_1 <= value_4;
                value_2 <= value_5;
                value_3 <= value_6;
                value_4 <= bram_val_1;
                value_5 <= bram_val_2;
                value_6 <= bram_val_3;
                old_value_2 <= value_2;
                old_value_3 <= value_3;
          
          -- when the previous slide direction was to right and next slide direction to down      
          elsif direction = "10" then
                -- assign the pixel values for the output pin
                pixel_1 <= old_value_2;
                pixel_2 <= value_2;
                pixel_3 <= value_5;
                pixel_4 <= old_value_3;
                pixel_5 <= value_3;
                pixel_6 <= value_6;
                pixel_7 <= bram_val_1;
                pixel_8 <= bram_val_2;
                pixel_9 <= bram_val_3;
                
                -- keep pixel value which may required to next window
                value_1 <= value_2;
                value_2 <= value_3;
                value_3 <= bram_val_2; 
                value_4 <= old_value_2;
                value_5 <= old_value_3;
                value_6 <= bram_val_1;
    
          -- when the previous slide direction was to left and next slide direction to down
          elsif direction = "11" then
                -- assign the pixel values for the output pin
                pixel_1 <= value_5;
                pixel_2 <= value_2;
                pixel_3 <= old_value_2;
                pixel_4 <= value_6;
                pixel_5 <= value_3;
                pixel_6 <= old_value_3;
                pixel_7 <= bram_val_1;
                pixel_8 <= bram_val_2;
                pixel_9 <= bram_val_3;
                
                -- keep pixel value which may required to next window
                value_1 <= value_2;
                value_2 <= value_3;
                value_3 <= bram_val_2;
                value_4 <= old_value_2;
                value_5 <= old_value_3;
                value_6 <= bram_val_3;           
          end if;
        else
          read_en <= '0';
      end if;
    END IF;
    end if;
end process;

end Behavioral;
