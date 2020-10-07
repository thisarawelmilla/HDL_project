----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/27/2020 11:29:04 PM
-- Design Name: 
-- Module Name: down_counter_uart - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity up_counter_uart is
    -- pin descriptions

    -- enable: Enable the counter
    -- reset: Reset signal
    -- clock: Clock signal
    -- counter_out: Output of the counter

    Port ( enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           counter_out : out STD_LOGIC_VECTOR (9 downto 0));
end up_counter_uart;

architecture Behavioral of up_counter_uart is

    -- The Up Counter module is used to generate addresses for stores received byte from 
    -- UART RX Handler. Counter is counting upward by increasing the count value by one.

signal count :  STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    
begin
    process (enable,reset,clock)
    begin
        
        if reset = '1' then
	    -- initialize to zero when reset occurs
            count <= "0000000000";

        elsif rising_edge(clock) and enable = '1' then
	-- increase the address only when counter is enable
                counter_out <= count;
                count <= count + '1';
        end if;
    end process;
    

end Behavioral;
