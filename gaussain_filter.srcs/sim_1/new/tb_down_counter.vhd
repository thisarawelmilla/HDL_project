----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/22/2020 09:10:05 PM
-- Design Name: 
-- Module Name: tb_up_counter - Behavioral
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

entity tb_up_counter is
--  Port ( );
end tb_up_counter;

architecture Behavioral of tb_up_counter is
component up_counter_uart is
    Port ( enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (9 downto 0));
end component;

signal clock       : std_logic;
signal enable      : std_logic;
signal reset       : std_logic;
signal counter_out : std_logic_vector (9 downto 0);

constant pulse : time := 15 ns;
begin

dut : up_counter_uart
port map (clock       => clock,
          enable      => enable,
          reset       => reset,
          counter_out => counter_out);
        
Clk_process :process
       begin
            clock <= '1';       
            wait for pulse/2;  
            
            clock <= '0';
            wait for pulse/2;  
       end process;      
  
enable_process :process
       begin
            enable <= '1';       
            wait for pulse;  
            enable <= '0';
            wait for pulse*3;  
       end process; 
 
stimuli  : process
       begin 
            reset <= '0';          
            wait for pulse*1;
       end process; 
end Behavioral;
