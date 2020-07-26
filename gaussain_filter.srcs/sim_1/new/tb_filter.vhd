----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/26/2020 12:35:33 AM
-- Design Name: 
-- Module Name: tb_filter - Behavioral
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

entity tb_filter is
--  Port ( );
end tb_filter;

architecture Behavioral of tb_filter is
component filter
port ( start_flag : in STD_LOGIC;
    clk : in STD_LOGIC;
reset : in STD_LOGIC;
o_clk_out1 : out STD_LOGIC;
o_clk_out2 : out STD_LOGIC;
o_direction : out STD_LOGIC_VECTOR (1 downto 0); 
o_terminate_flag : out STD_LOGIC;                
o_address_1 : out STD_LOGIC_VECTOR (7 downto 0); 
o_address_2 : out STD_LOGIC_VECTOR (7 downto 0); 
o_address_3 : out STD_LOGIC_VECTOR (7 downto 0);
o_doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
o_pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
o_pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
o_pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
o_read_en : out STD_LOGIC;
o_enb : out STD_LOGIC;
o_addrb : out STD_LOGIC_VECTOR (7 downto 0);
pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
pixel_4 : out STD_LOGIC_VECTOR (7 downto 0);
pixel_5 : out STD_LOGIC_VECTOR (7 downto 0);
pixel_6 : out STD_LOGIC_VECTOR (7 downto 0);
pixel_7 : out STD_LOGIC_VECTOR (7 downto 0);
pixel_8 : out STD_LOGIC_VECTOR (7 downto 0);
pixel_9 : out STD_LOGIC_VECTOR (7 downto 0);
results : out STD_LOGIC_VECTOR (7 downto 0));
end component;    

signal locked : STD_LOGIC;
signal start_flag : STD_LOGIC;
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal o_clk_out1 : STD_LOGIC;
signal o_clk_out2 : STD_LOGIC;
signal o_direction : STD_LOGIC_VECTOR (1 downto 0); 
signal o_terminate_flag : STD_LOGIC;                
signal o_address_1 : STD_LOGIC_VECTOR (7 downto 0); 
signal o_address_2 : STD_LOGIC_VECTOR (7 downto 0); 
signal o_address_3 : STD_LOGIC_VECTOR (7 downto 0);
signal o_doutb : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal o_pixel_1 : STD_LOGIC_VECTOR (7 downto 0);
signal o_pixel_2 : STD_LOGIC_VECTOR (7 downto 0);
signal o_pixel_3 : STD_LOGIC_VECTOR (7 downto 0);
signal o_read_en : STD_LOGIC;
signal o_enb : STD_LOGIC;
signal o_addrb : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_1 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_2 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_3 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_4 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_5 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_6 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_7 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_8 : STD_LOGIC_VECTOR (7 downto 0);
signal pixel_9 : STD_LOGIC_VECTOR (7 downto 0);
signal results : STD_LOGIC_VECTOR (7 downto 0);
    
constant pulse : time := 10 ns;

begin

filter_1 : filter 
port map( start_flag => start_flag,
    clk => clk,
    reset =>  reset,
    o_clk_out1 => o_clk_out1,
    o_clk_out2 => o_clk_out2,
    o_direction => o_direction, 
    o_terminate_flag => o_terminate_flag,            
    o_address_1 => o_address_1,
    o_address_2 => o_address_2,
    o_address_3 => o_address_3,
    o_doutb => o_doutb,
    o_pixel_1 => o_pixel_1,
    o_pixel_2 => o_pixel_2,
    o_pixel_3 => o_pixel_3,
    o_read_en =>o_read_en,
    o_enb => o_enb,
    o_addrb => o_addrb,
    pixel_1 => pixel_1,
    pixel_2 => pixel_2,
    pixel_3 => pixel_3,
    pixel_4 => pixel_4,
    pixel_5 => pixel_5,
    pixel_6 => pixel_6,
    pixel_7 => pixel_7,
    pixel_8 => pixel_8,
    pixel_9 => pixel_9,
    results => results);

Clk_process :process
    begin
       clk <= '1';       
       wait for pulse/2;  
       clk <= '0';
       wait for pulse/2;  
    end process;      
           
stimuli  : process
    begin
        reset <= '1';
 --       locked <= '1';
        start_flag <= '1';        
        wait for pulse/2;   
       start_flag <= '0'; 
       wait;
    end process;      
              


end Behavioral;
