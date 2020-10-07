----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 07:29:46 PM
-- Design Name: 
-- Module Name: UART_RX_handeller - Behavioral
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

entity UART_RX_handeller is

    -- pin descriptions

    -- rX_DV: Enable the module
    -- rx_serial: RX values coming from rx port
    -- rx_enable: Indication of data receiving from rx port
    -- rx_byte: Received byte
    -- addr_to_write: Address to write the received byte
    -- reset: Reset signal
    -- clock: Clock signal


    Port ( rX_DV : in STD_LOGIC;
           rx_serial : in STD_LOGIC;
           rx_enable : out STD_LOGIC;
           rx_byte : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_write : out STD_LOGIC_VECTOR (9 downto 0);           
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end UART_RX_handeller;


architecture Behavioral of UART_RX_handeller is


    -- The UART RX Handler component consists of two modules. There are RX_UART module and 
    -- address counter module. When the RX_UART module produces a received pixel value, this 
    -- module enables the address counter module to increment the address. As the output it 
    -- provides the byte value along with the address to write in the ram module. rx_enable 
    -- module indicates the presence of such data income. This module is only active when 
    -- rx_DV is high. 

component UART_RX is
  generic (
    CLKS_PER_BIT : integer := 10416     
    );
  port (
    clk       : in  std_logic;
    RX_Serial : in  std_logic;
    recieved    : out std_logic;
    RX_Byte   : out std_logic_vector(7 downto 0)
    );
end component;

component up_counter_uart is
    Port ( enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (9 downto 0));
end component;

signal en : std_logic;
signal enable : std_logic;

begin

uart_rx_module : UART_RX
    port map (clk => clock,
              RX_Serial => rx_serial,
              recieved=> en,
              RX_Byte => rx_byte);

up_counter : up_counter_uart
    port map (enable => enable,
              reset => reset,
              clock => clock,
              counter_out => addr_to_write);
              
enable <= en AND rX_DV;
rx_enable <= en;
end Behavioral;
