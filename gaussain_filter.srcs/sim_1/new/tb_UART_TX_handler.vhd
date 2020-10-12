----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2020 03:03:55 PM
-- Design Name: 
-- Module Name: tb_tx_handler - Behavioral
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

entity tb_tx_handler is
--  Port ( );
end tb_tx_handler;

architecture Behavioral of tb_tx_handler is

component UART_TX_handeller
    Port ( TX_Byte : in STD_LOGIC_VECTOR (7 downto 0);
           TX_Active : out STD_LOGIC;
           TX_Serial : out STD_LOGIC;
           TX_Done : out STD_LOGIC;
           addr_to_read : out STD_LOGIC_VECTOR (9 downto 0);           
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

signal TX_enable : STD_LOGIC;
signal TX_Byte : STD_LOGIC_VECTOR (7 downto 0);
signal TX_Active : STD_LOGIC;
signal TX_Serial : STD_LOGIC;
signal TX_Done : STD_LOGIC;
signal addr_to_read : STD_LOGIC_VECTOR (9 downto 0);           
signal reset : STD_LOGIC;
signal clk : STD_LOGIC;

constant pulse : time := 10 ns;

begin

uart_tx_handler_1 : UART_TX_handeller
port map(   TX_Byte =>TX_Byte,
            TX_Active =>TX_Active,
            TX_Serial => TX_Serial,
            TX_Done =>TX_Done,
            addr_to_read =>addr_to_read,         
            reset => reset,
            clock => clk);
            
Clk_process :process
       begin
             clk <= '1';      
             wait for pulse/2;  
             clk <= '0';
             wait for pulse/2;  
       end process;      
                       
stimuli  : process
       begin
             reset <= '0';
             TX_enable <= '1';
             TX_Byte <= "00100100";
             wait for pulse*10*10416;
                   
             reset <= '0';
             TX_enable <= '1';
             TX_Byte <= "00111100";
             wait for pulse*10*10416;
                   
             reset <= '0';
             TX_enable <= '0';
             TX_Byte <= "00100111";
             wait for pulse*10*10416;
                   
             reset <= '0';
             TX_enable <= '1';
             TX_Byte <= "11100100";
             wait;
        end process;  

end Behavioral;
