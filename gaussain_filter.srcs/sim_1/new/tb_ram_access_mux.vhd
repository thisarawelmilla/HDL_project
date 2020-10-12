----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/22/2020 09:14:59 PM
-- Design Name: 
-- Module Name: tb_mux - Behavioral
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

entity tb_ram_access_mux is
--  Port ( );
end tb_ram_access_mux;

architecture Behavioral of tb_ram_access_mux is
    component ram_access_mux
    port (filter_sel   : in std_logic;
          filter_wea   : in std_logic_vector (0 downto 0);
          filter_addra : in std_logic_vector (9 downto 0);
          filter_dina  : in std_logic_vector (7 downto 0);
          filter_enb   : in std_logic;
          filter_addrb : in std_logic_vector (9 downto 0);
          com_sel      : in std_logic;
          com_wea      : in std_logic_vector (0 downto 0);
          com_addra    : in std_logic_vector (9 downto 0);
          com_dina     : in std_logic_vector (7 downto 0);
          com_enb      : in std_logic;
          com_addrb    : in std_logic_vector (9 downto 0);
          ena          : out std_logic;
          wea          : out std_logic_vector (0 downto 0);
          addra        : out std_logic_vector (9 downto 0);
          dina         : out std_logic_vector (7 downto 0);
          enb          : out std_logic;
          addrb        : out std_logic_vector (9 downto 0));
end component;

signal filter_sel   : std_logic;
signal filter_wea   : std_logic_vector (0 downto 0);
signal filter_addra : std_logic_vector (9 downto 0);
signal filter_dina  : std_logic_vector (7 downto 0);
signal filter_enb   : std_logic;
signal filter_addrb : std_logic_vector (9 downto 0);
signal com_sel      : std_logic;
signal com_wea      : std_logic_vector (0 downto 0);
signal com_addra    : std_logic_vector (9 downto 0);
signal com_dina     : std_logic_vector (7 downto 0);
signal com_enb      : std_logic;
signal com_addrb    : std_logic_vector (9 downto 0);
signal ena          : std_logic;
signal wea          : std_logic_vector (0 downto 0);
signal addra        : std_logic_vector (9 downto 0);
signal dina         : std_logic_vector (7 downto 0);
signal enb          : std_logic;
signal addrb        : std_logic_vector (9 downto 0);

constant pulse : time := 15 ns;

begin

dut : ram_access_mux
port map (filter_sel   => filter_sel,
          filter_wea   => filter_wea,
          filter_addra => filter_addra,
          filter_dina  => filter_dina,
          filter_enb   => filter_enb,
          filter_addrb => filter_addrb,
          com_sel      => com_sel,
          com_wea      => com_wea,
          com_addra    => com_addra,
          com_dina     => com_dina,
          com_enb      => com_enb,
          com_addrb    => com_addrb,
          ena          => ena,
          wea          => wea,
          addra        => addra,
          dina         => dina,
          enb          => enb,
          addrb        => addrb);
        

 
stimuli  : process
       begin 
             filter_sel   <= '0';
             filter_wea   <= "1";
             filter_addra <= "0011011001";
             filter_dina  <= "00001100";
             filter_enb   <= '1';
             filter_addrb <= "0011000001";
             com_sel      <= '1';
             com_wea      <= "0";
             com_addra    <= "1100110011";
             com_dina     <= "00110011";
             com_enb      <= '1';
             com_addrb    <= "0000111100";
             wait for pulse*1;
                    
             filter_sel   <= '1';
             filter_wea   <= "1";
             filter_addra <= "0011011001";
             filter_dina  <= "00001100";
             filter_enb   <= '1';
             filter_addrb <= "0011000001";
             com_sel      <= '0';
             com_wea      <= "0";
             com_addra    <= "1100110011";
             com_dina     <= "00110011";
             com_enb      <= '1';
             com_addrb    <= "0000111100";
             wait for pulse*1;
      end process; 

end Behavioral;
