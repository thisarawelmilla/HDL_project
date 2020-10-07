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


entity address_generator is
    -- pin descriptions
    
    -- clk: Clock signal
    -- reset: Reset signal
    -- start_flag: Restart the address operation
    -- enable: Enable to generate the next set of address
    -- width: Width of the image
    -- height: Height of the image
    -- address_1: Address 1 to read from the bram
    -- address_2: Address 2 to read from the bram
    -- address_3: Address 3 to read from the bram
    -- direction: Direction of the window sliding path
    -- terminate_flag: Indicate the end of the image


    Port ( im_width : in STD_LOGIC_VECTOR (3 downto 0);
           im_height : in STD_LOGIC_VECTOR (3 downto 0);
           start_flag : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           active : out STD_LOGIC;
           direction : out STD_LOGIC_VECTOR (1 downto 0);
           terminate_flag : out STD_LOGIC;
           address_1 : out STD_LOGIC_VECTOR (9 downto 0);
           address_2 : out STD_LOGIC_VECTOR (9 downto 0);
           address_3 : out STD_LOGIC_VECTOR (9 downto 0));
end address_generator;


architecture Behavioral of address_generator is

    -- The address generator module generates the next three addresses of the ram which 
    -- hold the pixel values of the image. At a start_flag input pin high, the address 
    -- generator starts generating the addresses for the corresponding pixel which is required 
    -- for the next convolution window. The terminated_flag output pin indicates the end of the 
    -- sliding window path. By width pin and height pin, we can input the size of the image to 
    -- the address generator module.

signal width : integer;
signal height : integer;
signal p_1 : integer;
signal old_p : integer;
signal old_old_p : integer;
signal w : integer := 1 ;
signal h : integer := 2 ;
signal direction_delay_1 : STD_LOGIC_VECTOR (1 downto 0) := "00";
signal direction_delay_2 : STD_LOGIC_VECTOR (1 downto 0);

TYPE state_types IS (idle,A,B,C,D,T);
signal state : state_types := idle;

begin

process (CLK, enable, start_flag, reset, im_width, im_height)
begin
  IF (CLK'EVENT AND CLK = '1' ) THEN     
    if reset = '1' then
       state <= idle;
    else
        if (enable = '1' or start_flag = '1') then
          -- restart the addressing process when start_flag high
          direction_delay_2 <= direction_delay_1;
                
          CASE state IS 
              -- when the window slide to the right side
              WHEN idle =>
                 width <= to_integer(unsigned(im_width));   
                 height <= to_integer(unsigned(im_height)); 
                        -- reset the all required variables for new addressing process           
                        p_1 <= 0;
                        w <= 1 ;
                        h <= 2 ;
                        direction_delay_1 <= "00";
                 IF start_flag = '1' then  
                        state <= A; 
                                
                 end if; 
                          
              WHEN A =>
                direction_delay_1 <= "00";
                p_1 <= p_1 + 1;
                w <= w + 1;
                -- check whether it has come to the end of the right side
                if w = width then
                    -- check whether the current path is at its bottom
                    if h = height-1 then
                        state <= t;
                    else
                    -- change state to the new state; state c
                        p_1<=p_1 + width*3 +1 ;
                        state <= c;
                    end if;
                end if; 
              
              -- when the window slide to the left side      
              WHEN B =>
                direction_delay_1 <= "01";
                p_1 <= p_1 - 1;	
                w <= w - 1;
                -- check whether it has come to the end of the left side
                if w = 1 then
                    -- check whether the current path is at its bottom
                    if h = height-1 then
                        state <= t;
                    -- change state to the new state; state d
                    else
                        p_1<=p_1 + width*3 - 1;
                        state <= d;
                    end if;
                end if; 
                
              -- when the previous slide direction was to right and next slide direction to down
              WHEN C =>
                direction_delay_1 <= "10";
                p_1 <= p_1 - width*2 - 4 ;
                h <= h + 1;
                w <= width - 3;
                -- change the next state to b; slide to left side
                state <= b;
     
               -- when the previous slide direction was to left and next slide direction to down
               WHEN D =>
                  direction_delay_1 <= "11";
                  p_1 <= p_1 -width*2 + 4;
                  h <= h + 1;
                  w <= 4;
                  -- change the next state to a; slide to right side
                  state <= a;
                              
               WHEN T =>
                  state <= idle;
            END CASE;
        END IF;
  end if;
 end if;
end process;
    
    
process (CLK, enable, start_flag,reset)
    begin
      IF (CLK'EVENT AND CLK = '1' ) THEN 
            -- assign the address and the direction to the relevant output pins                  
            CASE state IS 
                WHEN idle =>
                    -- indicate direction goes to right
                    direction <= "00" ;
                    if start_flag ='1' then 
			-- gives first three addresses (three addresses of the first column of the windows)
                        address_1 <= std_logic_vector(to_unsigned(p_1, address_1'length)); 
                        address_2 <= std_logic_vector(to_unsigned(p_1 + WIDTH, address_2'length)); 
                        address_3 <= std_logic_vector(to_unsigned(p_1 + WIDTH*2, address_3'length));  
                    else 
			-- when in idle state and the start_flag is not high, holds the initialization values
                        address_1 <= "0000000000"; 
                        address_2 <= "0000000000"; 
                        address_3 <= "0000000000"; 
                    end if;
                    terminate_flag <= '0';
                    active <= '0';  
                      
                WHEN A =>
		    -- indicate the these address are from the right side colunm of the previous column
                    direction <= direction_delay_2 ; 
		    -- gives next three addresses (three addresses of the first column of the windows)
                    address_1 <= std_logic_vector(to_unsigned(p_1, address_1'length)); 
                    address_2 <= std_logic_vector(to_unsigned(p_1 + WIDTH, address_2'length)); 
                    address_3 <= std_logic_vector(to_unsigned(p_1 + WIDTH*2, address_3'length));     
                    terminate_flag <= '0';
                    active <= '1';  
                    
                WHEN B =>
                    direction <= direction_delay_2 ; 
  		    -- gives next sthree addresses (three addresses of the first column of the windows)   
                    address_1 <= std_logic_vector(to_unsigned(p_1, address_1'length)); 
                    address_2 <= std_logic_vector(to_unsigned(p_1 + WIDTH, address_2'length)); 
                    address_3 <= std_logic_vector(to_unsigned(p_1 + WIDTH*2, address_3'length));                  
                    terminate_flag <= '0'; 
                    active <= '1';            
    
                WHEN C =>
                    direction <= direction_delay_2 ; 
                    -- gives next three addresses (three addresses of the first column of the windows)
                    address_1 <= std_logic_vector(to_unsigned(p_1 - 3, address_1'length)); 
                    address_2 <= std_logic_vector(to_unsigned(p_1 - 2, address_2'length)); 
                    address_3 <= std_logic_vector(to_unsigned(p_1 - 1, address_3'length));     
                    terminate_flag <= '0';
                    active <= '1';    
                    

                WHEN D =>
                    direction <= direction_delay_2 ; 
		    -- gives next three addresses (three addresses of the first column of the windows)   
                    address_1 <= std_logic_vector(to_unsigned(p_1 + 1 , address_1'length)); 
                    address_2 <= std_logic_vector(to_unsigned(p_1 + 2, address_2'length)); 
                    address_3 <= std_logic_vector(to_unsigned(p_1 + 3, address_3'length));   
                    terminate_flag <= '0';
                    active <= '1';  

                WHEN T =>
		    -- indicate the termination of the address generating process for the current image
                    terminate_flag <= '1';
                    active <= '0';      
            END CASE;
        END IF;
end process;
end Behavioral;
