----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:27:22 12/26/2018 
-- Design Name: 
-- Module Name:    LCD - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LCD is
    Port ( 	clk 	: in  STD_LOGIC;
         	lcd_e  : out std_logic;   ----enable control
			lcd_rs : out std_logic;   ----data or command control
			alarm : out std_logic;
				step_mot   :out std_logic;
				meters  : in std_logic_vector(3 downto 0);
				gesture : in std_logic_vector(3 downto 0);
				data    : out std_logic_vector(7 downto 0);
				relay   :out std_logic_vector(1 downto 0)
				);   ---data line
end LCD;

architecture Behavioral of LCD is
  TYPE machine IS(state0,state1);
    SIGNAL state: machine:=state0;                       --state machine

constant N: integer :=122; 
type arr1 is array (1 to 35) of std_logic_vector(7 downto 0); 
type arr2 is array (1 to 35) of std_logic_vector(7 downto 0); 
type arr3 is array (1 to 30) of std_logic_vector(7 downto 0); 
type arr4 is array (1 to 29) of std_logic_vector(7 downto 0); 
type arr5 is array (1 to 24) of std_logic_vector(7 downto 0); 
type arr6 is array (1 to 27) of std_logic_vector(7 downto 0); 
constant data1 : arr1 :=    (
X"38",X"0c",X"06",X"01",X"80",--1 TO 5
X"44",X"4f",X"4e",X"27",X"54",X"20",X"54",X"4f",X"55",X"43",X"48",X"20",X"44",X"4f",X"4f",X"52",---DON'T TOUCH DOOR16   6 TO 21
X"c1",      --22
X"4b",X"45",X"45",X"50",X"20",X"44",X"49",X"53",X"54",X"41",X"4e",X"43",X"45"); ---KEEP DISTANCE13 23 TO                         35
constant data2 : arr2 :=    (
X"38",X"0c",X"06",X"01",X"80",  --37
X"55",X"53",X"45",X"20",X"48",X"41",X"4e",X"44",X"20",X"47",X"45",X"53",X"54",X"55",X"52",X"45",--USE HAND GESTURE16  38 TO 53
X"c1", --54
X"54",X"4f",X"20",X"4f",X"50",X"45",X"4e",X"2f",X"43",X"4c",X"4f",X"53",X"45"); --TO OPEN/CLOSE13 55 TO 67                       35

constant data3 : arr3 :=    (
X"38",X"0c",X"06",X"01",X"81", --5
X"47",X"45",X"53",X"54",X"55",X"52",X"45",X"20",X"52",X"49",X"47",X"48",X"54", ---13GESTURE RIGHT 13 --70 TO 82
X"c3",  --83   
X"44",X"4f",X"4f",X"52",X"20",X"4f",X"50",X"45",X"4e",X"45",X"44"); ---DOOR OPENE11 84 TO 94  11                              30

constant data4 : arr4 :=    (
X"38",X"0c",X"06",X"01",X"82",  --5
X"47",X"45",X"53",X"54",X"55",X"52",X"45",X"20",X"4c",X"45",X"46",X"54", ---GESTURE LEFT12  --97 TO 108  12
X"c3", --109  1
X"44",X"4f",X"4f",X"52",X"20",X"43",X"4c",X"4f",X"53",X"45",X"44"); ---DOOR CLOSED11  109  110 TO 120   11                   29

constant data5 : arr5 :=    (
X"38",X"0c",X"06",X"01",X"82",  --5
X"47",X"45",X"53",X"54",X"55",X"52",X"45",X"20",X"55",X"50", ---GESTURE UP110  --6 TO 15  11
X"c3", --16
X"4c",X"49",X"47",X"48",X"54",X"20",X"4f",X"4e"); ---LIGHT ON8  109  17 TO 24  9                                          --26  

constant data6 : arr6 :=    (
X"38",X"0c",X"06",X"01",X"82",  --5
X"47",X"45",X"53",X"54",X"55",X"52",X"45",X"20",X"44",X"4f",X"57",X"4e", ---GESTURE DOWN12  --6 TO 17  12
X"c3", --18
X"4c",X"49",X"47",X"48",X"54",X"20",X"4f",X"46",X"46"); ---LIGHT OFF9  19 TO 27  9                                        27
begin

