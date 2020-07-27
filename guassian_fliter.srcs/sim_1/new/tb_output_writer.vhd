----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 12:38:24 PM
-- Design Name: 
-- Module Name: tb_output_writer - Behavioral
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

entity tb_output_writer is
--  Port ( );
end tb_output_writer;

architecture Behavioral of tb_output_writer is
component output_writer
Port ( clk : in STD_LOGIC;
     start_flag : in STD_LOGIC;
     enable : in STD_LOGIC;
     results : in STD_LOGIC_VECTOR (7 downto 0);
     addra : out STD_LOGIC_VECTOR (7 downto 0);
     ena : OUT STD_LOGIC;
     wea : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
     dina : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal start_flag : STD_LOGIC;
signal enable : STD_LOGIC;
signal results : STD_LOGIC_VECTOR (7 downto 0);
signal addra : STD_LOGIC_VECTOR (7 downto 0);
signal ena : STD_LOGIC;
signal wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal dina : STD_LOGIC_VECTOR (7 downto 0);

constant pulse : time := 30 ns;


begin
uut_1 : output_writer
port map ( clk => clk,
     start_flag => start_flag, 
     enable => enable,
     results => results,
     addra => addra,
     ena => ena,
     wea => wea,
     dina => dina);
    


Clk_process :process
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
         results <= "01110001";
         wait for pulse/2;
         start_flag <= '0'; 
         results <= "01110001";
         wait for pulse/2;
    
         results <= "00000001";
         wait for pulse*1;

         results <= "00000011";
         wait for pulse*1;
         
         results <= "00000101";
         wait for pulse*1;

         results <= "00011001";
         wait for pulse*1;

         results <= "00100001";
         wait for pulse*1;

         results <= "01100001";
         wait for pulse*1;
         
         results <= "00111001";
         wait for pulse*1;

         results <= "11000001";
         wait; 
  end process; 

end Behavioral;
