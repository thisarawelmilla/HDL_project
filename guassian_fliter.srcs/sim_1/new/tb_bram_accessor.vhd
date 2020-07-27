----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2020 02:06:00 PM
-- Design Name: 
-- Module Name: tb_bram_accessor - Behavioral
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

entity tb_bram_accessor is
--  Port ( );
end tb_bram_accessor;

architecture Behavioral of tb_bram_accessor is
component bram_accessor
 PORT ( address_1 : in STD_LOGIC_VECTOR (7 downto 0);
           address_2 : in STD_LOGIC_VECTOR (7 downto 0);
           address_3 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_value : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           start_flag : in STD_LOGIC;
           pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
           read_en : out STD_LOGIC;
           enb : out STD_LOGIC;
           addrb : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal address_1 : STD_LOGIC_VECTOR (7 downto 0);
signal address_2 : STD_LOGIC_VECTOR (7 downto 0);
signal address_3 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_value : STD_LOGIC_VECTOR (7 downto 0);
signal clk : STD_LOGIC;
signal start_flag : STD_LOGIC;
signal pixel_1 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_2 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_3 : STD_LOGIC_VECTOR (7 downto 0);
signal read_en : STD_LOGIC;
signal enb : STD_LOGIC;
signal addrb : STD_LOGIC_VECTOR (7 downto 0);

constant pulse : time := 15 ns;

begin

uut_1 : bram_accessor
       
     port map(address_1 => address_1,
           address_2 => address_2,
           address_3 => address_3,
           pixel_value => pixel_value,
           clk => clk, 
           start_flag => start_flag,
           pixel_1 => pixel_1,
           pixel_2 => pixel_2 ,
           pixel_3 => pixel_3,
           read_en => read_en,
           enb => enb,
           addrb =>  addrb);
          
         
 Clk_process_b :process
               begin
                    clk <= '1';       
                    wait for pulse/2;  
                    clk <= '0';
                    wait for pulse/2;  
               end process;      
          
         
   stimuli  : process
                     begin 
                         address_1 <= "00000001";
                         address_2 <= "00000011";
                         address_3 <= "00000111";
                         wait for pulse*1;
                         start_flag <= '0';           
                         wait; 
              end process; 
                           
end Behavioral;
