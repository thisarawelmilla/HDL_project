----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 10:53:20 PM
-- Design Name: 
-- Module Name: UART_TX_handeller - Behavioral
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

entity UART_TX_handeller is

    -- pin descriptions

    -- TX_enable: Enable the module
    -- TX_Byte: databyte to be transmitted
    -- TX_Active: Indication of whether data transmitting through the TX port
    -- TX_Serial: data bit to transmit through TX port
    -- TX_Done: Indicates whether the data bit transmission is done for given last byte
    -- addr_to_read: Address to read the byte
    -- reset: Reset signal
    -- clock: Clock signal


    Port (
           TX_enable : in STD_LOGIC;
           TX_Byte : in STD_LOGIC_VECTOR (7 downto 0);
           TX_Active : out STD_LOGIC;
           TX_Serial : out STD_LOGIC;
           TX_Done : out STD_LOGIC;
           addr_to_read : out STD_LOGIC_VECTOR (9 downto 0);           
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end UART_TX_handeller;


architecture Behavioral of UART_TX_handeller is


    -- The UART TX Handler component consists of two modules. There are the TX_UART module 
    -- and address counter module. As the output it provides the bit value along with the 
    -- address to read from the ram module. Tx_enable module indicates the presence of such 
    -- data transmission. This module is only active when TX_DV is high.
 
	component UART_TX is
	-- to transmiter the data
	    Port ( TX_enable : in  STD_LOGIC;
	       data : in  STD_LOGIC_VECTOR (7 downto 0);
	       clk : in  STD_LOGIC;
	       TX_ready : out  STD_LOGIC;
	       TX_out : out  STD_LOGIC);
	end component;

	component up_counter_uart is
	-- to provide the next address to be read
	    Port ( clock : in STD_LOGIC;
		   enable : in STD_LOGIC;
		   reset : in STD_LOGIC;
		   counter_out : out STD_LOGIC_VECTOR (9 downto 0));
	end component;

signal TX_ready : std_logic;
signal enable : std_logic;

begin

	uart_tx_module: UART_TX
	    port map (clk => clock,
		      TX_enable => TX_DV,
		      data => TX_Byte,
		      TX_out  => TX_Serial,
		      TX_ready => TX_ready);
		      
	address_counter : up_counter_uart
	    port map (clock => clock,
		      enable => enable,
		      reset => reset,
		      counter_out => addr_to_read);

process (clk, TX_ready, TX_enable)
begin    
	-- enable the address counter to generate next address to be read only at the this 
	-- module is enabled and UART_TX module is done current job 
	enable <= TX_ready AND TX_enable;
	TX_Done <= TX_ready;

end Behavioral;
