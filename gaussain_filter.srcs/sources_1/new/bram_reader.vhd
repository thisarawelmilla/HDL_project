----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2020 01:50:40 PM
-- Design Name: 
-- Module Name: bram_accessor - Behavioral
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

entity bram_reader is

    -- pin descriptions

    -- clk: Clock signal
    -- start_flag: Reinitialize the variables
    -- address_1: Address 1 to read
    -- address_2: Address 2 to read
    -- address_3: Address 3 to read
    -- pixel_value: Pixel value of the previous address from the bram 
    -- pixel_value_1: Pixel value of address 1
    -- pixel_value_2: Pixel value of address 2
    -- pixel_value_3: Pixel value of address 3
    -- Next address: Enable address_ generator module to generate next address set at end of reading all three pixel values from the bram
    -- read_en: Enable pixel_value_provider  to read pixel values at end of reading all three pixel values from the bram
    -- addrb: Fed the bram with address
    -- enb: Enable the bram

    Port ( address_1 : in STD_LOGIC_VECTOR (9 downto 0);
           address_2 : in STD_LOGIC_VECTOR (9 downto 0);
           address_3 : in STD_LOGIC_VECTOR (9 downto 0);
           pixel_value : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start_flag : in STD_LOGIC;
           enable : in STD_LOGIC;
           pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
           next_address : out STD_LOGIC;
           read_en : out STD_LOGIC;
           enb : out STD_LOGIC;
           addrb : out STD_LOGIC_VECTOR (9 downto 0));
end bram_reader;

architecture Behavioral of bram_reader is
    -- The bram accessor responsible for reading the pixel values of the image which are 
    -- stored in the ram. The addresses which are produced by the address generator module 
    -- are fed to this component. The bram accessor gives the pixel values by reading the 
    -- ram for each address one by one at a time. After all three pixel values are read from 
    -- the ram, then the read_en output pin is enabled to indicate that all the required 
    -- pixel values are available.

type state_types is (idle,A,B,C);
signal state : state_types := idle;

    -- state A: read the pixel values for pixel_1 from the address_1 
    -- state B: read the pixel values for pixel_2 from the address_2 
    -- state C: read the pixel values for pixel_3 from the address_3 
    -- state idle: idle state when no job to perform

begin
process (CLK, start_flag, address_1, address_2, address_3, pixel_value, enable,reset)
begin
  if (CLK'EVENT and CLK = '1') then
      -- at a start_flag high reset all the initial variables
      if reset = '1' then
        state <= idle;  
        read_en <= '0';
      else   
            
      case state is
          -- initialize all the signals and outputs 
          when idle =>
            pixel_1 <= "00000000";
            pixel_2 <= "00000000";
            pixel_3 <= "00000000";
            read_en <= '0';
            next_address <= '0';
            if enable = '1' then     
               state<= a;
               enb <= '1';           
            end if;
            
          when A =>
            -- read the pixel value for address 3 from the bram
            addrb <= address_1; 
            next_address <= '1'; 
            enb <= '1'; 
            -- the read pixel value assign to the pixel output pins        
            pixel_1 <= pixel_value;
            state <= b;
            -- make high when the all the pixels values for the next window has read
            read_en <= '0';
                     
          when B =>
	    next_address <= '0';
	    read_en <= '0';
            enb <= '1';
            -- read the pixel value for address 2 from the bram
            addrb <= address_2;
            -- the read pixel value assign to the pixel output pins   
            pixel_2 <= pixel_value;
            state <= c;

          when C =>
	    next_address <= '0';
	    read_en <= '1';
            enb <= '1';
            -- read the pixel value for address 2 from the bram
            addrb <= address_3;  
            -- the read pixel value assign to the pixel output pins 
            pixel_3 <= pixel_value;
            if enable = '1' then
                state <= a;
            else
                state <= idle;
            end if;

        end case;
       end if;
    end if;

end process;

end Behavioral;
