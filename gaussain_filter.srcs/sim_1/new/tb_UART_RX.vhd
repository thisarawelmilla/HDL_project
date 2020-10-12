----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2020 08:17:50 AM
-- Design Name: 
-- Module Name: tb_rx_uart - Behavioral
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

entity tb_rx_uart is
--  Port ( );
end tb_rx_uart;

architecture Behavioral of tb_rx_uart is

    component UART_RX
        port (clk       : in std_logic;
              RX_Serial : in std_logic;
              recieved    : out std_logic;
              RX_Byte   : out std_logic_vector (7 downto 0));
    end component;

    signal clk       : std_logic;
    signal RX_Serial : std_logic;
    signal recieved    : std_logic;
    signal RX_Byte   : std_logic_vector (7 downto 0);
    
    constant pulse : time := 15 ns;
    
begin

dut : UART_RX
port map (clk       => Clk,
          RX_Serial => rX_Serial,
          recieved    => recieved,
          RX_Byte   => RX_Byte);

Clk_process :process
          begin
                 clk <= '1';      
                 wait for pulse/2;  
                 clk <= '0';
                 wait for pulse/2;  
          end process;
              
st_process :process
          begin   
                 rx_serial <= '1';
                 wait for pulse*2*10416;
                              
                 rx_serial <= '0';
                 wait for pulse*1*10416;
                              
                 rx_serial <= '1';
                 wait for pulse*4*10416;
                              
                 rx_serial <= '0';
                 wait for pulse*4*10416;
                              
                 rx_serial <= '0';
                 wait for pulse*1*10416;
                                      
                 rx_serial <= '1';
                 wait for pulse*1*10416;
                                       
                 rx_serial <= '0';
                 wait for pulse*1*10416;
                               
                 rx_serial <= '0';
                 wait for pulse*3*10416;
                               
                 rx_serial <= '1';
                 wait for pulse*5*10416;
                               
                 rx_serial <= '0';
                 wait for pulse*1*10416;
                                                           
                 rx_serial <= '1';
                 wait for pulse*1*10416;
                               
		 rx_serial <= '0';
                 wait for pulse*1*10416;
                                
                 rx_serial <= '0';
                 wait for pulse*5*10416;
                                
                 rx_serial <= '1';
                 wait for pulse*3*10416;
                                
                 rx_serial <= '0';
                 wait for pulse*1*10416;
                                
                 rx_serial <= '1';
                 wait;  
          end process;

end Behavioral;
