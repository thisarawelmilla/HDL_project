----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2020 07:18:41 AM
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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

entity tb_UART_TX is
--  Port ( );
end tb_UART_TX;

architecture Behavioral of tb_UART_TX is
  component UART_TX is
    Port ( Tx_enable : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           READY : out  STD_LOGIC;
           TxD : out  STD_LOGIC);
  end component;

  signal tx_enable    : std_logic;
  signal data    : std_logic_vector (7 downto 0);
  signal clk     : std_logic;
  signal tx_active   : std_logic;
  signal TxD : std_logic;

constant pulse : time := 15 ns;

begin

dut : UART_TX
port map (Tx_enable   => tx_enable,
            data    => data,
            clk     => clk,
            READY   => tx_active,
            TxD => uart_tx);

clk_process :process
    begin
       clk <= '1';      
       wait for pulse/2;  
       clk <= '0';
       wait for pulse/2;  
    end process;      
           
stimuli  : process
    begin
       enbale <= '1';
       dtata <= "00011001";
       wait for pulse*10 *10416;
       
       enbale <= '1';
       dtata <= "01111001";
       wait for pulse*10 *10416;
       
       enbale <= '1';
       dtata <= "00011111";
       wait for pulse*10 *10416;

end Behavioral;
