----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/08/2020 09:34:20 AM
-- Design Name: 
-- Module Name: transmitter - Behavioral
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

entity UART_TX is

    -- pin descriptions
    
    -- clk: Clock signal
    -- Tx_enable: Enable the transmission
    -- data: Data to transmit
    -- reset: Reset signal
    -- TxD: Enable the TX CTRL


    Port ( clk : in STD_LOGIC;
           Tx_enable : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           reset : in STD_LOGIC;
           TxD : out STD_LOGIC);
end UART_TX;

architecture Behavioral of UART_TX is

    -- This module acts as the uart transmitter. The TX_enable enables the transmitter module. 
    -- The databyte to be transmitted are given through the data port. 
    -- The output bit values will go through the TxD port.

signal baudrate : integer := 9600;
signal clk_counter : integer range 0 to 9600 := 0;
signal bit_counter : integer range 0 to 7 := 0;
type states is (idle, start_bit, data_bit, stop_bit);
signal current_state : states := idle; 
signal bit_data : std_logic_vector(7 downto 0) := (others => '0');
  
begin

  
  process (Clk)
  begin
    if rising_edge(Clk) then
     if  reset = '1' then
             clk_counter <= 0;
             bit_counter <= 0;
             TxD <= '1'; 
             current_state <= idle ;
    else       
      case current_state is

        when idle =>
          TxD <= '1';   
          clk_counter <= 0;
          bit_counter <= 0;

          if Tx_enable = '1' then
            bit_data <= data;
            current_state <= start_bit;
          end if;

          
        when start_bit =>
          TxD <= '0';

          if clk_counter < baudrate - 1 then
            clk_counter <= clk_counter + 1;
            current_state   <= data_bit;
          else
            clk_counter <= 0;
            current_state   <= data_bit;
          end if;

               
        when data_bit =>
          TxD <= bit_data(bit_counter);
          
          if clk_counter < baudrate - 1 then
            clk_counter <= clk_counter + 1;
          else
            clk_counter <= 0;
          end if;
            
            if bit_counter < 7 then
              bit_counter <= bit_counter + 1;
            else
              bit_counter <= 0;
              current_state <= stop_bit;
            end if;


        when stop_bit =>
          TxD <= '1';

          if clk_counter < baudrate - 1 then
            clk_counter <= clk_counter + 1;
          else
            clk_counter <= 0;
          current_state <= idle;
          end if;

      end case;
    end if;
   end if;
  end process;


end Behavioral;
