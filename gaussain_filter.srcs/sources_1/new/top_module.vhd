----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/26/2020 12:31:49 AM
-- Design Name: 
-- Module Name: filter - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_module is

-- The top module assembles all the sub modules. As the implemented system can perform the 
-- gaussian blur on any size image (from 3x3 to 16x16), the width and the height of the image 
-- must be given the through the width input pin and the height input pin. The restart flag 
-- can be used to start the gaussian blurring operation.

-- pin descriptions

-- clk: Clock signal
-- start: Indicate the start of filter operation
-- reset: Reset signal
-- im_width: Input the width of the image
-- im_height: Input the height of the image
-- active_led: 
-- rx_terminate_led: 
-- tx_terminate_led: 
-- filter_terminate_led: 
-- rx_in:  
-- tx_out: 


port (im_width : in STD_LOGIC_VECTOR (3 downto 0); 
    im_height : in STD_LOGIC_VECTOR (3 downto 0);
    start : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    active_led : out STD_LOGIC;
    rx_terminate_led : out STD_LOGIC;
    tx_terminate_led : out STD_LOGIC;
    filter_terminate_led : out STD_LOGIC;
    
    rx_in : in STD_LOGIC;
    tx_out : out STD_LOGIC);
   
end top_module;

architecture Behavioral of top_module is

