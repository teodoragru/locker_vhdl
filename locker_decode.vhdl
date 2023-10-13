library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity locker_decode_cmd is
port(
	signal_in : in std_logic;
	reset : in std_logic;
	clk : in std_logic;
	num_value : out std_logic_vector(3 downto 0);
	num_valid : out std_logic;
	cmd_ok : out std_logic;
	cmd_cancel : out std_logic
);
end entity;

architecture beh of locker_decode_cmd is
	signal cmd_cnt : std_logic_vector(3 downto 0) := "0000";
begin

--	cmd_ok <= '1' when (cmd_cnt = "1011") else '0';
--	cmd_cancel <= '1' when (cmd_cnt = "1100") else '0';

	cmd_cnt_logic: process (clk, reset) is
	begin
		if(reset = '1') then
			num_value <= (others => '0');
			num_valid <= '0';
			cmd_ok <= '0';
			cmd_cancel <= '0';
			cmd_cnt <= (others => '0'); 
			
		elsif (rising_edge(clk) and signal_in = '1') then
			if(unsigned(cmd_cnt) < 12) then
				cmd_cnt <= std_logic_vector(unsigned(cmd_cnt) + 1);
				num_valid <= '0';
			else
				cmd_cnt <= "1101";
			end if;
			
		 elsif(rising_edge(clk)) then
			if(signal_in = '0' ) then
				if (cmd_cnt <= "1001" and cmd_cnt > "0000") then
					num_valid <= '1';
					num_value <= cmd_cnt;
					cmd_ok <= '0';
					cmd_cancel <= '0';
				elsif(cmd_cnt = "1010") then
					 num_value <= "0000";
					 num_valid <= '1';
					 cmd_ok <= '0';
					 cmd_cancel <= '0';
				elsif( cmd_cnt = "1011") then
					num_value <="0000";
					num_valid <= '0';
					cmd_ok <= '1';
					cmd_cancel <= '0';
				elsif (cmd_cnt = "1100") then
					cmd_cancel <= '1';
					num_value <="0000";
					num_valid <= '0';
					cmd_ok <= '0';
				else
					 num_value <="0000";
					 num_valid <= '0';
					 cmd_ok <= '0';
					 cmd_cancel <= '0';
					 
				end if;
				cmd_cnt <= (others => '0');
			end if;
    	end if;
	
	end process;
	
	

end architecture;