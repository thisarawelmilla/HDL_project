----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/20/2020 09:40:17 AM
-- Design Name: 
-- Module Name: tb_pixel_value - Behavioral
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

entity tb_pixel_value is
--  Port ( );
end tb_pixel_value;

architecture Behavioral of tb_pixel_value is
component pixel_value
 PORT ( clk: in STD_LOGIC;
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
end component;

signal start_flag : STD_LOGIC;
signal clk: STD_LOGIC;
signal reset : STD_LOGIC;
signal enable : STD_LOGIC;
signal read_en :  STD_LOGIC;
signal direction :  STD_LOGIC_VECTOR (1 downto 0);
signal bram_val_1 : STD_LOGIC_VECTOR (7 downto 0);
signal bram_val_2 : STD_LOGIC_VECTOR (7 downto 0);
signal bram_val_3 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_1 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_2 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_3 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_4 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_5 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_6 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_7 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_8 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_9 : STD_LOGIC_VECTOR (7 downto 0);

constant pulse : time := 20 ns;

begin

uut_1 : pixel_value
       
     port map(clk => clk,
           reset => reset,
           start_flag => start_flag,
           enable => enable,
           read_en => read_en,
           direction => direction,
           bram_val_1 => bram_val_1,
           bram_val_2 => bram_val_2,
           bram_val_3 => bram_val_3,
           pixel_1 => pixel_1,
           pixel_2 => pixel_2,
           pixel_3 => pixel_3, 
           pixel_4 => pixel_4,
           pixel_5 => pixel_5,
           pixel_6 => pixel_6,
           pixel_7 => pixel_7,
           pixel_8 => pixel_8,
           pixel_9 => pixel_9);
          

Clk_process_b :process
               begin
                    clk <= '1';  
                    enable <= '1';     
                    wait for pulse/2;  
                    clk <= '0';
                    enable <= '0'; 
                    wait for pulse/2;  
               end process;      
          
         
   stimuli  : process
                     begin 
                         start_flag <= '1';
                         reset <= '0';
                         wait for pulse*1;
                         start_flag <= '0'; 
                         wait for pulse*1;
 
                         direction <= "00";
                         bram_val_1 <= "00000001";
                         bram_val_2 <= "00001001";
                         bram_val_3 <= "00000011";
                         wait for pulse*1;
                         
                         direction <= "00";
                         bram_val_1 <= "00001111";
                         bram_val_2 <= "10100001";
                         bram_val_3 <= "10101010";
                         wait for pulse*1;
 
                         direction <= "00";
                         bram_val_1 <= "11000011";
                         bram_val_2 <= "11000010";
                         bram_val_3 <= "11000001";
                         wait for pulse*1;
                        
                         direction <= "00";
                         bram_val_1 <= "11000001";
                         bram_val_2 <= "10100000";
                         bram_val_3 <= "00011111";
                         wait for pulse*1;
 
                         direction <= "00";
                         bram_val_1 <= "00000111";
                         bram_val_2 <= "00000001";
                         bram_val_3 <= "00000010";
                         wait for pulse*1;
 
                         direction <= "10";
                         bram_val_1 <= "11100010";
                         bram_val_2 <= "11100001";
                         bram_val_3 <= "11100010";
                         wait for pulse*1;
 
                         direction <= "01";
                         bram_val_1 <= "10100001";
                         bram_val_2 <= "10101010";
                         bram_val_3 <= "10100010";
                         wait for pulse*1;
 
                         direction <= "01";
                         bram_val_1 <= "00001001";
                         bram_val_2 <= "00000011";
                         bram_val_3 <= "00000010";
                         wait for pulse*1;
 
                         direction <= "11";
                         bram_val_1 <= "10100011";
                         bram_val_2 <= "00000011";
                         bram_val_3 <= "11100011";
                         wait for pulse*1;
 
                         direction <= "00";
                         bram_val_1 <= "00011111";
                         bram_val_2 <= "11100001";
                         bram_val_3 <= "11100010";
                         wait for pulse*1;
 
 
                         direction <= "00";
                         bram_val_1 <= "00000010";
                         bram_val_2 <= "11100010";
                         bram_val_3 <= "10100010";

                                   
                         wait; 
              end process; 



end Behavioral;
