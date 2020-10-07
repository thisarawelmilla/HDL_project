----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2020 10:27:34 AM
-- Design Name: 
-- Module Name: ram_access_mux - Behavioral
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

entity ram_access_mux is


    -- pin descriptions

    -- filter_sel: To select the inputs coming from filter module
    -- filter_wea: Filter needs needs to enable to write
    -- filter_addra: Filter needs needs to address for part A
    -- filter_dina: Filter needs needs to pixel value to save at the address given for the port A
    -- filter_enb: Filter needs needs to enable the port B
    -- filter_addrb: Filter needs needs to address to read from port B
    -- com_sel: To select the inputs coming from uart communication module
    -- com_wea: UART RX handler needs to enable to write
    -- com_addra: UART RX handler needs to address for part A
    -- com_dina: UART RX handler needs to pixel value to save at the address given for the port A
    -- com_enb: UART TX handler needs to enable the port B
    -- com_addrb: UART TX handler needs to address to read from port B
    -- ena: Enable the bram
    -- wea: Enable to write the bram from port A
    -- addra: Address for part A of bram
    -- dina: Pixel value to save at the address given for the port A
    -- enb: Enable the port B
    -- addrb: Address to read from port B

    Port ( 
    -- select the inputs of comming from filter module 
    filter_sel : IN STD_LOGIC;
    filter_wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    filter_addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    filter_dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    filter_enb : IN STD_LOGIC;
    filter_addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    -- select the inputs of comming from uart_handler
    com_sel : IN STD_LOGIC;
    com_wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    com_addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    com_dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    com_enb : IN STD_LOGIC;
    com_addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    -- enable the bram
    ena : OUT STD_LOGIC;
    wea : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    enb : OUT STD_LOGIC;
    addrb : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
end ram_access_mux;


architecture Behavioral of ram_access_mux is

    -- Both uart modules and filter access the ram module. This module acts as a mux and 
    -- outputs the relevant value which will be used as the inputs to the ram modules. 
    -- The port named such that filter, are from the filter module while the port named 
    -- such that com, are from the uart communication module

begin
    process( filter_sel, filter_wea, filter_addra, filter_dina, filter_enb, filter_addrb,
         com_sel, com_wea, com_addra, com_dina, com_enb, com_addrb) 
      begin
    --if neigher the filter_sel nor com_sel (which say what input must be consider to provide output) 
    --is selected then all the outputs will be holds the default values ;disable all pins goes to bram
    --and set address and dina values to zero.
        if filter_sel = '0' and com_sel = '0' then
           ena <= '1';
           wea <= "0";
           addra <= "0000000000";
           dina <= "00000000";
           enb <= '0';
           addrb <= "0000000000";
    
    --if the com_sel is high (means the input coming from uart handler module must be consider), then 
    --the input with com_* are used to determine the output. Here the filter_sel must be in low.
        elsif filter_sel = '0' and com_sel = '1' then
           ena <= '1';
           wea <= com_wea;
           addra <= com_addra;
           dina <= com_dina;
           enb <= com_enb;
           addrb <= com_addrb;
                  
    --if the filter_sel is high (means the input coming from guassian filter module must be consider), 
    --then the input with filter_* are used to determine the output. Here the com_sel must be in low.
        elsif filter_sel = '1' and com_sel = '0' then
           ena <= '1';
           wea <= filter_wea;
           addra <= filter_addra;
           dina <= filter_dina;
           enb <= filter_enb;
           addrb <= filter_addrb; 
        
        end if;
    end process;
end Behavioral;
