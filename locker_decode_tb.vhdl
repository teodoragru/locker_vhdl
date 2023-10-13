library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity locker_decode_cmd_tb is
end locker_decode_cmd_tb;

architecture test of locker_decode_cmd_tb is

  component locker_decode_cmd
  port(
  	signal_in : in std_logic;
  	reset : in std_logic := '1';
  	clk : in std_logic := '0';
  	num_value : out std_logic_vector(3 downto 0);
  	num_valid : out std_logic;
  	cmd_ok : out std_logic;
  	cmd_cancel : out std_logic
  );
  end component;

  signal signal_in: std_logic;
  signal reset: std_logic;
  signal clk: std_logic := '0';
  signal num_value: std_logic_vector(3 downto 0) := "0000";
  signal num_valid: std_logic := '0';
  signal cmd_ok: std_logic := '0';
  signal cmd_cancel: std_logic := '0';
  
  constant Tclk: time := 10 ns;
--signal stop_the_clock: boolean;

begin

  clk_gen: clk <= not clk after Tclk / 2;
  
  dut: entity work.locker_decode_cmd port map ( 
												signal_in  => signal_in,
                                    reset      => reset,
                                    clk        => clk,
                                    num_value  => num_value,
                                    num_valid  => num_valid,
                                    cmd_ok     => cmd_ok,
                                    cmd_cancel => cmd_cancel );

  stimulus: process
  begin
		wait for 4*Tclk;
		reset <= '0';
		wait for 2*Tclk;
		signal_in <= '0';
		wait for 10*Tclk;
		signal_in <= '1';
		wait for 8*Tclk;
		signal_in <= '0';
		wait for 5*Tclk;
		signal_in <= '1';
		wait for 12*Tclk;
		signal_in <= '0';
		wait for 8*Tclk;
		signal_in <= '1';
		wait for 10*Tclk;
		wait;
		
    

    --stop_the_clock <= true;
  end process;

--  clocking: process
--  begin
--    while not stop_the_clock loop
--      clk <= not clk after Tclk / 2;
--      wait for clock_period;
--    end loop;
--    wait;
--  end process;

end;