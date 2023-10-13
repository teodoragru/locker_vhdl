library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity locker_control is
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
end entity;

architecture beh of locker_control is
	type fsm_state_type is (open_idle, define_pass, lock_idle, guess_pass, wrong_pass);
	signal fsm_state, next_fsm_state : fsm_state_type;
	signal pass_value_cnt : std_logic_vector(1 downto 0);
	signal pass_guess_cnt : std_logic_vector(1 downto 0);
	signal pass_guess : std_logic_vector(11 downto 0);
	signal pass_value : std_logic_vector(11 downto 0);
	
begin 
	fsm_change_state: process(reset, clk) is
	begin
		if (reset = '1') then
			fsm_state <= open_idle;
		elsif (rising_edge(clk)) then
			fsm_state <= next_fsm_state;
		end if;
	end process;
	f
	fsm_change_state_logic: process(clk, fsm_state) is
	begin
	    case fsm_state is
	        when open_idle =>
	            if (cmd_ok = '1') then
	                next_fsm_state <= define_pass;
					else
						next_fsm_state <= open_idle;
	            end if;
	        when define_pass =>
	            if(cmd_cancel = '1') then
	                next_fsm_state <= open_idle;
	            elsif(cmd_ok = '1' and pass_value_cnt = "10") then
	                next_fsm_state <= lock_idle;
					else
						next_fsm_state <= define_pass;
	            end if;
	        when lock_idle =>
	            if (cmd_ok = '1') then
	                next_fsm_state <= guess_pass;
					else 
						next_fsm_state <= lock_idle;
	            end if;
	        when guess_pass =>
	            if ((cmd_ok = '1' and pass_guess_cnt = "10") and (pass_guess = pass_value)) then
	                next_fsm_state <= open_idle;
	            elsif (cmd_cancel = '1') then
	                next_fsm_state <= lock_idle;
	            elsif ((cmd_ok = '1' and pass_guess_cnt="10") and (pass_guess /= pass_value)) then
	                next_fsm_state <= wrong_pass;
					else
						next_fsm_state <= guess_pass;
	            end if;
	        when wrong_pass =>
	            next_fsm_state <= lock_idle;
	        end case;
	end process;
	
	define_pass_logic: process(reset, clk) is
    begin
        if (reset = '1') then
            pass_value <= (others => '0');
            pass_value_cnt <= "00";
        elsif (rising_edge(clk)) then
            if (fsm_state = define_pass) then
	            if  (num_valid = '1') then
	                if (pass_value_cnt < "10") then
		                pass_value_cnt <= std_logic_vector(unsigned(pass_value_cnt) + 1);
	                end if;

                    pass_value <= num_value & pass_value(11 downto 4);
	            end if;
            else
	          pass_value_cnt <= "00";
            end if;
        end if;
    end process;
    
    guess_pass_logic: process(clk, reset) is
    begin
        if(reset = '1') then
            pass_guess <= (others => '0');
            pass_guess_cnt <= "00";
        elsif (rising_edge(clk)) then
            if(fsm_state = guess_pass) then
                if(num_valid = '1') then
                    if(pass_guess_cnt < "10") then
                        pass_guess_cnt <= std_logic_vector(unsigned(pass_guess_cnt) + 1);
                    end if;
                    pass_guess <= num_value & pass_guess(11 downto 4);
                end if;
            else
                pass_guess_cnt <= "00";
            end if;
        end if;

    end process;
	
	outputs_define: process (reset, clk) is
	begin
	    if (reset = '1') then
	        error <= '0';
	        lock <= '1';
	    elsif (fsm_state = wrong_pass) then
	        error <= '1';
	    elsif(fsm_state = guess_pass and pass_value = pass_guess) then
	        lock <= '0';	
	    else
	        error <= '0';
	        lock <= '1';
	    end if;
	end process;
	
	
end architecture;