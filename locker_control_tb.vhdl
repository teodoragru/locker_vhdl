library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity locker_control_tb is
end;

architecture bench of locker_control_tb is

  component locker_control
  port(
  	num_value : in std_logic_vector(3 downto 0);
  	num_valid : in std_logic;
  	cmd_ok : in std_logic;
  	cmd_cancel : in std_logic;
  	reset : in std_logic;
  	clk : in std_logic;
  	lock : out std_logic;
  	error : out std_logic
  );
  end component;

  signal num_value: std_logic_vector(3 downto 0) := "0000";
  signal num_valid: std_logic := '0';
  signal cmd_ok: std_logic := '0';
  signal cmd_cancel: std_logic := '0';
  signal reset: std_logic := '0';
  signal clk: std_logic := '0';
  signal lock: std_logic := '0';
  signal error: std_logic := '0';

  constant Tclk: time := 10 ns;
begin
  
  clk_gen: clk <= not clk after Tclk / 2;

  dut: entity work.locker_control port map ( num_value  => num_value,
                                 num_valid  => num_valid,
                                 cmd_ok     => cmd_ok,
                                 cmd_cancel => cmd_cancel,
                                 reset      => reset,
                                 clk        => clk,
                                 lock       => lock,
                                 error      => error );

  stimulus: process
  begin
	wait for 2*Tclk;
	cmd_ok <= '1';
	wait for 2*Tclk;
	cmd_ok <= '0';
	wait for 2*Tclk;
	num_valid <= '1';
	num_value <= "1001";
	wait for 2*Tclk;
	num_valid <= '1';
	num_value <= "0110";
	wait for 2*Tclk;
	num_valid <= '1';
	num_value <= "0010";
	wait for 2*Tclk;
	num_valid <= '0';
	num_value <= "0000";
	wait for 2*Tclk;
	cmd_ok <= '1';
	wait for 2*Tclk;
	cmd_ok <= '0';
	wait for 4*Tclk;
	num_valid <= '1';
	num_value <= "1001";
	wait for 2*Tclk;
	num_valid <= '1';
	num_value <= "0101";
	wait for 2*Tclk;
	num_valid <= '1';
	num_value <= "0010";
	wait for 2*Tclk;
	num_valid <= '0';
	num_value <= "0000";
	wait for 2*Tclk;
	cmd_ok <= '1';
	wait for 2*Tclk;
	cmd_ok <= '0';
	wait for 4*Tclk;
	cmd_ok <= '1';
	wait for 2*Tclk;
	cmd_ok <= '0';
	wait for 2*Tclk;
	num_valid <= '1';
	num_value <= "1001";
	wait for 2*Tclk;
	num_valid <= '1';
	num_value <= "0110";
	wait for 2*Tclk;
	num_valid <= '1';
	num_value <= "0010";
	wait for 2*Tclk;
	num_valid <= '0';
	num_value <= "0000";
	wait for 2*Tclk;
	cmd_ok <= '1';
	wait for 2*Tclk;
	cmd_ok <= '0';
	wait for 2*Tclk;
	wait;
	
  end process;
end;