process(clk)
variable i,k : integer := 0;
variable j : integer := 1;
begin
IF(clk'EVENT AND clk = '1') THEN  --rising edge of system clock
      CASE state IS                        --state machine
      
        WHEN state0 =>
          
		
          IF(meters/="0000") THEN 
            alarm<='0';
            if i <= 1000000 then
                i := i + 1;
                lcd_e <= '1';
                data <= data1(j)(7 downto 0);
                         
            elsif i > 1000000 and i < 2000000 then
                i := i + 1;
                lcd_e <= '0';
                
            elsif i = 2000000 then
                
             if j=35 then
                j := 5;                 
                else
                j := j + 1;
              end if;            
               i := 0;
            end if;  
            
            if j <= 5  then
                lcd_rs <= '0';    ---command signal
            elsif j >5 and j < 22 then
                lcd_rs <= '1';   ----data signal
            elsif j = 22 then
                lcd_rs <= '0';   ----command signal
            elsif j > 22 and j <= 35 then
                lcd_rs <= '1';   ----data signal	
            end if;	              
		
		ELSIF (meters="0000") THEN 
          if i <= 1000000 then
                i := i + 1;
                lcd_e <= '1';
                data <= data2(j)(7 downto 0);
                         
            elsif i > 1000000 and i < 2000000 then
                i := i + 1;
                lcd_e <= '0';
                
            elsif i = 2000000 then
                
                if j=35 then
                   j:=5;
                    state<=state1; 
                 else
                  j := j + 1;
                 end if;            
                i := 0;
            end if;  
            
            if j <= 5  then
                lcd_rs <= '0';    ---command signal
            elsif j >5 and j < 22 then
                lcd_rs <= '1';   ----data signal
            elsif j = 22 then
                lcd_rs <= '0';   ----command signal
            elsif j >22 and j < 36 then
                lcd_rs <= '1';   ----data signal	
            end if;	              
         END IF;   
	WHEN state1 =>
	    if (meters="0000") then
	      if (gesture/="0001"and gesture/="0010") then
	      k := k + 1;
            if k <= 3000000 then  --- Keep the buzzer output as high for 1 sec
                alarm <= '1';
            elsif k > 3000000 and k < 60000000 then  --- Keep the buzzer output low for 1 sec
                alarm <= '0';
            elsif k = 60000000 then
                k := 0;  
            end if;
                
            if i <= 1000000 then
                i := i + 1;
                lcd_e <= '1';
                data <= data2(j)(7 downto 0);
                         
            elsif i > 1000000 and i < 2000000 then
                i := i + 1;
                lcd_e <= '0';
                
           elsif i = 2000000 then
                
                if j=35 then                     
                    j:=5;
                 else
                  j := j + 1;
                 end if;            
                i := 0;
            end if;
              
            if j <= 5  then
                lcd_rs <= '0';    ---command signal
            elsif j >5 and j < 22 then
                lcd_rs <= '1';   ----data signal
            elsif j = 22 then
                lcd_rs <= '0';   ----command signal
            elsif j >22 and j < 36 then
                lcd_rs <= '1';   ----data signal	
            end if;
            	 
          ELSIF(gesture="0010") THEN 
          step_mot<='1';
          alarm<='0';
           if i <= 1000000 then
                i := i + 1;
                lcd_e <= '1';
                data <= data3(j)(7 downto 0);
                         
            elsif i > 1000000 and i < 2000000 then
                i := i + 1;
                lcd_e <= '0';
                
            elsif i = 2000000 then
                
                if j=30 then                    
                      j:=5;
                 else
                  j := j + 1;
                 end if;            
                i := 0;
            end if;
            
            if j <= 5  then
                lcd_rs <= '0';    ---command signal
            elsif j >5 and j <= 18 then
                lcd_rs <= '1';   ----data signal
            elsif j = 19 then
                lcd_rs <= '0';   ----command signal
            elsif j >19 and j <= 30 then
                lcd_rs <= '1';   ----data signal	
            end if;
		    
         ELSIF(gesture="0001") THEN
         step_mot<='0';
         alarm<='0';
           if i <= 1000000 then
                i := i + 1;
                lcd_e <= '1';
                data <= data4(j)(7 downto 0);
                         
            elsif i > 1000000 and i < 2000000 then
                i := i + 1;
                lcd_e <= '0';
                
            elsif i = 2000000 then
                
                if j=29 then                    
                      j:=5;
                 else
                  j := j + 1;
                 end if;            
                i := 0;
            end if;     
            
           if j <= 5  then
                lcd_rs <= '0';    ---command signal
            elsif j >5 and j < 18 then
                lcd_rs <= '1';   ----data signal
            elsif j = 18 then
                lcd_rs <= '0';   ----command signal
            elsif j >18 and j < 30 then
                lcd_rs <= '1';   ----data signal	
            end if;
            
          ELSIF(gesture="0011") THEN
       
         relay<="11";
           if i <= 1000000 then
                i := i + 1;
                lcd_e <= '1';
                data <= data5(j)(7 downto 0);
                         
            elsif i > 1000000 and i < 2000000 then
                i := i + 1;
                lcd_e <= '0';
                
            elsif i = 2000000 then
                
                if j=24 then                    
                      j:=5;
                 else
                  j := j + 1;
                 end if;            
                i := 0;
            end if;     
            
           if j <= 5  then
                lcd_rs <= '0';    ---command signal
            elsif j >5 and j <= 15 then
                lcd_rs <= '1';   ----data signal
            elsif j = 16 then
                lcd_rs <= '0';   ----command signal
            elsif j >16 and j <= 24 then
                lcd_rs <= '1';   ----data signal	
            end if;
            
         ELSIF(gesture="0100") THEN
      
         relay<="00";
           if i <= 1000000 then
                i := i + 1;
                lcd_e <= '1';
                data <= data6(j)(7 downto 0);
                         
            elsif i > 1000000 and i < 2000000 then
                i := i + 1;
                lcd_e <= '0';
                
            elsif i = 2000000 then
                
                if j=27 then                    
                      j:=5;
                 else
                  j := j + 1;
                 end if;            
                i := 0;
            end if;     
            
           if j <= 5  then
                lcd_rs <= '0';    ---command signal
            elsif j >5 and j <= 17 then
                lcd_rs <= '1';   ----data signal
            elsif j = 18 then
                lcd_rs <= '0';   ----command signal
            elsif j >18 and j <= 27 then
                lcd_rs <= '1';   ----data signal	
            end if;    
        end if;
           state<=state1;
		else
		   state<=state0;
		end if;    
        WHEN OTHERS =>
           state<=state0;  
          END CASE;
            END IF;
           END PROCESS;	
	          
end Behavioral;
