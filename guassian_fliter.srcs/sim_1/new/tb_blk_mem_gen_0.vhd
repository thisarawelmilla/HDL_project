----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2020 07:26:54 PM
-- Design Name: 
-- Module Name: tb_blk_mem_gen_0 - Behavioral
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

entity tb_blk_mem_gen_0 is
--  Port ( );
end tb_blk_mem_gen_0;

architecture Behavioral of tb_blk_mem_gen_0 is
component blk_mem_gen_0
 PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

signal clka : STD_LOGIC;
signal ena :  STD_LOGIC;
signal wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal addra : STD_LOGIC_VECTOR(6 DOWNTO 0);
signal dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal clkb : STD_LOGIC;
signal enb : STD_LOGIC;
signal addrb : STD_LOGIC_VECTOR(6 DOWNTO 0);
signal doutb : STD_LOGIC_VECTOR(7 DOWNTO 0);

constant pulse : time := 40 ns;

begin

uut_1 : blk_mem_gen_0
  port map(                                       
          clka => clka,                     
          ena => ena,                       
          wea => wea,   
          addra => addra,  
          dina => dina,   
          clkb => clkb,                     
          enb => enb,                     
          addrb => addrb,  
          doutb => doutb);


 Clk_process_b :process
      begin
           clka <= '1';       
           wait for pulse/2;  
           clka <= '0';
           wait for pulse/2;  
      end process;
      
  Clk_process_a :process
           begin
                clkb <= '1';       
                wait for pulse/2;  
                clkb <= '0';
                wait for pulse/2;  
           end process;
      
      
  stimuli  : process
       begin 
           enb <= '1';
           addrb <= "0001111";
           wait for pulse*5;
           
           enb <= '0';
           ena <= '1';
           addra <= "0001111";
           dina <= "01100110";
           wea <= "1"; 
           wait for pulse*5;
           
           ena <= '0';          
           enb <= '1';
           addrb <= "0001111";                  
           wait;     
       end process; 

end Behavioral;
