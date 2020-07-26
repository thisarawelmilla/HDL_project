----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/25/2020 02:18:09 PM
-- Design Name: 
-- Module Name: tb_fsm - Behavioral
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

entity tb_fsm is
--  Port ( );
end tb_fsm;

architecture Behavioral of tb_fsm is
component fsm

PORT(start_flag : in STD_LOGIC;
    reset : in STD_LOGIC;
    clk : in STD_LOGIC;
        o_clk_out1 : out STD_LOGIC;
    o_clk_out2 : out STD_LOGIC;
     direction : out STD_LOGIC_VECTOR (1 downto 0);
       terminate_flag : out STD_LOGIC;
       address_1 : out STD_LOGIC_VECTOR (7 downto 0);
       address_2 : out STD_LOGIC_VECTOR (7 downto 0);
       address_3 : out STD_LOGIC_VECTOR (7 downto 0);
       
       pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
                      pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
                      pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
                      read_en : out STD_LOGIC;
                      enb : out STD_LOGIC;
                      addrb : out STD_LOGIC_VECTOR (7 downto 0);
          doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)    ;        
    o_pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
    o_pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
    o_pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_4 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_5 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_6 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_7 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_8 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_9 : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal start_flag : STD_LOGIC;
signal clk : STD_LOGIC;
signal    o_clk_out1 : STD_LOGIC;
signal o_clk_out2 :STD_LOGIC;
   signal reset : STD_LOGIC;
      signal i_pixel_1 : STD_LOGIC_VECTOR (7 downto 0);
  signal  i_pixel_2 : STD_LOGIC_VECTOR (7 downto 0);
   signal i_pixel_3 : STD_LOGIC_VECTOR (7 downto 0);
  signal i_doutb : STD_LOGIC_VECTOR(7 DOWNTO 0);
   
   signal o_pixel_1 : STD_LOGIC_VECTOR (7 downto 0);
  signal  o_pixel_2 : STD_LOGIC_VECTOR (7 downto 0);
   signal o_pixel_3 : STD_LOGIC_VECTOR (7 downto 0);
   signal pixel_4 : STD_LOGIC_VECTOR (7 downto 0);
   signal pixel_5 : STD_LOGIC_VECTOR (7 downto 0);
   signal pixel_6 : STD_LOGIC_VECTOR (7 downto 0);
   signal pixel_7 : STD_LOGIC_VECTOR (7 downto 0);
   signal pixel_8 : STD_LOGIC_VECTOR (7 downto 0);
   signal pixel_9 : STD_LOGIC_VECTOR (7 downto 0);
   
   signal i_direction : STD_LOGIC_VECTOR (1 downto 0);
   signal i_terminate_flag : STD_LOGIC;
   signal i_address_1 : STD_LOGIC_VECTOR (7 downto 0);
   signal i_address_2 : STD_LOGIC_VECTOR (7 downto 0);
   signal i_address_3 : STD_LOGIC_VECTOR (7 downto 0);
   
 signal read_en : STD_LOGIC;  
signal i_enb : STD_LOGIC;
   signal i_addrb : STD_LOGIC_VECTOR(7 DOWNTO 0);
   
constant pulse : time := 60 ns;

begin
fsm_1 :fsm
PORT map(start_flag => start_flag,
clk => clk,
    reset => reset,
        o_clk_out1 => o_clk_out1,
    o_clk_out2 => o_clk_out2,
     direction => i_direction,
                terminate_flag => i_terminate_flag,
                address_1 => i_address_1,
                address_2 => i_address_2,
                address_3 => i_address_3,
                pixel_1 => i_pixel_1,
                               pixel_2 => i_pixel_2,
                               pixel_3 => i_pixel_3,
                               read_en => read_en,
                               enb => i_enb,
                               addrb => i_addrb,
                               doutb => i_doutb,
    o_pixel_1 => o_pixel_1,
    o_pixel_2 => o_pixel_2,
    o_pixel_3 => o_pixel_3,
    pixel_4 => pixel_4,
    pixel_5 => pixel_5,
    pixel_6 => pixel_6,
    pixel_7 => pixel_7,
    pixel_8 => pixel_8,
    pixel_9 => pixel_9);
    
    
    
    
Clk_process_b :process
                   begin
                        clk <= '1';       
                        wait for pulse/2;  
                        clk <= '0';
                        wait for pulse/2;  
                   end process;      
              
             
       stimuli  : process
                         begin 
                             start_flag <= '1';
                             reset <= '0';
                             wait for pulse*1;
                             start_flag <= '0'; 
                             wait;
                   end process;

end Behavioral;
