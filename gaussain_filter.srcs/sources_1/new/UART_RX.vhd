----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/08/2020 11:00:12 AM
-- Design Name: 
-- Module Name: reciever - Behavioral
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

--
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity UART_RX is

  -- pin descriptions

  -- Clk: Clock Signal
  -- RX_Serial: Data bit to receive through RX port
  -- recieved: Enable the
  -- RX_Byte: Output the received byte data

  generic (
    CLKS_PER_BIT : integer := 115     -- Needs to be set correctly
    );
  port (
    clk       : in  std_logic;
    RX_serial : in  std_logic;
    recieved  : out std_logic;
    RX_Byte   : out std_logic_vector(7 downto 0)
    );
end UART_RX;
 
 
architecture Behaviora of UART_RX is
 
  type state is (idle, start_bit, data_bits,
                     stop_bit, cleanup);
  signal current_state : state := idle;
 
  signal input_byte : std_logic := '0';
  signal data   : std_logic := '0';
   
  signal clk_count : integer range 0 to CLKS_PER_BIT-1 := 0;
  signal bit_index : integer range 0 to 7 := 0;  -- 8 Bits Total
  signal data_byte   : std_logic_vector(7 downto 0) := (others => '0');
  signal recieved_byte    : std_logic := '0';
   
begin
 
  -- This module acts as the uart receiver. The rX_enable enables the transmitter module. 
  -- The databyte to be transmitted are given through the data port. The output bit values 
  -- will go through the TxD port.

  process (clk)
  begin
    if rising_edge(clk) then
      input_byte <= RX_Serial;
      data   <= input_byte;
    end if;
  end process;
   
 
  -- Purpose: Control RX state machine
 process (clk)
  begin
    if rising_edge(clk) then
         
      case current_state is
 
        when idle =>
          recieved_byte    <= '0';
          clk_count <= 0;
          bit_index <= 0;
 
          if data = '0' then       -- Start bit detected
            current_state <= start_bit;
          else
            current_state <= idle;
          end if;
 
           
        -- Check middle of start bit to make sure it's still low
        when start_bit =>
          if clk_count = (CLKS_PER_BIT-1)/2 then
            if data = '0' then
              clk_count <= 0;  -- reset counter since we found the middle
              current_state   <= data_bits;
            else
              current_state   <= idle;
            end if;
          else
            clk_count <= clk_count + 1;
            current_state   <= start_bit;
          end if;
 
           
        -- Wait CLKS_PER_BIT-1 clock cycles to sample serial data
        when data_bits =>
          if clk_count < CLKS_PER_BIT-1 then
            clk_count <= clk_count + 1;
            current_state   <= data_bits;
          else
            clk_count            <= 0;
            data_byte(bit_index) <= data;
             
            -- Check if we have sent out all bits
            if bit_index < 7 then
              bit_index <= bit_index + 1;
              current_state   <= data_bits;
            else
              bit_index <= 0;
              current_state   <= stop_bit;
            end if;
          end if;
 
 
        -- Receive Stop bit.  Stop bit = 1
        when stop_bit =>
          -- Wait CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if clk_count < CLKS_PER_BIT-1 then
            clk_count <= clk_count + 1;
            current_state   <= stop_bit;
          else
            recieved_byte    <= '1';
            clk_count <= 0;
            current_state   <= cleanup;
          end if;
 
                   
        -- Stay here 1 clock
        when cleanup =>
          current_state <= idle;
          recieved_byte  <= '0';
 
             
        when others =>
          current_state <= idle;
 
      end case;
    end if;
  end process;
 
  recieved  <= recieved_byte;
  RX_Byte <= data_byte;
   
end Behavioral;
