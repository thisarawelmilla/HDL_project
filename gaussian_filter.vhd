library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use IEEE.numeric_std.all;

entity GaussianFilter is

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
        
        result: out std_logic_vector(11 downto 0));
        
end GaussianFilter;

architecture behavior_gaussian_filter of GaussianFilter is
    
begin

	process(M11, M12, M13, M21, M22, M23, M31, M32, M33, clk) is
    begin
    	IF (clk'EVENT AND clk = '1' and enable = '1') THEN

        	result <= (
            	(
                	"0" & (("0" & (("00" & M11) + (M12 & "0"))) +  -- sum 1
                    ("0" & (("00" & M13) +  (M21 & "0")))) -- sum 2
                ) 
            + 
            	(
                	("0" & (("0" & (M22 & "00")) + (M23 & "0"))) +  -- sum 3
                    ("00" & (("00" & M31) + (M32 & "0"))) -- sum 4
                )
            ) 
            + M33; 
        
     end if;
        
    end process;
    
    


end behavior_gaussian_filter;