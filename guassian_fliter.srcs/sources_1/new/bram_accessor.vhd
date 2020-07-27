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

entity bram_accessor is
    Port ( address_1 : in STD_LOGIC_VECTOR (7 downto 0);
           address_2 : in STD_LOGIC_VECTOR (7 downto 0);
           address_3 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_value : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           start_flag : in STD_LOGIC;
           pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
           next_address : out STD_LOGIC;
           read_en : out STD_LOGIC;
           enb : out STD_LOGIC;
           addrb : out STD_LOGIC_VECTOR (7 downto 0));
end bram_accessor;

architecture Behavioral of bram_accessor is
TYPE state_types IS (A,B,C);
signal state : state_types := a;

begin
process (CLK, start_flag, address_1, address_2, address_3, pixel_value)
begin
  IF (CLK'EVENT AND CLK = '1') THEN 
      if start_flag = '1' then     
        state<= a;
        addrb <= "00000000";   
      end if;   
            
      CASE state IS 
          WHEN A =>
            addrb <= address_3; 
            next_address <= '0'; 
            enb <= '1';            
            pixel_3 <= pixel_value;
            state <= b;
            read_en <= '1';
                     
          WHEN B =>
			  next_address <= '0';
			  read_en <= '0';
              enb <= '1';
              addrb <= address_1;  
              pixel_1 <= pixel_value;
              state <= c;

          WHEN C =>
			next_address <= '1';
			read_en <= '0';
            enb <= '1';
            addrb <= address_2;  
            pixel_2 <= pixel_value;
            state <= a;
        END CASE;
    END IF;
end process;

end Behavioral;
