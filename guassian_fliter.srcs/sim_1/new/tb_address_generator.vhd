----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/18/2020 12:22:43 PM
-- Design Name: 
-- Module Name: tb_address_generator - Behavioral
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

entity tb_address_generator is
--  Port ( );
end tb_address_generator;

architecture Behavioral of tb_address_generator is
component address_generator
 PORT ( start_flag : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           direction : out STD_LOGIC_VECTOR (1 downto 0);
           terminate_flag : out STD_LOGIC;
           address_1 : out STD_LOGIC_VECTOR (7 downto 0);
           address_2 : out STD_LOGIC_VECTOR (7 downto 0);
           address_3 : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal start_flag : STD_LOGIC;
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal enable : STD_LOGIC;
signal direction : STD_LOGIC_VECTOR (1 downto 0);
signal terminate_flag : STD_LOGIC;
signal address_1 : STD_LOGIC_VECTOR (7 downto 0);
signal address_2 : STD_LOGIC_VECTOR (7 downto 0);
signal address_3 : STD_LOGIC_VECTOR (7 downto 0);

constant pulse : time := 25 ns;

begin

uut_1 : address_generator
  port map(start_flag => start_flag,
          clk => clk,
          reset => reset,
          enable => enable,
          direction => direction,
          terminate_flag => terminate_flag,
          address_1 => address_1,
          address_2 => address_2,
          address_3 => address_3);
          
         
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
                         wait; 
              end process; 
                           
end Behavioral;
