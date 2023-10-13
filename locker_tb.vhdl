library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity locker_tb is
end;

architecture bench of locker_tb is

  component locker
  port
  (	  
  		clk 			: in std_logic;
  		reset 		: in std_logic;
  		signal_in 	: in std_logic;
  		lock	 		: out std_logic;
  		error 		: out std_logic
  );
  end component;

  signal clk: std_logic := '0';
  signal reset: std_logic := '0';
  signal signal_in: std_logic := '0';
  signal lock: std_logic := '0';
  signal error: std_logic := '0';

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;
  
begin

   dut: locker port map ( clk       => clk,
                         reset     => reset,
                         signal_in => signal_in,
                         lock      => lock,
                         error     => error );

  stimulus: process
  begin
  
        signal_in<='0';
        reset <= '1';
        wait for clock_period;
        reset <= '0';
        wait for clock_period;
		  
		  signal_in<='1';
        wait for 11*clock_period;
        signal_in<='0';
		  wait for clock_period;
		  
        signal_in<='1';
        wait for 1*clock_period;
        signal_in<='0';
        wait for clock_period;
        signal_in<='1';
		  wait for 2*clock_period;
		  signal_in<='0';
		  wait for clock_period;
		  signal_in<='1';
		  wait for 3*clock_period;
		  signal_in<='0';
		  wait for clock_period;
		  
		  signal_in<='1';
        wait for 11*clock_period;
        signal_in<='0';
		  wait for clock_period;
		  
		  signal_in<='1';
        wait for 11*clock_period;
        signal_in<='0';
		  wait for clock_period;
		  
		  signal_in<='1';
        wait for 1*clock_period;
        signal_in<='0';
        wait for clock_period;
        signal_in<='1';
		  wait for 3*clock_period;
		  signal_in<='0';
		  wait for clock_period;
		  signal_in<='1';
		  wait for 2*clock_period;
		  signal_in<='0';
		  wait for clock_period;
		  
		  signal_in<='1';
        wait for 11*clock_period;
        signal_in<='0';
		  wait for clock_period;
		  
		  signal_in<='1';
		  wait for 11*clock_period;
		  signal_in<='0';
		  wait for clock_period;
		  
		  signal_in<='1';
        wait for 1*clock_period;
        signal_in<='0';
        wait for clock_period;
        signal_in<='1';
		  wait for 2*clock_period;
		  signal_in<='0';
		  wait for clock_period;
		  signal_in<='1';
		  wait for 3*clock_period;
		  signal_in<='0';
		  wait for clock_period;
		  
		  signal_in<='1';
        wait for 11*clock_period;
        signal_in<='0';
		  wait for clock_period;
		  
		  wait for clock_period;
		  stop_the_clock <= true;
		  wait;
  end process;
  
  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


end;