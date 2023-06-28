library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top_Range_Sensor is 
	port(
		-- Pino para pulso de entrada
		pulse_pin: in std_logic;
		-- Pino para saida do Trigger
		trigger_pin: out std_logic;
		 
		-- Pino do Clock FPGA
        clock: in std_logic;
        an: out std_logic_vector(2 downto 0);
        sseg: out std_logic_vector (7 downto 0);
        reset     : IN    STD_LOGIC;                                 --asynchronous active-low reset
        scl         : INOUT STD_LOGIC;                                 --I2C serial clock
        sda         : INOUT STD_LOGIC;  
        lcd_e  : out std_logic;   ----enable control
        lcd_rs : out std_logic;   ----data or command control
        alarm : out std_logic;
       	servo :out std_logic;		
        data    : out std_logic_vector(7 downto 0);
        relay   :out std_logic_vector(1 downto 0):="11"	);
end entity;

architecture Arch of Top_Range_Sensor is
component Gesture_sensor IS
  GENERIC(
    sys_clk_freq     : INTEGER := 50_000_000;                      --input clock speed from user logic in Hz                             --desired resolution of temperature data in bits
    temp_sensor_addr : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1110011"); --I2C address of the temp sensor pmod
  PORT(
    clk         : IN    STD_LOGIC;                                 --system clock
    reset_n     : IN    STD_LOGIC;                                 --asynchronous active-low reset
    scl         : INOUT STD_LOGIC;                                 --I2C serial clock
    sda         : INOUT STD_LOGIC;  
    gesture: out STD_LOGIC_VECTOR(3 DOWNTO 0):="0000"
   );  
END component;
component SERVO_MOTOR is 
PORT (
   clk: IN STD_LOGIC;
  rst:IN STD_LOGIC;
  position1: IN STD_LOGIC;
  servo:out STD_LOGIC
  );
  end component;
component Ultrasonic_sensor is
	port(
		fpgaclk, pulse: in std_logic;
		trigger_out: out std_logic;
		meters, decimeters, centimeters: out std_logic_vector(3 downto 0)
	);
end component;
component Seven_seg is port
(
  clk: in std_logic;
  Display_reset : in std_logic; -- Reset do display
  in2, in1, in0: in std_logic_vector(3 downto 0);
  an: out std_logic_vector(2 downto 0);
  sseg: out std_logic_vector (7 downto 0)
);
end component;
component LCD is
    Port ( 	clk 	: in  STD_LOGIC;
         	lcd_e  : out std_logic;   ----enable control
			lcd_rs : out std_logic;   ----data or command control
			alarm : out std_logic;
				step_mot   :out std_logic;
				meters  : in std_logic_vector(3 downto 0);
				gesture : in std_logic_vector(3 downto 0);
				data    : out std_logic_vector(7 downto 0);
				relay   :out std_logic_vector(1 downto 0)
				);    ---data line
end component;
-- Sinais para unidades de medidas
signal Ai: std_logic_vector(3 downto 0);
signal Bi: std_logic_vector(3 downto 0);
signal Ci: std_logic_vector(3 downto 0);
signal position:std_logic;

signal gesture: std_logic_vector(3 downto 0);
begin
	Ultrasonic_sensor1 : Ultrasonic_sensor port map (clock, pulse_pin, trigger_pin, Ai, Bi, Ci);
	Seven_seg1: Seven_seg port map(clock,reset, Ai, 	Bi,	 Ci,	 an ,	sseg);
	Gesture_sensor1:Gesture_sensor port map(clock,reset,scl,sda,gesture);
	LCD1: LCD port map(clock,lcd_e,lcd_rs,alarm,position,Ai,gesture,data,relay);
	SERVO_MOTOR1:SERVO_MOTOR  port map(clock,reset,position,servo);
end Arch;