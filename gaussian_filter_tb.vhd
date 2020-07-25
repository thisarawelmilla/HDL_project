-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity GaussianFilterTB is
end GaussianFilterTB;

architecture tb of GaussianFilterTB is

component GaussianFilter is
port(
  --clk: in std_logic;
        
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

--signal clk_in: std_logic;
signal M11_in, M12_in, M13_in, M21_in, M22_in, M23_in, M31_in, M32_in, M33_in, result_out: std_logic_vector(7 downto 0);

begin

  DUT: GaussianFilter port map(
  	 M11_in, M12_in, M13_in, M21_in, M22_in, M23_in, M31_in, M32_in, M33_in, result_out);

  process
  begin
    --clk_in <= '1';
    
    M11_in <= "00000000";
    M12_in <= "00000000";
    M13_in <= "00000000";
    M21_in <= "00000000";
    M22_in <= "11111111";
    M23_in <= "11111111";
    M31_in <= "11111111";
    M32_in <= "11111111";
    M33_in <= "11111111";
    
    wait for 1000 ns;
    assert(result_out="11111111") report "pass" severity error;
    
    report "result:" & to_string(result_out);
 

    assert false report "Test done." severity note;
    wait;
  end process;
end tb;