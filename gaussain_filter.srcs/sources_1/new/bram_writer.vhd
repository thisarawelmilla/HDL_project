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

entity bram_writer is

  -- pin descriptions

  -- clk: Clock signal
  -- start_flag: Indicate the begin of the writing operation to the bram
  -- enable: Enable to write the bram
  -- results: Resultant pixel value of the convolution operation
  -- addra: Address to write the result pixel value
  -- ena: Enable the bram 
  -- wea: Enable the wea pin in bram
  -- dina: Result pixel value to write to bram

    Port (  im_width : in STD_LOGIC_VECTOR (3 downto 0);
         im_height : in STD_LOGIC_VECTOR (3 downto 0);
         clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         start_flag : in STD_LOGIC;
         enable : in STD_LOGIC;
         terminate : out STD_LOGIC;
         results : in STD_LOGIC_VECTOR (7 downto 0);
         addra : out STD_LOGIC_VECTOR (9 downto 0);
         ena : OUT STD_LOGIC;
         wea : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
         dina : out STD_LOGIC_VECTOR (7 downto 0));
end bram_writer;

architecture Behavioral of bram_writer is


  -- The filtered image writer module writes the results of the convolution operation back to 
  -- the bram. It gets the resultant pixel values for the gaussian filter model and fed to 
  -- bram through the port A. The address the resultant pixel values must be written is also 
  -- generated inside this module.

TYPE state_types IS (idle,A,B);

signal state : state_types := idle;
signal address : integer := 0;
signal width_count : integer := 0; 
signal height_count :integer := 0 ; 
signal width : integer; 
signal height :integer;
signal count : integer := 0;
  
begin 

process (CLK,enable, start_flag, im_width, im_height, reset)
begin
  IF (CLK'EVENT AND CLK = '1') THEN 
   -- at start_flag get high start write at address 0
   if reset = '1' or start_flag = '1' then     
      state <= idle;
      count <= 0;
      
   else
       CASE state IS 
           WHEN idle =>
                address <= 0;
                width <= to_integer(unsigned(im_width));   
                height <= to_integer(unsigned(im_height));
                wea <= "0";
                ena <= '0';
                terminate <= '0';
                addra <= "0000000000";
                dina <= "00000000";
                width_count <= 0;
                height_count <= 0;
                if enable = '1' then
                    state <= A;
                end if;
                
           WHEN A => 
             if enable = '1' then
               count <= count + 1;
               if count = 1 then
                 addra <= std_logic_vector(to_unsigned(address, addra'length)); 
                 address <= address + 1;  
                 width_count <= width_count + 1;
                 ena <= '1';
                 wea <= "1";
                 dina <= results;
                 if width_count = width - 3 then  
                            width_count <= 0; 
                            address <= address + width - 2; 
                            height_count <= height_count + 1; 
                            if height-3 = height_count  then
                                state <= idle;
                                terminate <= '1';
                            else
                                state <= B;
                            end if;
                 end if;
               elsif count = 3 then 
                 count <= 1;
               end if;
              else
                 state <= idle;
              end if;
              
           WHEN B => 
             if enable = '1' then
              count <= count + 1;
              if count = 1 then
               addra <= std_logic_vector(to_unsigned(address, addra'length));  
               address <= address - 1;  
               width_count <= width_count + 1;
               ena <= '1';
               wea <= "1";
               dina <= results;
               if width_count = width - 3 then  
                          width_count <= 0; 
                          address <= address + width - 2; 
                          height_count <= height_count + 1; 
                          if height-3 = height_count then
                              state <= idle;
                              terminate <= '1';
                          else
                              state <= A;
                          end if;
               end if;
              elsif count = 3 then 
                 count <= 1;
              end if;
            else
              state <= idle;
            end if;
            
           end case;
           
        end if;
    end if;
end process;

end Behavioral;
