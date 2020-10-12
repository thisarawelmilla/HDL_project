----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2020 07:48:45 AM
-- Design Name: 
-- Module Name: tb_uart_rx_handler - Behavioral
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

entity tb_uart_rx_handler is
--  Port ( );
end tb_uart_rx_handler;

architecture Behavioral of tb_uart_rx_handler is

component UART_RX_handeller
    port (  rX_DV : in STD_LOGIC;
	    rx_serial : in STD_LOGIC;
	    rx_enable : in STD_LOGIC;
	    rx_byte : out STD_LOGIC_VECTOR (7 downto 0);
	    addr_to_write : out STD_LOGIC_VECTOR (9 downto 0);           
	    reset : in STD_LOGIC;
	    clock : in STD_LOGIC);
end component;

signal rX_DV 	     : STD_LOGIC;
signal rx_serial     : std_logic;
signal rx_enable     : std_logic;
signal rx_byte       : std_logic_vector (7 downto 0);
signal addr_to_write : std_logic_vector (9 downto 0);
signal reset         : std_logic;
signal clock         : std_logic;

constant pulse : time := 15 ns;

begin
    dut : UART_RX_handeller
    port map (rX_enable        => rx_enable,
              rx_serial     => rx_serial,
              rx_byte       => rx_byte,
              addr_to_write => addr_to_write,
              reset         => reset,
              clock         => clock);

Clk_process :process
        begin
                clock <= '1';      
                wait for pulse/2;  
                clock <= '0';
                wait for pulse/2;  
        end process;

st_process :process
        begin                
                reset <= '0';
                rX_enable <= '1';
                rx_serial <= '1';
		rX_DV     <= '1';
                wait for pulse*2*10416;
                
                rx_serial <= '0';
                wait for pulse*2*10416;
                
                rx_serial <= '1';
                wait for pulse*2*10416;
                
                rx_serial <= '0';
                wait for pulse*1*10416;
                
                rx_serial <= '1';
                wait for pulse*3*10416;
                
                rx_serial <= '0';
                wait for pulse*2*10416;
                           
                rx_serial <= '1';
                wait for pulse*1*10416;
                
                rx_serial <= '0';
                wait for pulse*1*10416;
                 
                rx_serial <= '1';
                wait for pulse*1*10416;
                 
                rx_serial <= '0';
                wait for pulse*3*10416;
                 
                rx_serial <= '1';
                wait for pulse*1*10416;
                 
                rx_serial <= '1';
                wait for pulse*2*10416;
                 
                rx_serial <= '1';
                wait for pulse*1*10416;
                 
                rx_serial <= '0';
                wait for pulse*1*10416;
                                 
                rx_serial <= '1';
                wait for pulse*1*10416;
                                 
                rX_serial <= '0';
                wait for pulse*1*10416;
                                
                rx_serial <= '1';
                wait for pulse*1*10416;
                  
                rx_serial <= '0';
                wait for pulse*2*10416;
                  
                rx_serial <= '1';
                wait for pulse*4*10416;
                  
                rx_serial <= '0';
                wait for pulse*2*10416;
                  
                rx_serial <= '1';
                wait;  
        end process;
end Behavioral;
