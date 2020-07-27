library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity GaussianFilter_tb is
end;

architecture bench of GaussianFilter_tb is

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

  signal clk: std_logic;
  signal enable: std_logic;
  signal M11: std_logic_vector(7 downto 0);
  signal M12: std_logic_vector(7 downto 0);
  signal M13: std_logic_vector(7 downto 0);
  signal M21: std_logic_vector(7 downto 0);
  signal M22: std_logic_vector(7 downto 0);
  signal M23: std_logic_vector(7 downto 0);
  signal M31: std_logic_vector(7 downto 0);
  signal M32: std_logic_vector(7 downto 0);
  signal M33: std_logic_vector(7 downto 0);
  signal result: std_logic_vector(7 downto 0);

  constant clock_period: time := 5 ns;
  signal stop_the_clock: boolean;
  constant pulse : time := 20 ns;

begin

  uut: GaussianFilter port map ( clk    => clk,
                                 enable => enable,
                                 M11    => M11,
                                 M12    => M12,
                                 M13    => M13,
                                 M21    => M21,
                                 M22    => M22,
                                 M23    => M23,
                                 M31    => M31,
                                 M32    => M32,
                                 M33    => M33,
                                 result => result );

  stimulus: process
  begin

    enable <= '1';
    M11 <= "11111111";
    M12 <= "00000000";
    M13 <= "00000000";
    M21 <= "00000000";
    M22 <= "00000000";
    M23 <= "00000000";
    M31 <= "00000000";
    M32 <= "00000000";
    M33 <= "11111111";
    
    wait for pulse*1;
    
    enable <= '1';
    M11 <= "11111111";
    M12 <= "11111111";
    M13 <= "00000000";
    M21 <= "00000000";
    M22 <= "00000000";
    M23 <= "00000000";
    M31 <= "00000000";
    M32 <= "00000000";
    M33 <= "11111111";
    
    wait for pulse*1;
    
    enable <= '0';
    M11 <= "11111111";
    M12 <= "00000000";
    M13 <= "00000000";
    M21 <= "00000000";
    M22 <= "00000000";
    M23 <= "00000000";
    M31 <= "00000000";
    M32 <= "00000000";
    M33 <= "11111111";
    
    wait for pulse*1;
    
    enable <= '1';
    M11 <= "11111111";
    M12 <= "11111111";
    M13 <= "11111111";
    M21 <= "11111111";
    M22 <= "11111111";
    M23 <= "11111111";
    M31 <= "11111111";
    M32 <= "11111111";
    M33 <= "11111111";

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;