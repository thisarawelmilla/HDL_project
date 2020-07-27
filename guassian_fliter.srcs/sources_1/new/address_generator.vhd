----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2020 10:36:55 AM
-- Design Name: 
-- Module Name: address_generator - Behavioral
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

entity address_generator is
    Port ( start_flag : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           direction : out STD_LOGIC_VECTOR (1 downto 0);
           terminate_flag : out STD_LOGIC;
           address_1 : out STD_LOGIC_VECTOR (7 downto 0);
           address_2 : out STD_LOGIC_VECTOR (7 downto 0);
           address_3 : out STD_LOGIC_VECTOR (7 downto 0));
end address_generator;

architecture Behavioral of address_generator is

constant width : integer := 10 ;
constant HEIGHT : integer := 10;
signal p_1 : integer;
signal old_p : integer;
signal old_old_p : integer;
signal w : integer := 1 ;
signal h : integer := 2 ;
signal direction_delay_1 : STD_LOGIC_VECTOR (1 downto 0);
signal direction_delay_2 : STD_LOGIC_VECTOR (1 downto 0);

TYPE state_types IS (A,B,C,D,T);
signal state : state_types := A;

begin

process (CLK, enable, start_flag)
begin
  IF (CLK'EVENT AND CLK = '1' ) THEN 
    if (enable = '1' or start_flag = '1') then
      IF start_flag = '1' then
            p_1 <= 0;
            state <= A;
            terminate_flag <= '0';   
      end if;
     
      direction_delay_2 <= direction_delay_1;
            
      CASE state IS 
          WHEN A =>
            direction_delay_1 <= "00";
			p_1 <= p_1 + 1;
			w <= w + 1;
            if w = width then
                if h = height-1 then
                    state <= t;
                else
                    p_1<=p_1 + width*3 +1 ;
                    state <= c;
                end if;
            end if; 
                
          WHEN B =>
            direction_delay_1 <= "01";
			p_1 <= p_1 - 1;	
            w <= w - 1;
            if w = 1 then
                if h = height-1 then
                    state <= t;
                else
                    p_1<=p_1 + width*3 - 1;
                    state <= d;
                end if;
            end if; 

          WHEN C =>
            direction_delay_1 <= "10";
			p_1 <= p_1 - width*2 - 4 ;
            h <= h + 1;
            w <= width - 3;
            state <= b;
 
 
           WHEN D =>
              direction_delay_1 <= "11";
			  p_1 <= p_1 -width*2 + 4;
              h <= h + 1;
              w <= 4;
              state <= a;
                 
            WHEN T =>
                terminate_flag <= '1';              

        END CASE;
    END IF;
  end if;
end process;
    
    
process (CLK, enable, start_flag)
    begin
      IF (CLK'EVENT AND CLK = '1' ) THEN     -- output assignment at positive clk edge
         if (enable = '1' or start_flag = '1') then                 
            CASE state IS 
            
                WHEN A =>
                    direction <= direction_delay_2 ; 
                    address_1 <= std_logic_vector(to_unsigned(p_1, address_1'length)); 
                    address_2 <= std_logic_vector(to_unsigned(p_1 + WIDTH, address_2'length)); 
                    address_3 <= std_logic_vector(to_unsigned(p_1 + WIDTH*2, address_3'length));     
                    terminate_flag <= '0';  
                    
                WHEN B =>
                    direction <= direction_delay_2 ;    
                    address_1 <= std_logic_vector(to_unsigned(p_1, address_1'length)); 
                    address_2 <= std_logic_vector(to_unsigned(p_1 + WIDTH, address_2'length)); 
                    address_3 <= std_logic_vector(to_unsigned(p_1 + WIDTH*2, address_3'length));                  
                    terminate_flag <= '0';             
    
                WHEN C =>
                    direction <= direction_delay_2 ; 
                    address_1 <= std_logic_vector(to_unsigned(p_1 - 3, address_1'length)); 
                    address_2 <= std_logic_vector(to_unsigned(p_1 - 2, address_2'length)); 
                    address_3 <= std_logic_vector(to_unsigned(p_1 - 1, address_3'length));     
                    terminate_flag <= '0';    
                    

                WHEN D =>
                    direction <= direction_delay_2 ;    
                    address_1 <= std_logic_vector(to_unsigned(p_1 + 1 , address_1'length)); 
                    address_2 <= std_logic_vector(to_unsigned(p_1 + 2, address_2'length)); 
                    address_3 <= std_logic_vector(to_unsigned(p_1 + 3, address_3'length));   
                    terminate_flag <= '0';  

                WHEN T =>
                    terminate_flag <= '1';      
            END CASE;
        END IF;
       end if;
end process;
end Behavioral;
