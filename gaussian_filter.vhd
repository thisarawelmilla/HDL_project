library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use IEEE.numeric_std.all;

entity GaussianFilter is

    -- input output port mapping
	port(
    	clk: in std_logic;
        enable : in std_logic;

        -- M is represnting Matrix. This is 3x3 Matrix 
    	M11: in std_logic_vector(7 downto 0);
        M12: in std_logic_vector(7 downto 0);
        M13: in std_logic_vector(7 downto 0);
        
        M21: in std_logic_vector(7 downto 0);
        M22: in std_logic_vector(7 downto 0);
        M23: in std_logic_vector(7 downto 0);
        
        M31: in std_logic_vector(7 downto 0);
        M32: in std_logic_vector(7 downto 0);
        M33: in std_logic_vector(7 downto 0);
        
        -- output is a single value between 0 - 255
        result: out std_logic_vector(7 downto 0));
        
end GaussianFilter;

architecture behavior_gaussian_filter of GaussianFilter is 
    
begin

    process(M11, M12, M13, M21, M22, M23, M31, M32, M33, clk) is
        

        --- kernal is -- 1  2  1
                      -- 2  4  2
                      -- 1  2  1

        -- so M12 is multiple by 2 = 2^1. this mean left shift by one bit
        -- so M21 is multiple by 2 = 2^1. this mean left shift by one bit
        -- so M22 is multiple by 4 = 2^2. this mean left shift by two bits
        -- so M23 is multiple by 2 = 2^1. this mean left shift by one bit
        -- so M32 is multiple by 2 = 2^1. this mean left shift by one bit
    
    	-- store shifted 1 bit <<
		variable M12_shfited_by_1: std_logic_vector(8 downto 0); 
    
    	-- store shifted 1 bit <<
    	variable M21_shfited_by_1: std_logic_vector(8 downto 0); 
    
    	-- store shifted 1 bit <<
    	variable M23_shfited_by_1: std_logic_vector(8 downto 0); 
    
    	-- store shifted 1 bit <<
    	variable M32_shfited_by_1: std_logic_vector(8 downto 0); 
    
    	-- store shifted 2 bit <<
    	variable M22_shfited_by_2: std_logic_vector(9 downto 0); 
    
        -- The sum variables are have extra bit to carry overflow. This can prevent from overflow error

    	-- store M11 + M12_shfited_by_1
    	variable sum_1: std_logic_vector(9 downto 0);
    
    	-- store M13 + M21_shfited_by_1
    	variable sum_2: std_logic_vector(9 downto 0);
    
    	-- store M22_shfited_by_2 + M23_shfited_by_1
    	variable sum_3: std_logic_vector(10 downto 0);
    
    	-- store M31 + M32_shfited_by_1
    	variable sum_4: std_logic_vector(9 downto 0); 
    
    	-- store sum_1 + sum_2
    	variable sum_5: std_logic_vector(10 downto 0); 
    
    	-- store sum_3 + sum_4
    	variable sum_6: std_logic_vector(11 downto 0); 
    
    	-- store sum_5 + sum_6
    	variable sum_7: std_logic_vector(11 downto 0); 
    
    	-- store sum_7 + M33
    	variable sum_8: std_logic_vector(11 downto 0); 
   
        -- final output is sum8 divided by 16 = 2 ^ 4. this mean right shift by 4 bits. 
    	variable final_output: std_logic_vector(7 downto 0);
    
    begin
    	   IF (CLK'EVENT AND CLK = '1' and enable = '1') THEN
    
    			M12_shfited_by_1 := (M12 & "0"); -- left shift by one bit
        
        		M21_shfited_by_1 := (M21 & "0"); -- left shift by one bit
        
        		M23_shfited_by_1 := (M23 & "0"); -- left shift by one bit
        
        		M32_shfited_by_1 := (M32 & "0"); -- left shift by one bit
        		
        		M22_shfited_by_2 := (M22 & "00"); -- left shift by two bits

                -- so we have multiplied by the kernal. so now we have to sum the 9 values
                -- we will concatinating extra bits for prevent overflow error.
        
                -- M11 + M12(after multiplied by 2)
        		sum_1 := (("00" & M11) + ("0" & M12_shfited_by_1)); 
        
                -- M13 + M21(after multiplied by 2)
        		sum_2 := (("00" & M13) + ("0" & M21_shfited_by_1)); 
        
                -- M22(after multiplied by 4) + M23(after multiplied by 2)
        		sum_3 := (("0" & M22_shfited_by_2) + ("00" & M23_shfited_by_1)); 
        
                -- M31 + M32(after multiplied by 2)
        		sum_4 := (("00" & M31) + ("0" & M32_shfited_by_1)); 

                -- sum_1 + sum_2
        		sum_5 := (("0" & sum_1) + ("0" & sum_2));
        
                -- sum_3 + sum_4
        		sum_6 := (("0" & sum_3) + ("00" & sum_4)); 
        
                -- sum_5 + sum_6
        		sum_7 := (("0" & sum_5) + sum_6); 

                -- sum_7 + M33
        		sum_8 := (sum_7 + ("0000" & M33)); 
       
                -- shifting : for that we will ignore 4 least significant bits.
                -- results will be 8 bit logic vector
        		final_output := (sum_8(11 downto 4)); 
    
                -- assign the result to output signal
        		result <= final_output;
        
     end if;
        
    end process;
    
end behavior_gaussian_filter;