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
        
        result: out std_logic_vector(7 downto 0));
        
end GaussianFilter;

architecture behavior_gaussian_filter of GaussianFilter is 
    
begin

	process(M11, M12, M13, M21, M22, M23, M31, M32, M33, clk) is
    
    	-- shifted 1 bit <<
		variable M12_shfited_by_1: std_logic_vector(8 downto 0); 
    
    	-- shifted 1 bit <<
    	variable M21_shfited_by_1: std_logic_vector(8 downto 0); 
    
    	-- shifted 1 bit <<
    	variable M23_shfited_by_1: std_logic_vector(8 downto 0); 
    
    	-- shifted 1 bit <<
    	variable M32_shfited_by_1: std_logic_vector(8 downto 0); 
    
    	-- shifted 2 bit <<
    	variable M22_shfited_by_2: std_logic_vector(9 downto 0); 
    
    	-- M11 + M12_shfited_by_1
    	variable sum_1: std_logic_vector(9 downto 0);
    
    	-- M13 + M21_shfited_by_1
    	variable sum_2: std_logic_vector(9 downto 0);
    
    	-- M22_shfited_by_2 + M23_shfited_by_1
    	variable sum_3: std_logic_vector(10 downto 0);
    
    	-- M31 + M32_shfited_by_1
    	variable sum_4: std_logic_vector(9 downto 0); 
    
    	-- sum_1 + sum_2
    	variable sum_5: std_logic_vector(10 downto 0); 
    
    	-- sum_3 + sum_4
    	variable sum_6: std_logic_vector(11 downto 0); 
    
    	-- sum_5 + sum_6
    	variable sum_7: std_logic_vector(11 downto 0); 
    
    	-- sum_7 + M33
    	variable sum_8: std_logic_vector(11 downto 0); 
   
    	variable final_output: std_logic_vector(7 downto 0);
    
    begin
    	   IF (CLK'EVENT AND CLK = '1' and enable = '1') THEN
    
    			M12_shfited_by_1 := (M12 & "0");
        
        		M21_shfited_by_1 := (M21 & "0"); 
        
        		M23_shfited_by_1 := (M23 & "0"); 
        
        		M32_shfited_by_1 := (M32 & "0"); 
        		
        		M22_shfited_by_2 := (M22 & "00");

        		-- summing
        
        		sum_1 := (("00" & M11) + ("0" & M12_shfited_by_1)); 
        
        		sum_2 := (("00" & M13) + ("0" & M21_shfited_by_1)); 
        
        		sum_3 := (("0" & M22_shfited_by_2) + ("00" & M23_shfited_by_1)); 
        
        		sum_4 := (("00" & M31) + ("0" & M32_shfited_by_1)); 

        
        		sum_5 := (("0" & sum_1) + ("0" & sum_2));
        
        		sum_6 := (("0" & sum_3) + ("00" & sum_4)); 
        

        		sum_7 := (("0" & sum_5) + sum_6); 

        
        		sum_8 := (sum_7 + ("0000" & M33)); 
       
        
        		-- shifting 

        		final_output := (sum_8(11 downto 4)); 
        
        		-- final result
	
        		result <= final_output;
        
     end if;
        
    end process;
    
    


end behavior_gaussian_filter;