component ram_access_mux
    Port ( 
    filter_sel : IN STD_LOGIC;
    filter_wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    filter_addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    filter_dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    filter_enb : IN STD_LOGIC;
    filter_addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    com_sel : IN STD_LOGIC;
    com_wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    com_addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    com_dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    com_enb : IN STD_LOGIC;
    com_addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    ena : OUT STD_LOGIC;
    wea : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    enb : OUT STD_LOGIC;
    addrb : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
end component;

component address_generator
 PORT ( im_width : in STD_LOGIC_VECTOR (3 downto 0); 
    im_height : in STD_LOGIC_VECTOR (3 downto 0);
    start_flag : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    enable : in STD_LOGIC;
    active : out STD_LOGIC;
    direction : out STD_LOGIC_VECTOR (1 downto 0);
    terminate_flag : out STD_LOGIC;
    address_1 : out STD_LOGIC_VECTOR (9 downto 0);
    address_2 : out STD_LOGIC_VECTOR (9 downto 0);
    address_3 : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component blk_mem_gen_0
 PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

component bram_reader
 PORT ( address_1 : in STD_LOGIC_VECTOR (9 downto 0);
    address_2 : in STD_LOGIC_VECTOR (9 downto 0);
    address_3 : in STD_LOGIC_VECTOR (9 downto 0);
    pixel_value : in STD_LOGIC_VECTOR (7 downto 0);
    clk : in STD_LOGIC;
    enable : in STD_LOGIC; 
    reset : in STD_LOGIC;
    start_flag : in STD_LOGIC;
    pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
    read_en : out STD_LOGIC;
    next_address : out STD_LOGIC;
    enb : out STD_LOGIC;
    addrb : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component pixel_value_provider
 PORT ( clk: in STD_LOGIC;
    reset : in STD_LOGIC;
    start_flag : in STD_LOGIC;
    enable : in STD_LOGIC;
    read_en : out STD_LOGIC;
    direction : in STD_LOGIC_VECTOR (1 downto 0);
    bram_val_1 : in STD_LOGIC_VECTOR (7 downto 0);
    bram_val_2 : in STD_LOGIC_VECTOR (7 downto 0);
    bram_val_3 : in STD_LOGIC_VECTOR (7 downto 0);
    pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_4 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_5 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_6 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_7 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_8 : out STD_LOGIC_VECTOR (7 downto 0);
    pixel_9 : out STD_LOGIC_VECTOR (7 downto 0));
end component;


component GaussianFilter
	port(
    clk: in std_logic;
    enable : in std_logic;
    M11: in std_logic_vector(7 downto 0);
    M12: in std_logic_vector(7 downto 0);
    M13: in std_logic_vector(7 downto 0);
    M21: in std_logic_vector(7 downto 0);
    M22: in std_logic_vector(7 downto 0);
    M23: in std_logic_vector(7 downto 0);
    M31: in std_logic_vector(7 downto 0);
    M32: in std_logic_vector(7 downto 0);
    M33: in std_logic_vector(7 downto 0); 
    result: out std_logic_vector(7 downto 0));
end component;


component bram_writer
Port ( im_width : in STD_LOGIC_VECTOR (3 downto 0);
        im_height : in STD_LOGIC_VECTOR (3 downto 0);
     clk : in STD_LOGIC;
     reset : in STD_LOGIC;
     start_flag : in STD_LOGIC;
     enable : in STD_LOGIC;
     terminate : out STD_LOGIC;
     results : in STD_LOGIC_VECTOR (7 downto 0);
     addra : out STD_LOGIC_VECTOR (9 downto 0);
     ena : OUT STD_LOGIC;
     wea : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
     dina : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component UART_TX_handeller
    Port ( TX_DV : in STD_LOGIC;
           TX_Byte : in STD_LOGIC_VECTOR (7 downto 0);
           TX_Active : out STD_LOGIC;
           TX_Serial : out STD_LOGIC;
           TX_Done : out STD_LOGIC;
           addr_to_read : out STD_LOGIC_VECTOR (9 downto 0);           
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

component UART_RX_handeller
    port ( rX_DV : in STD_LOGIC;
           rx_serial : in STD_LOGIC;
           rx_enable : out STD_LOGIC;
           rx_byte : out STD_LOGIC_VECTOR (7 downto 0);
           addr_to_write : out STD_LOGIC_VECTOR (9 downto 0);           
           reset : in STD_LOGIC;
           clock : in STD_LOGIC);    
end component;

signal filter_sel : STD_LOGIC;
signal com_sel : STD_LOGIC;
signal com_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal com_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal com_dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal com_enb : STD_LOGIC;
signal com_addrb : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal start_flag : STD_LOGIC;
signal clk_out1 : STD_LOGIC;
signal clk_out2 : STD_LOGIC;
signal locked : STD_LOGIC;
signal active : STD_LOGIC;
signal direction : STD_LOGIC_VECTOR (1 downto 0);
signal terminate_flag : STD_LOGIC;
signal address_1 : STD_LOGIC_VECTOR (9 downto 0);
signal address_2 : STD_LOGIC_VECTOR (9 downto 0);
signal address_3 : STD_LOGIC_VECTOR (9 downto 0);
signal ena :  STD_LOGIC;
signal ow_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal ur_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal ow_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal ur_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ow_dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ur_dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal enb : STD_LOGIC;
signal ba_enb : STD_LOGIC;
signal wr_enb : STD_LOGIC;
signal addrb : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal ba_addrb : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal wr_addrb : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal doutb : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal i_pixel_1 : STD_LOGIC_VECTOR (7 downto 0);
signal i_pixel_2 : STD_LOGIC_VECTOR (7 downto 0);
signal i_pixel_3 : STD_LOGIC_VECTOR (7 downto 0);
signal read_en : STD_LOGIC;
signal next_address : STD_LOGIC;
signal final_pixel_1 : STD_LOGIC_VECTOR (7 downto 0);
signal final_pixel_2 : STD_LOGIC_VECTOR (7 downto 0);
signal final_pixel_3 : STD_LOGIC_VECTOR (7 downto 0);
signal final_pixel_4 : STD_LOGIC_VECTOR (7 downto 0);
signal final_pixel_5 : STD_LOGIC_VECTOR (7 downto 0);
signal final_pixel_6 : STD_LOGIC_VECTOR (7 downto 0);
signal final_pixel_7 : STD_LOGIC_VECTOR (7 downto 0);
signal final_pixel_8 : STD_LOGIC_VECTOR (7 downto 0);
signal final_pixel_9 : STD_LOGIC_VECTOR (7 downto 0);
signal out_results : STD_LOGIC_VECTOR (7 downto 0);
signal new_en : STD_LOGIC;
signal write : STD_LOGIC;
signal enable : STD_LOGIC;
signal delay_start : STD_LOGIC := '0';
signal terminate : STD_LOGIC := '0';
signal tx_terminate : STD_LOGIC := '0';
signal rx_terminate : STD_LOGIC := '0';
signal tx_terminate_1 : STD_LOGIC := '0';
signal rx_start : STD_LOGIC;
signal tx_start : STD_LOGIC;
signal tx_active : STD_LOGIC;
signal rx_out : STD_LOGIC;
signal rx_serial: STD_LOGIC;
signal tx_serial : STD_LOGIC;
signal im_size : integer;
signal out_im_size : integer;
signal mux_ena : STD_LOGIC;


TYPE state_types IS (idle, rx, filter, tx);
signal state : state_types := idle;

begin

ram_access_mux_1 : ram_access_mux     
    port map(filter_sel => filter_sel,
    filter_wea => ow_wea,
    filter_addra => ow_addra,
    filter_dina => ow_dina,
    filter_enb => ba_enb,
    filter_addrb => ba_addrb,
    com_sel => com_sel,
    com_wea => com_wea,
    com_addra => com_addra,
    com_dina => com_dina,
    com_enb => com_enb,
    com_addrb => com_addrb,    
    ena => mux_ena,                       
    wea => wea,   
    addra => addra,  
    dina => dina,                       
    enb => enb,                     
    addrb => addrb);
     
address_generator_1 : address_generator         
 port map(im_width => im_width,
     im_height => im_height,
     start_flag => start_flag,
     clk => clk,
     reset => reset,
     enable => next_address,
     active => active,
     direction => direction,
     terminate_flag => terminate_flag,
     address_1 => address_1,
     address_2 => address_2,
     address_3 => address_3);
               

blk_mem_gen_0_1 : blk_mem_gen_0                          
  port map(                                       
     clka => clk,                   
     ena => '1',                       
     wea => wea,   
     addra => addra,  
     dina => dina,   
     clkb => clk,                     
     enb => enb,                     
     addrb => addrb,  
     doutb => doutb);         
          
bram_accessor_1 : bram_reader
 port map(
     address_2 => address_2,
     address_3 => address_3,
     address_1 => address_1,
     pixel_value => doutb,
     clk => clk,
     enable => active,
     reset => reset,   
     start_flag => start_flag,
     pixel_1 => i_pixel_1,
     pixel_2 => i_pixel_2 ,
     pixel_3 => i_pixel_3,
     read_en => read_en,
     next_address => next_address,
     enb => ba_enb,
     addrb => ba_addrb);

 pixel_value_1 : pixel_value_provider
  port map(clk => clk,
    reset => reset,
    enable => read_en,
    read_en => new_en,
    start_flag => start_flag,
    direction => direction,
    bram_val_1 => i_pixel_1,
    bram_val_2 => i_pixel_2,
    bram_val_3 => i_pixel_3,
    pixel_1 => final_pixel_1,
    pixel_2 => final_pixel_2,
    pixel_3 => final_pixel_3, 
    pixel_4 => final_pixel_4,
    pixel_5 => final_pixel_5,
    pixel_6 => final_pixel_6,
    pixel_7 => final_pixel_7,
    pixel_8 => final_pixel_8,
    pixel_9 => final_pixel_9);                      
                 
 GaussianFilter_1 : GaussianFilter
  port map(                                            
    clk => clk,                       
    enable => new_en,                   
    M11 => final_pixel_1, 
    M12 => final_pixel_2, 
    M13 => final_pixel_3,                                                     
    M21 => final_pixel_4,      
    M22 => final_pixel_5,     
    M23 => final_pixel_6,                                                 
    M31 => final_pixel_7,     
    M32 => final_pixel_8,      
    M33 => final_pixel_9,                                                       
    result => out_results);
        
output_writer_1 : bram_writer
  port map ( im_width => im_width,
     im_height => im_height,
     clk => clk,
     reset => reset,
     terminate => terminate,
     start_flag => start_flag, 
     enable => write,
     results => out_results,
     addra => ow_addra,
     ena => ena,
     wea => ow_wea,
     dina => ow_dina);
   
UART_TX_handeller_1 : UART_TX_handeller
         Port map( TX_DV => tx_start,
                TX_Byte => doutb,
                TX_Active => tx_active,
                TX_Serial => tx_out,
                TX_Done => tx_terminate_1,
                addr_to_read => com_addrb,        
                reset => reset,
                clock => clk);
  
UART_RX_handeller_1 : UART_RX_handeller
         port map( rX_DV => rx_start,
                rx_serial =>  rx_in,
                rx_enable => rx_out,
                rx_byte => com_dina,
                addr_to_write => com_addra,          
                reset => reset,
                clock => clk);    

  
rx_terminate_led <= rx_terminate;    
tx_terminate_led <= tx_terminate;    
    
        
process (CLK, rx_terminate, tx_terminate, start)
  begin
   IF (CLK'EVENT AND CLK = '1') THEN
      if reset = '1' then
            state <= idle;
      end if;
      CASE state IS 
        WHEN idle =>
            filter_terminate_led <= '0';
            active_led <= '0';
            tx_start <= '0';
            com_sel <= '0';
            filter_sel <= '0';
            com_enb <= '0';
            im_size <= to_integer(unsigned(im_width)) * to_integer(unsigned(im_height));
            out_im_size <= (to_integer(unsigned(im_width))-2) * (to_integer(unsigned(im_height))-2);
            rx_terminate <= '0';
            tx_terminate <= '0';
            
            if start = '1' then
                active_led <= '1';
                state <= rx;
            end if;
            
        when rx =>
            rx_start <= '1';
            com_sel <= '1';
            filter_sel <= '0';
            com_enb <= '0';
            if rx_out = '1' then
            com_wea <= "1"; 
            end if;
            if rx_terminate = '1' then
                state <= filter; 
                rx_start <= '0';
                start_flag <= '1'; 
                com_wea <= "0";
            else   
                if im_size -1 = to_integer(unsigned(com_addra)) then
                    rx_terminate <= '1';
                    rx_start <= '0';
                    
                end if;    
            end if;
            
        when filter =>
            start_flag <= '0';
            com_sel <= '0';
            com_enb <= '0';
            filter_sel <= '1';
            if terminate = '1' then
                state <= tx;
            else
                enable <= (not terminate_flag) and start_flag;
      
                if terminate = '1' or reset = '1' or start_flag = '1' then
                  write <= '0';
                else 
                   if new_en = '1' then
                       write <= '1';
                   end if; 
                end if;
            end if;
            
        when tx =>
            filter_terminate_led <= '1';
            com_sel <= '1';
            filter_sel <= '0';
            tx_start <= '1';
            com_enb <= '1';
            if tx_terminate = '1' then
                state <= idle;
                com_sel <= '0';
                filter_sel <= '0';
                com_enb <= '0';
                tx_start <= '0';
                
            else 
                if out_im_size -1 = to_integer(unsigned(com_addrb)) then
                    tx_terminate <= '1';
                    tx_start <= '0';
                    
                end if;
            end if;       
      end case;
     

    END IF;
  end process;
end Behavioral;
