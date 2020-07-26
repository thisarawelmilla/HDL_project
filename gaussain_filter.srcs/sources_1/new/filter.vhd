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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity filter is
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
end filter;

architecture Behavioral of filter is
component clk_wiz_0
port (
    clk_out1 : out STD_LOGIC;
 --   clk_out2 : out STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
end component;

component address_generator
 PORT ( start_flag : in STD_LOGIC;
          clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          enable : in STD_LOGIC;
          direction : out STD_LOGIC_VECTOR (1 downto 0);
          terminate_flag : out STD_LOGIC;
          address_1 : out STD_LOGIC_VECTOR (7 downto 0);
          address_2 : out STD_LOGIC_VECTOR (7 downto 0);
          address_3 : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component blk_mem_gen_0
 PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

component bram_accessor
 PORT ( address_1 : in STD_LOGIC_VECTOR (7 downto 0);
           address_2 : in STD_LOGIC_VECTOR (7 downto 0);
           address_3 : in STD_LOGIC_VECTOR (7 downto 0);
           pixel_value : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           start_flag : in STD_LOGIC;
           pixel_1 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_2 : out STD_LOGIC_VECTOR (7 downto 0);
           pixel_3 : out STD_LOGIC_VECTOR (7 downto 0);
           read_en : out STD_LOGIC;
           next_address : out STD_LOGIC;
           enb : out STD_LOGIC;
           addrb : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component pixel_value
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

signal clk_out1 : STD_LOGIC;
signal clk_out2 : STD_LOGIC;
signal locked : STD_LOGIC;

signal direction : STD_LOGIC_VECTOR (1 downto 0);
signal terminate_flag : STD_LOGIC;
signal address_1 : STD_LOGIC_VECTOR (7 downto 0);
signal address_2 : STD_LOGIC_VECTOR (7 downto 0);
signal address_3 : STD_LOGIC_VECTOR (7 downto 0);

signal ena :  STD_LOGIC;
signal wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal addra : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal enb : STD_LOGIC;
signal addrb : STD_LOGIC_VECTOR(7 DOWNTO 0);
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

begin

clk_wiz_0_1 : clk_wiz_0
 port map(
     clk_out1 => clk_out1,
 --    clk_out2 => clk_out2,
     locked => locked,
     clk_in1 => clk );
     
address_generator_1 : address_generator         
 port map(start_flag => start_flag,
     clk => clk,
     reset => reset,
     enable => next_address,
     direction => direction,
     terminate_flag => terminate_flag,
     address_1 => address_1,
     address_2 => address_2,
     address_3 => address_3);
               

blk_mem_gen_0_1 : blk_mem_gen_0                          
  port map(                                       
    clka => clk,                     
    ena => ena,                       
    wea => wea,   
    addra => addra,  
    dina => dina,   
    clkb => clk,                     
    enb => enb,                     
    addrb => addrb,  
    doutb => doutb);         
          
bram_accessor_1 : bram_accessor
 port map(
     address_2 => address_2,
     address_3 => address_3,
     address_1 => address_1,
     pixel_value => doutb,
     clk => clk, 
     start_flag => start_flag,
     pixel_1 => i_pixel_1,
     pixel_2 => i_pixel_2 ,
     pixel_3 => i_pixel_3,
     read_en => read_en,
     next_address => next_address,
     enb => enb,
     addrb => addrb);

 pixel_value_1 : pixel_value
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
        M13 => final_pixel_2,     
                                                  
        M21 => final_pixel_2,      
        M22 => final_pixel_2,     
        M23 => final_pixel_2,    
                                                  
        M31 => final_pixel_2,     
        M32 => final_pixel_2,      
        M33 => final_pixel_2,      
                                                  
        result => out_results);

               
process (CLK)
  begin
   IF (CLK'EVENT AND CLK = '1') THEN
     o_clk_out1 <= new_en;   
   --  o_clk_out2 <= clk_out2;            
     o_direction <= direction;
     o_terminate_flag <= terminate_flag;
     o_address_1 <= address_1;
     o_address_2 <= address_2;
     o_address_3 <= address_3;
     o_doutb <= doutb;
     o_pixel_1 <= i_pixel_1;
     o_pixel_2 <= i_pixel_2;
     o_pixel_3 <= i_pixel_3;
     o_read_en <= read_en;
     o_enb <= enb;
     o_addrb <= addrb;
      pixel_1 <= final_pixel_1;
      pixel_2 <= final_pixel_2;
      pixel_3 <= final_pixel_3;
      pixel_4 <= final_pixel_4;
      pixel_5 <= final_pixel_5;
      pixel_6 <= final_pixel_6;
      pixel_7 <= final_pixel_7;
      pixel_8 <= final_pixel_8;
      pixel_9 <= final_pixel_9;
      results <= out_results;
    END IF;
  end process;
end Behavioral;
