

'******** METAL FIGHTER STANDARD PROGRAM ********

DIM I AS BYTE
DIM K AS BYTE
DIM J AS BYTE
DIM pose AS BYTE
DIM Action_mode AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM walk_speed AS BYTE
DIM left_right_speed AS BYTE
DIM left_right_speed2 AS BYTE
DIM walk_order AS BYTE
DIM volt_now AS BYTE
DIM inversion_check AS BYTE
DIM motor_ONOFF AS BYTE
DIM zyro_ONOFF AS BYTE
DIM tilt_front_back AS INTEGER
DIM tilt_left_right AS INTEGER
DIM DELAY_TIME AS BYTE
DIM DELAY_TIME2 AS BYTE
DIM TEMP AS BYTE
DIM thing_catch_state AS BYTE
DIM tilt_count AS BYTE
DIM fall_check AS BYTE

DIM replay_number AS BYTE
DIM tilt_measurement_check AS BYTE
DIM public_way_check AS BYTE
DIM DANCE_check AS BYTE

DIM S6 AS BYTE
DIM S7 AS BYTE
DIM S8 AS BYTE

DIM S11 AS BYTE
DIM S12 AS BYTE
DIM S13 AS BYTE
DIM S14 AS BYTE
DIM step AS BYTE


'**** tilt sensor port

CONST front_back_tilt_AD_port = 2
CONST left_right_tilt_AD_port = 3


'**** OLD tilt Sensors *****
'CONST tilt_time_check = 10
'CONST min = 100			
'CONST max = 160			
'CONST COUNT_MAX = 30

'**** 2012 NEW tilt Sensors *****
CONST tilt_time_check = 5
CONST min = 61			
CONST max = 107			
CONST COUNT_MAX = 20
'*******************

CONST low_volt = 103	'6V

PTP SETON 				
PTP ALLON				

DIR G6A,1,0,0,1,0,0		'motor_0~5
DIR G6B,1,1,1,1,1,1		'motor_6~11
DIR G6C,0,0,0,0,0,0		'motor_12~17
DIR G6D,0,1,1,0,1,0		'motor_18~23


'***** beginning announcement *********************************
motor_ONOFF = 0
walk_order = 0
inversion_check = 0
tilt_count = 0
fall_check = 0
tilt_measurement_check = 1
public_way_check = 0
thing_catch_state = 0
'****Action_mode(beginning action mode)******************
Action_mode = 0	    'D(CODE 27):dance mode
'Action_mode = 1	'F(CODE 32):fight mode
'Action_mode = 2	'G(CODE 23):game mode
'Action_mode = 3	'B(CODE 20):soccer mode
'Action_mode = 4	'E(CODE 18):hurdle mode
'Action_mode = 5	'C(CODE 17):camera mode
'Action_mode = 6	'A(CODE 15):public mode



'**** beginning position *****************************
OUT 52,0

GOSUB MOTOR_ON
PRINT "VOLUME 150 !"

SPEED 5
GOSUB power_beginning_pose
GOSUB standard_pose


GOTO MAIN
'************************************************
'************************************************

MOTOR_FAST_ON:

    MOTOR G6B
    MOTOR G6C
    MOTOR G6A
    MOTOR G6D

    motor_ONOFF = 0
    RETURN

    '************************************************
    '************************************************
MOTOR_ON:

    GOSUB MOTOR_GET

    MOTOR G6B
    DELAY 50
    MOTOR G6C
    DELAY 50
    MOTOR G6A
    DELAY 50
    MOTOR G6D

    motor_ONOFF = 0
    GOSUB start_music			
    RETURN

    '************************************************
    'all port moter use
MOTOR_OFF:

    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    motor_ONOFF = 1	
    GOSUB MOTOR_GET	
    GOSUB end_sound	
    RETURN
    '************************************************
    'position_feedback
MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,0,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
All_motor_Reset:

    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    MOTORMODE G6B,1,1,1, , ,1
    MOTORMODE G6C,1,1,1

    RETURN
    '************************************************
All_motor_mode2:

    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2, , ,2
    MOTORMODE G6C,2,2,2

    RETURN
    '************************************************
All_motor_mode3:

    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3, , ,3
    MOTORMODE G6C,3,3,3

    RETURN
    '************************************************
Leg_motor_mode1:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    RETURN
    '************************************************
Leg_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    RETURN

    '************************************************
Leg_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    RETURN
    '************************************************
Leg_motor_mode4:
    MOTORMODE G6A,3,2,2,1,3
    MOTORMODE G6D,3,2,2,1,3
    RETURN
    '************************************************
Leg_motor_mode5:
    MOTORMODE G6A,3,2,2,1,2
    MOTORMODE G6D,3,2,2,1,2
    RETURN
    '************************************************
    '************************************************
Arm_motor_mode1:
    MOTORMODE G6B,1,1,1
    MOTORMODE G6C,1,1,1
    RETURN
    '************************************************
Arm_motor_mode2:
    MOTORMODE G6B,2,2,2
    MOTORMODE G6C,2,2,2
    RETURN
    '************************************************
Arm_motor_mode3:
    MOTORMODE G6B,3,3,3
    MOTORMODE G6C,3,3,3
    RETURN

    '************************************************
    '******* standard_pose *****************************
    '************************************************
power_beginning_pose:
    MOVE G6A,95,  76, 145,  93, 105, 100
    MOVE G6D,95,  76, 145,  93, 105, 100
    MOVE G6B,100,  45,  90, 100, 100, 100
    MOVE G6C,100,  45,  90, 100, 100, 100
    WAIT
    pose = 0
    RETURN
    '************************************************
stabilization_pose:
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    pose = 0

    RETURN
    '************************************************
standard_pose:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    pose = 0
    thing_catch_state = 0
    RETURN
    '************************************************	
stand_up_pose:
    MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,100, 20, 90, 100, 100, 100
    MOVE G6C,100, 20, 90, 100, 100, 100
    WAIT
    pose = 2
    RETURN
    '************************************************
sit_pose:

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    pose = 1

    RETURN

    '************************************************
RX_EXIT:
    'GOSUB SOUND_STOP
    ERX 4800, A, MAIN

    GOTO RX_EXIT
    '************************************************
GOSUB_RX_EXIT:

    ERX 4800, A, GOSUB_RX_EXIT2

    GOTO GOSUB_RX_EXIT

GOSUB_RX_EXIT2:
    RETURN
    '************************************************
    '******* sound module ***************************
    '************************************************
SOUND_public1:
    PRINT "SOUND 48!"
    RETURN
SOUND_public2:
    PRINT "SOUND 49!"
    RETURN
SOUND_public3:
    PRINT "SOUND 50!"
    RETURN
SOUND_public4:
    PRINT "SOUND 51!"
    RETURN
SOUND_public5:
    PRINT "SOUND 52!"
    RETURN
SOUND_public6:
    PRINT "SOUND 53!"
    RETURN
SOUND_public7:
    PRINT "SOUND 54!"
    RETURN
SOUND_public8:
    PRINT "SOUND 55!"
    RETURN
SOUND_public9:
    PRINT "SOUND 56!"
    RETURN
    '************************************************
SOUND_korea_nation_gym: '
    PRINT "SOUND 47!"
    RETURN
SOUND_robolink_title_song: '
    PRINT "SOUND 46!"
    RETURN
SOUND_hello: '
    PRINT "SOUND 12!"
    RETURN
SOUND_hello_minirobot_MF: '
    PRINT "SOUND 0!"
    RETURN

    '************************************************
SOUND_MODE_SELECT:
    IF Action_mode = 0 THEN			
        GOSUB  SOUND_dance_mode
    ELSEIF Action_mode = 1 THEN		
        GOSUB SOUND_fight_mode
    ELSEIF Action_mode = 2 THEN		
        GOSUB SOUND_game_mode
    ELSEIF Action_mode = 3 THEN		
        GOSUB SOUND_soccer_mode
    ELSEIF Action_mode = 4 THEN		
        GOSUB SOUND_hurdle_mode
    ELSEIF Action_mode = 5 THEN		
        GOSUB SOUND_camera_mode
    ELSEIF Action_mode = 6 THEN		
        GOSUB SOUND_public_mode
    ENDIF

    RETURN
    '************************************************
SOUND_dance_mode:
    PRINT "SOUND 1!"
    RETURN
SOUND_fight_mode:
    PRINT "SOUND 2!"
    RETURN
SOUND_game_mode:
    PRINT "SOUND 3!"
    RETURN
SOUND_soccer_mode:
    PRINT "SOUND 4!"
    RETURN
SOUND_hurdle_mode:
    PRINT "SOUND 5!"
    RETURN
SOUND_public_mode:
    PRINT "SOUND 6!"
    RETURN
SOUND_camera_mode:
    PRINT "SOUND 7!"
    RETURN
SOUND_blue_up:
    PRINT "SOUND 26!"
    RETURN
SOUND_blue_down:
    PRINT "SOUND 27!"
    RETURN
SOUND_white_up:
    PRINT "SOUND 28!"
    RETURN
SOUND_white_down:
    PRINT "SOUND 29!"
    RETURN


SOUND_BGM1:
    PRINT "AUTO 31!"
    RETURN
SOUND_BGM2:
    PRINT "AUTO 32!"
    RETURN
SOUND_BGM3:
    PRINT "AUTO 33!"
    RETURN
SOUND_BGM4:
    PRINT "AUTO 34!"
    RETURN
SOUND_BGM5:
    PRINT "AUTO 35!"
    RETURN
SOUND_BGM6:
    PRINT "AUTO 36!"
    RETURN
SOUND_BGM7:
    PRINT "AUTO 37!"
    RETURN
SOUND_BGM8:
    PRINT "AUTO 38!"
    RETURN
SOUND_BGM9:
    PRINT "AUTO 39!"
    RETURN
SOUND_BGM10:
    PRINT "AUTO 40!"
    RETURN
SOUND_BGM11:
    PRINT "AUTO 41!"
    RETURN
SOUND_MUSIC42:
    PRINT "SOUND 42!"
    RETURN

SOUND_ALL_OFF_MSG:
    PRINT "SOUND 20!"
    DELAY 1500
    GOSUB SOUND_VOLUME_0
    RETURN

SOUND_ALL_ON_MSG:
    GOSUB SOUND_VOLUME_30
    PRINT "SOUND 21!"

    RETURN

SOUND_ON_OK_MSG:
    PRINT "SOUND 22!"
    RETURN

SOUND_scissors:
    PRINT "SOUND 23!"
    RETURN
SOUND_rock:
    PRINT "SOUND 24 !"
    RETURN
SOUND_paper:
    PRINT "SOUND 25 !"
    RETURN
SOUND_Walk_Move:
    PRINT "SOUND 45 !"
    RETURN
SOUND_Walk_Ready:
    PRINT "PLAYNUM 43 !"
    RETURN
SOUND_walk:
    PRINT "SOUND 43 !"
    RETURN
SOUND_REPLAY:
    PRINT "!"
    RETURN

SOUND_VOLUME_50:
    PRINT "VOLUME 50 !"
    RETURN

SOUND_VOLUME_40:
    PRINT "VOLUME 40 !"
    RETURN

SOUND_VOLUME_30:
    PRINT "VOLUME 30 !"
    RETURN
SOUND_VOLUME_20:
    PRINT "VOLUME 20 !"
    RETURN
SOUND_VOLUME_10:
    PRINT "VOLUME 10 !"
    RETURN

SOUND_VOLUME_0:
    PRINT "VOLUME 0 !"
    RETURN



SOUND_STOP:
    PRINT "STOP !"
    RETURN

SOUND_UP:
    PRINT "UP 5 !"
    RETURN

SOUND_DOWN:
    PRINT "DOWN 5 !"
    RETURN


    '************************************************
    '******* piezo sond *****************************
    '************************************************


start_music:
    TEMPO 220
    MUSIC "O23EAB7EA>3#C"
    RETURN
    '************************************************
end_sound:
    TEMPO 220
    MUSIC "O38GD<BGD<BG"
    RETURN
    '************************************************
entertainment_music:
    TEMPO 220
    MUSIC "O28B>4D8C4E<8B>4D<8B>4G<8E>4C"
    RETURN
    '************************************************
game_music:
    TEMPO 210
    MUSIC "O23C5G3#F5G3A5G"
    RETURN
    '************************************************
fight_music:
    TEMPO 210
    MUSIC "O15A>C<A>3D"
    RETURN
    '************************************************
caution_music:
    TEMPO 180
    MUSIC "O13A"
    DELAY 300

    RETURN
    '************************************************
beep_music:
    TEMPO 180
    MUSIC "A"
    DELAY 300

    RETURN
    '************************************************
siren_music:
    TEMPO 180
    MUSIC "O22FC"
    DELAY 10
    RETURN
    '************************************************

soccer_game_music:
    TEMPO 180
    MUSIC "O28A#GABA"
    RETURN
    '************************************************

hurdle_game_music:
    TEMPO 200
    MUSIC "O37C<C#BCA"
    RETURN
    '************************************************
    '************************************************
    '*******************************************
DANCE_STOP:

    ERX 4800,A ,DANCE_GOGO
    IF A = 26  THEN
        DANCE_check = 1
    ENDIF

DANCE_GOGO:

    RETURN
    '************************************************
    '******************************************
STOP_MAIN:
    PRINT "STOP !"
    GOSUB All_motor_mode3

    HIGHSPEED SETOFF
    SPEED 6
    MOVE G6B,, 50, 100
    MOVE G6C,, 50, 100
    WAIT
    SPEED 6
    GOSUB standard_pose
    DANCE_check = 0


    GOTO RX_EXIT
    '*******************************************
    '************************************************

back_standup:

    HIGHSPEED SETOFF
    GOSUB All_motor_Reset

    SPEED 15
    GOSUB standard_pose

    MOVE G6A,90, 130, 120,  80, 110, 100
    MOVE G6D,90, 130, 120,  80, 110, 100
    MOVE G6B,150, 160,  10, 100, 100, 100
    MOVE G6C,150, 160,  10, 100, 100, 100
    WAIT

    MOVE G6B,170, 140,  10, 100, 100, 100
    MOVE G6C,170, 140,  10, 100, 100, 100
    WAIT

    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT
    SPEED 10
    MOVE G6A, 80, 155,  85, 150, 150, 100
    MOVE G6D, 80, 155,  85, 150, 150, 100
    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT



    MOVE G6A, 75, 162,  55, 162, 155, 100
    MOVE G6D, 75, 162,  59, 162, 155, 100
    MOVE G6B,188,  10, 100, 100, 100, 100
    MOVE G6C,188,  10, 100, 100, 100, 100
    WAIT

    SPEED 10
    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B,170,  10, 100, 100, 100, 100
    MOVE G6C,170,  10, 100, 100, 100, 100
    WAIT
    GOSUB Leg_motor_mode3	
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B,150,  60,  90, 100, 100, 100
    MOVE G6C,150,  60,  90, 100, 100, 100
    WAIT

    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B,130,  50,  85, 100, 100, 100
    MOVE G6C,130,  50,  85, 100, 100, 100
    WAIT
    DELAY 100

    MOVE G6A,100, 150,  33, 140, 100, 100
    MOVE G6D,100, 150,  33, 140, 100, 100
    WAIT
    SPEED 10
    GOSUB standard_pose

    fall_check = 1
    RETURN

    '**********************************************
front_standup:

    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON

    GOSUB Arm_motor_mode1
    GOSUB Leg_motor_mode1


    SPEED 15
    MOVE G6A,100, 15,  70, 140, 100,
    MOVE G6D,100, 15,  70, 140, 100,
    MOVE G6B,20,  140,  15
    MOVE G6C,20,  140,  15
    WAIT

    SPEED 12
    MOVE G6A,100, 136,  35, 80, 100,
    MOVE G6D,100, 136,  35, 80, 100,
    MOVE G6B,20,  30,  80
    MOVE G6C,20,  30,  80
    WAIT

    SPEED 12
    MOVE G6A,100, 165,  70, 30, 100,
    MOVE G6D,100, 165,  70, 30, 100,
    MOVE G6B,30,  20,  95
    MOVE G6C,30,  20,  95
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 10
    MOVE G6A,100, 165,  45, 90, 100,
    MOVE G6D,100, 165,  45, 90, 100,
    MOVE G6B,130,  50,  60
    MOVE G6C,130,  50,  60
    WAIT

    SPEED 10
    GOSUB standard_pose
    fall_check = 1
    RETURN

    '******************************************
    '******************************************
    '************************************************
    '****** walk about ********************************
    '************************************************

front_walk_50:
    GOSUB SOUND_Walk_Ready
    walk_speed = 10'5
    left_right_speed = 5'8'3
    left_right_speed2 = 4'5'2
    fall_check = 0
    GOSUB Leg_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1

        SPEED 4
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35
        WAIT

        SPEED 10'walk_speed
        MOVE G6A, 90, 100, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT


        GOTO front_walk_50_1	
    ELSE
        walk_order = 0

        SPEED 4
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 10'walk_speed
        MOVE G6D, 90, 100, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT


        GOTO front_walk_50_2	

    ENDIF


    '*******************************


front_walk_50_1:

    SPEED walk_speed
    MOVE G6A, 85,  44, 163, 113, 114
    MOVE G6D,110,  77, 146,  93,  94
    WAIT

    GOSUB SOUND_REPLAY

    SPEED left_right_speed
    MOVE G6A,110,  76, 144, 100,  93
    MOVE G6D,85, 93, 155,  71, 112
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF


    SPEED walk_speed
    MOVE G6A,111,  77, 146,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, front_walk_50_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF

        SPEED 5
        MOVE G6A, 106,  76, 146,  93,  96		
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	


        SPEED 3
        GOSUB standard_pose
        GOSUB Leg_motor_mode1
        GOTO RX_EXIT
    ENDIF
    '**********


front_walk_50_2:


    SPEED walk_speed
    MOVE G6D,85,  44, 163, 113, 114
    MOVE G6A,110,  77, 146,  93,  94
    WAIT

    GOSUB SOUND_REPLAY

    SPEED left_right_speed
    MOVE G6D,110,  76, 144, 100,  93
    MOVE G6A, 85, 93, 155,  71, 112
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,111,  77, 146,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    ERX 4800,A, front_walk_50_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        SPEED 5
        MOVE G6D, 106,  76, 146,  93,  96		
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 3
        GOSUB standard_pose
        GOSUB Leg_motor_mode1
        GOTO RX_EXIT
    ENDIF


    GOTO front_walk_50_1
    '************************************************
    '************************************************
    '************************************************
back_walk_50:
    GOSUB SOUND_Walk_Ready
    walk_speed = 12'6
    left_right_speed = 6'3
    left_right_speed2 = 4'2
    fall_check = 0
    GOSUB Leg_motor_mode3



    IF walk_order = 0 THEN
        walk_order = 1

        SPEED 4
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35
        WAIT

        'HIGHSPEED SETON
        SPEED 10'walk_speed
        MOVE G6A, 90, 95, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT

        GOTO back_walk_50_1	
    ELSE
        walk_order = 0

        SPEED 4
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        'HIGHSPEED SETON
        SPEED 10'walk_speed
        MOVE G6D, 90, 95, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT

        GOTO back_walk_50_2

    ENDIF


back_walk_50_1:
    SPEED walk_speed
    GOSUB Leg_motor_mode2
    MOVE G6D,110,  76, 144, 100,  93
    MOVE G6A, 90, 93, 155,  71, 112
    WAIT
    GOSUB SOUND_REPLAY

    SPEED left_right_speed2
    GOSUB Leg_motor_mode3
    MOVE G6D,90,  46, 163, 110, 114
    MOVE G6A,110,  77, 147,  90,  94
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    MOVE G6A,112,  77, 147,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, back_walk_50_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        MOVE G6A, 106,  76, 146,  93,  96		
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	

        SPEED 3
        GOSUB standard_pose
        'GOSUB Leg_motor_mode1
        ' GOSUB zyro_OFF
        GOTO RX_EXIT
    ENDIF
    '**********

back_walk_50_2:
    SPEED walk_speed
    GOSUB Leg_motor_mode2
    MOVE G6A,110,  76, 144, 100,  93
    MOVE G6D,90, 93, 155,  71, 112
    WAIT
    GOSUB SOUND_REPLAY

    SPEED left_right_speed2
    GOSUB Leg_motor_mode3
    MOVE G6A, 90,  46, 163, 110, 114
    MOVE G6D,110,  77, 147,  90,  94
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,112,  76, 147,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    ERX 4800,A, back_walk_50_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        MOVE G6D, 106,  76, 146,  93,  96		
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	

        SPEED 3
        GOSUB standard_pose
        'GOSUB Leg_motor_mode1
        ' GOSUB zyro_OFF
        GOTO RX_EXIT
    ENDIF  	

    GOTO back_walk_50_1
    '**********************************************
    '******************************************
front_run_50:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 12
    HIGHSPEED SETON
    GOSUB Leg_motor_mode4

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  78, 145,  93, 98
        WAIT

        GOTO front_run_50_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  78, 145,  93, 98
        WAIT

        GOTO front_run_50_4
    ENDIF


    '**********************

front_run_50_1:
    MOVE G6A,95,  95, 100, 120, 104
    MOVE G6D,104,  78, 146,  91,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT


front_run_50_2:
    MOVE G6A,95,  75, 122, 120, 104
    MOVE G6D,104,  80, 146,  89,  100
    WAIT

    GOSUB SOUND_REPLAY

front_run_50_3:
    MOVE G6A,103,  70, 145, 103,  100
    MOVE G6D, 95, 88, 160,  68, 102
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_run_50_4
    IF A <> A_old THEN  GOTO front_run_50_stop

    '*********************************

front_run_50_4:
    MOVE G6D,95,  95, 100, 120, 104
    MOVE G6A,104,  78, 146,  91,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT


front_run_50_5:
    MOVE G6D,95,  75, 122, 120, 104
    MOVE G6A,104,  80, 146,  89,  100
    WAIT

    GOSUB SOUND_REPLAY

front_run_50_6:
    MOVE G6D,103,  70, 145, 103,  100
    MOVE G6A, 95, 88, 160,  68, 102
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_run_50_1
    IF A <> A_old THEN  GOTO front_run_50_stop


    GOTO front_run_50_1


front_run_50_stop:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB stabilization_pose
    SPEED 5
    GOSUB standard_pose

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************

    '******************************************
back_run_40:
    fall_check = 0
    SPEED 10
    GOSUB SOUND_Walk_Ready
    HIGHSPEED SETON
    GOSUB Leg_motor_mode5

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,88,  73, 145,  96, 102
        MOVE G6D,104,  73, 145,  96, 100
        WAIT

        GOTO back_run_40_1
    ELSE
        walk_order = 0
        MOVE G6D,88,  73, 145,  96, 102
        MOVE G6A,104,  73, 145,  96, 100
        WAIT


        GOTO back_run_40_4
    ENDIF


    '**********************

back_run_40_1:
    'SPEED 10
    MOVE G6A,92,  92, 100, 115, 104
    MOVE G6D,103,  74, 145,  96,  100
    MOVE G6B, 120
    MOVE G6C,80
    'WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

back_run_40_2:
    'SPEED 10
    MOVE G6A,95,  100, 122, 95, 104
    MOVE G6D,103,  70, 145,  102,  100
    'WAIT

back_run_40_3:
    'SPEED 10
    MOVE G6A,103,  90, 145, 80, 100
    MOVE G6D,92,  64, 145,  108,  102
    'WAIT
    GOSUB SOUND_REPLAY



    ERX 4800,A, back_run_40_4
    IF A <> A_old THEN  GOTO back_run_40_stop
    '*********************************

back_run_40_4:
    'SPEED 10
    MOVE G6D,92,  92, 100, 115, 104
    MOVE G6A,103,  74, 145,  96,  100
    MOVE G6C, 120
    MOVE G6B,80
    'WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

back_run_40_5:

    MOVE G6D,95,  100, 122, 95, 104
    MOVE G6A,103,  70, 145,  102,  100


back_run_40_6:

    MOVE G6D,103,  90, 145, 80, 100
    MOVE G6A,92,  64, 145,  108,  102
    ' WAIT
    GOSUB SOUND_REPLAY

    ERX 4800,A, back_run_40_1
    IF A <> A_old THEN  GOTO back_run_40_stop

    GOTO  back_run_40_1 	

back_run_40_stop:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB stabilization_pose
    SPEED 5
    GOSUB standard_pose

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************

    '******************************************
stabilization_stop:
    HIGHSPEED SETOFF
    SPEED 10
    GOSUB stabilization_pose
    SPEED 15
    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    RETURN

    '******************************************
    '**********************************************

    '******************************************
front_short_steps:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO front_short_steps_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO front_short_steps_4
    ENDIF


    '**********************

front_short_steps_1:
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6B, 80
    MOVE G6C,120
    WAIT


front_short_steps_2:
    MOVE G6A,95,  85, 130, 103, 104
    MOVE G6D,104,  79, 146,  89,  100
    WAIT

front_short_steps_3:
    MOVE G6A,103,   85, 130, 103,  100
    MOVE G6D, 95,  79, 146,  89, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_short_steps_4
    IF A <> A_old THEN  GOTO front_short_steps_stop

    '*********************************

front_short_steps_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6C, 80
    MOVE G6B,120
    WAIT


front_short_steps_5:
    MOVE G6D,95,  85, 130, 103, 104
    MOVE G6A,104,  79, 146,  89,  100
    WAIT

front_short_steps_6:
    MOVE G6D,103,   85, 130, 103,  100
    MOVE G6A, 95,  79, 146,  89, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, front_short_steps_1
    IF A <> A_old THEN  GOTO front_short_steps_stop


    GOTO front_short_steps_1


front_short_steps_stop:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB stabilization_pose
    SPEED 10
    GOSUB standard_pose

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '******************************************
back_short_steps:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO back_short_steps_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO back_short_steps_4
    ENDIF


    '**********************

back_short_steps_1:
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT


back_short_steps_2:
    MOVE G6A,95,  90, 135, 90, 104
    MOVE G6D,104,  77, 146,  91,  100
    WAIT

back_short_steps_3:
    MOVE G6A, 103,  79, 146,  89, 100
    MOVE G6D,95,   65, 146, 103,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, back_short_steps_4
    IF A <> A_old THEN  GOTO back_short_steps_stop

    '*********************************

back_short_steps_4:
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT


back_short_steps_5:
    MOVE G6A,104,  77, 146,  91,  100
    MOVE G6D,95,  90, 135, 90, 104
    WAIT

back_short_steps_6:
    MOVE G6D, 103,  79, 146,  89, 100
    MOVE G6A,95,   65, 146, 103,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, back_short_steps_1
    IF A <> A_old THEN  GOTO back_short_steps_stop


    GOTO back_short_steps_1


back_short_steps_stop:
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB stabilization_pose
    SPEED 10
    GOSUB standard_pose

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '**********************************************

front_run_30: 'walk short
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 12
    HIGHSPEED SETON

    IF walk_order = 0 THEN
        MOVE G6A,100,  80, 119, 118, 103
        MOVE G6D,102,  75, 149,  93,  100
        MOVE G6B, 80,  30,  80
        MOVE G6C,120,  30,  80

        walk_order = 1
        GOTO front_run_30_2
    ELSE
        MOVE G6D,100,  80, 119, 118, 103
        MOVE G6A,102,  75, 149,  93,  100
        MOVE G6C, 80,  30,  80
        MOVE G6B,120,  30,  80

        walk_order = 0
        GOTO front_run_30_4

    ENDIF



    '********************************************
front_run_30_1:

    MOVE G6A,100,  80, 119, 118, 103
    MOVE G6D,102,  75, 147,  93,  100
    MOVE G6B, 80,  30,  80
    MOVE G6C,120,  30,  80
    GOSUB SOUND_REPLAY

    ERX 4800, A, front_run_30_2
    GOSUB standard_pose
    HIGHSPEED SETOFF
    GOTO RX_EXIT

front_run_30_2:

    MOVE G6A,102,  74, 140, 106,  100
    MOVE G6D, 95, 105, 124,  93, 103
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

front_run_30_3:
    MOVE G6D,100,  80, 119, 118, 103
    MOVE G6A,102,  75, 147,  93,  100
    MOVE G6C, 80,  30,  80
    MOVE G6B,120,  30,  80
    GOSUB SOUND_REPLAY



    ERX 4800, A, front_run_30_4
    GOSUB standard_pose
    HIGHSPEED SETOFF
    GOTO RX_EXIT

front_run_30_4:
    MOVE G6D,102,  74, 140, 106,  100
    MOVE G6A, 95, 105, 124,  93, 103
    MOVE G6C,100,  30,  80
    MOVE G6B,100,  30,  80

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    '************************************************


    GOTO front_run_30_1


    GOTO RX_EXIT

    '*********************************************
    '******************************************
chack_run:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 15
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  85, 101
        MOVE G6D,101,  77, 145,  85, 98
        WAIT

        GOTO chack_run_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  85, 101
        MOVE G6A,101,  77, 145,  85, 98
        WAIT

        GOTO chack_run_4
    ENDIF


    '**********************

chack_run_1:
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6D,104,  77, 145,  87,  102
    WAIT
    DELAY 5

chack_run_2:
    MOVE G6D,104,  79, 145,  82,  100
    MOVE G6A,95,  85, 130, 95, 104
    WAIT
    DELAY 5
chack_run_3:
    MOVE G6A,103,   85, 130, 95,  100
    MOVE G6D, 97,  79, 145,  82, 102
    WAIT
    DELAY 5
    GOSUB SOUND_REPLAY
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, chack_run_4
    IF A <> A_old THEN  GOTO chack_run_stop

    '*********************************

chack_run_4:
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6A,104,  77, 145,  87,  102
    WAIT


chack_run_5:
    MOVE G6D,95,  85, 130, 95, 104
    MOVE G6A,104,  79, 145,  82,  100
    WAIT

chack_run_6:
    MOVE G6D,103,   85, 130, 95,  100
    MOVE G6A, 97,  79, 145,  82, 102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, chack_run_1
    IF A <> A_old THEN  GOTO chack_run_stop


    GOTO chack_run_1


chack_run_stop:
    HIGHSPEED SETOFF
    SPEED 15
    MOVE G6A,98,  76, 145,  85, 101, 100
    MOVE G6D,98,  76, 145,  85, 101, 100
    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    DELAY 400

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '******************************************
chack_back_run:
    fall_check = 0
    GOSUB SOUND_Walk_Ready
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1
        MOVE G6A,95,  76, 145,  85, 101
        MOVE G6D,101,  77, 145,  85, 98
        WAIT

        GOTO chack_back_run_1
    ELSE
        walk_order = 0
        MOVE G6D,95,  76, 145,  85, 101
        MOVE G6A,101,  77, 145,  85, 98
        WAIT

        GOTO chack_back_run_4
    ENDIF


    '**********************

chack_back_run_1:
    MOVE G6D,104,  77, 146,  83,  102
    MOVE G6A,95,  95, 120, 92, 104
    WAIT


chack_back_run_2:
    MOVE G6A,95,  90, 135, 82, 104
    MOVE G6D,104,  77, 146,  83,  100
    WAIT

chack_back_run_3:
    MOVE G6A, 103,  79, 146,  81, 100
    MOVE G6D,95,   65, 146, 95,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, chack_back_run_4
    IF A <> A_old THEN  GOTO chack_back_run_stop

    '*********************************

chack_back_run_4:
    MOVE G6D,95,  95, 120, 92, 104
    MOVE G6A,104,  77, 146,  83,  102
    WAIT


chack_back_run_5:
    MOVE G6A,104,  77, 146,  83,  100
    MOVE G6D,95,  90, 135, 82, 104
    WAIT

chack_back_run_6:
    MOVE G6D, 103,  79, 146,  81, 100
    MOVE G6A,95,   65, 146, 95,  102
    WAIT
    GOSUB SOUND_REPLAY
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    ERX 4800,A, chack_back_run_1
    IF A <> A_old THEN  GOTO chack_back_run_stop


    GOTO chack_back_run_1


chack_back_run_stop:
    HIGHSPEED SETOFF
    SPEED 15
    MOVE G6A,98,  76, 145,  85, 101, 100
    MOVE G6D,98,  76, 145,  85, 101, 100
    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    DELAY 400


    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '******************************************
    '*********************************************	
front_sit_walk:
    GOSUB All_motor_mode3
    SPEED 9

front_sit_walk_1:

    MOVE G6A,114, 143,  28, 142,  96, 100
    MOVE G6D, 87, 135,  28, 155, 110, 100
    WAIT


    MOVE G6D,98, 126,  28, 160, 102, 100
    MOVE G6A,98, 160,  28, 125, 102, 100
    WAIT

    ERX 4800, A, front_sit_walk_2
    SPEED 6
    IF  thing_catch_state = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT

front_sit_walk_2:
    MOVE G6D,113, 143,  28, 142,  96, 100
    MOVE G6A, 87, 135,  28, 155, 110, 100
    WAIT

    MOVE G6A,98, 126,  28, 160, 102, 100
    MOVE G6D,98, 160,  28, 125, 102, 100
    WAIT

    ERX 4800, A, front_sit_walk_1
    SPEED 6
    IF  thing_catch_state = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT


    GOTO front_sit_walk_1
    '*****************************
back_sit_walk:
    GOSUB All_motor_mode3
    SPEED 8

back_sit_walk_1:

    MOVE G6D,113, 140,  28, 142,  96, 100
    MOVE G6A, 87, 140,  28, 140, 110, 100
    WAIT

    MOVE G6A,98, 155,  28, 125, 102, 100
    MOVE G6D,98, 121,  28, 160, 102, 100
    WAIT

    ERX 4800, A, back_sit_walk_2
    SPEED 6
    IF  thing_catch_state = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT

back_sit_walk_2:
    MOVE G6A,113, 140,  28, 142,  96, 100
    MOVE G6D, 87, 140,  28, 140, 110, 100
    WAIT


    MOVE G6D,98, 155,  28, 125, 102, 100
    MOVE G6A,98, 121,  28, 160, 102, 100
    WAIT

    ERX 4800, A, back_sit_walk_1
    SPEED 6
    IF  thing_catch_state = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT


    GOTO back_sit_walk_1
    '*****************************		

sit_right_walk:
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,110, 145,  28, 140, 100, 100
    MOVE G6D, 86, 145,  28, 140, 105, 100
    WAIT

    SPEED 5
    MOVE G6A, 90, 145,  28, 140, 110, 100
    MOVE G6D, 90, 145,  28, 140, 110, 100
    WAIT

    SPEED 6 	
    MOVE G6A, 80, 135,  45, 135, 105, 100
    MOVE G6D,108, 145,  28, 140, 100, 100
    WAIT

    SPEED 4 		
    MOVE G6A, 90, 145,  28, 140, 100, 100
    MOVE G6D,106, 145,  28, 140, 100, 100
    WAIT

    SPEED 3
    IF  thing_catch_state = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT
    '*****************************	
sit_left_walk:
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6D,110, 145,  28, 140, 100, 100
    MOVE G6A, 86, 145,  28, 140, 105, 100
    WAIT

    SPEED 5
    MOVE G6D, 90, 145,  28, 140, 110, 100
    MOVE G6A, 90, 145,  28, 140, 110, 100
    WAIT

    SPEED 6 	
    MOVE G6D, 80, 135,  45, 135, 105, 100
    MOVE G6A,108, 145,  28, 140, 100, 100
    WAIT

    SPEED 4 		
    MOVE G6D, 90, 145,  28, 140, 100, 100
    MOVE G6A,106, 145,  28, 140, 100, 100
    WAIT

    SPEED 3
    IF  thing_catch_state = 0 THEN
        GOSUB sit_pose
    ELSE
        MOVE G6A,100, 140,  28, 142, 100, 100
        MOVE G6D,100, 140,  28, 142, 100, 100
        WAIT
        pose = 1
    ENDIF
    GOSUB All_motor_Reset
    GOTO RX_EXIT
    '**********************************************
    '************************************************
paper_delivery:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6B,188,  15,  80
    MOVE G6C,188,  15,  80
    WAIT


    GOSUB All_motor_Reset
    thing_catch_state = 3
    RETURN
    '************************************************
    '************************************************
paper_lift:
    GOSUB All_motor_mode3
    SPEED 3
    MOVE G6A,100,  73, 145,  85, 100
    MOVE G6D,100,  73, 145,  85, 100
    MOVE G6B,165,  30,  80
    MOVE G6C,165,  30,  80
    WAIT


    DELAY 2000
    '**** catch space *******************************
    MOVE G6B,165,  15,  80
    MOVE G6C,165,  15,  80
    WAIT

    GOSUB All_motor_Reset
    thing_catch_state = 2
    RETURN
    '************************************************
    '**********************************************

paper_lift_front_walk_50:
    fall_check = 0
    walk_speed = 10
    left_right_speed = 3
    left_right_speed2 = 4

    GOSUB Leg_motor_mode3
    SPEED 3
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    IF walk_order = 0 THEN
        walk_order = 1

        SPEED 3
        MOVE G6A, 88,  68, 152,  83, 110
        MOVE G6D,108,  73, 146,  85,  94
        WAIT

        SPEED 10'walk_speed
        MOVE G6A, 90, 97, 115, 98, 114
        MOVE G6D,112,  75, 146,  85,  94
        WAIT


        GOTO paper_lift_front_walk_50_1	
    ELSE
        walk_order = 0

        SPEED 3
        MOVE G6D,  88,  68, 152,  83, 110
        MOVE G6A, 108,  73, 146,  85,  94
        WAIT

        SPEED 10'walk_speed
        MOVE G6D, 90, 97, 115, 98, 114
        MOVE G6A,112,  75, 146,  85,  94
        WAIT


        GOTO paper_lift_front_walk_50_2	

    ENDIF


    '*******************************


paper_lift_front_walk_50_1:

    SPEED walk_speed
    MOVE G6A, 90,  41, 163, 105, 114
    MOVE G6D,110,  74, 146,  85,  94
    WAIT

    SPEED left_right_speed
    GOSUB Leg_motor_mode3
    MOVE G6A,110,  73, 144, 92,  93
    MOVE G6D,90, 90, 155,  63, 112
    WAIT


    SPEED walk_speed
    GOSUB Leg_motor_mode2
    MOVE G6A,111,  74, 146,  85, 94
    MOVE G6D,90, 97, 105, 102, 114
    WAIT
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF
    ERX 4800,A, paper_lift_front_walk_50_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        MOVE G6A, 106,  73, 146,  85,  96		
        MOVE G6D,  88,  68, 152,  82, 106
        WAIT	


        SPEED 3
        MOVE G6A,100,  73, 145,  85, 100, 100
        MOVE G6D,100,  73, 145,  85, 100, 100
        WAIT
        GOSUB Leg_motor_mode1
        ' GOSUB zyro_OFF
        GOTO RX_EXIT
    ENDIF
    '**********


paper_lift_front_walk_50_2:


    SPEED walk_speed
    MOVE G6D,90,  41, 163, 105, 114
    MOVE G6A,110,  74, 146,  85,  94
    WAIT

    SPEED left_right_speed
    GOSUB Leg_motor_mode3
    MOVE G6D,110,  73, 144, 92,  93
    MOVE G6A, 90, 90, 155,  63, 112
    WAIT

    SPEED walk_speed
    GOSUB Leg_motor_mode2
    MOVE G6A, 90, 97, 105, 102, 114
    MOVE G6D,111,  74, 146,  85,  94
    WAIT
    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF
    ERX 4800,A, paper_lift_front_walk_50_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        MOVE G6D, 106,  73, 146,  85,  96		
        MOVE G6A,  88,  68, 152,  82, 106
        WAIT

        SPEED 3
        MOVE G6A,100,  73, 145,  85, 100, 100
        MOVE G6D,100,  73, 145,  85, 100, 100
        WAIT
        GOSUB Leg_motor_mode1
        ' GOSUB zyro_OFF
        GOTO RX_EXIT
    ENDIF


    GOTO paper_lift_front_walk_50_1
    '************************************************
    '******************************************
standstill:
    fall_check = 0
    GOSUB Arm_motor_mode3
    'GOSUB Leg_motor_mode3
    MOTORMODE G6A,2,3,3,3,2
    MOTORMODE G6D,2,3,3,3,2

    MOVE G6B,,35
    MOVE G6C,,35
    WAIT

standstill_1:

    SPEED 4
    MOVE G6A,105,  76, 146,  93, 98, 100
    MOVE G6D,85,  73, 151,  90, 108, 100
    WAIT

    SPEED 12
    MOVE G6A,113,  76, 146,  93, 96, 100
    MOVE G6D,90,  100, 95,  120, 115, 100
    MOVE G6B,120
    MOVE G6C,80
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        RETURN
    ENDIF

    SPEED 10
    MOVE G6A,109,  76, 146,  93, 97, 100
    MOVE G6D,90,  76, 148,  92, 110, 100
    WAIT



    SPEED 4	
    MOVE G6A,98,  76, 146,  93, 100, 100
    MOVE G6D,98,  76, 146,  93, 100, 100	
    WAIT

    ERX 4800,A, standstill_2
    IF A <> A_old THEN
        SPEED 5
        GOSUB standard_pose
        GOSUB Leg_motor_mode1
        RETURN
    ENDIF

standstill_2:
    '***********************************
    SPEED 4
    MOVE G6D,105,  76, 146,  93, 98, 100
    MOVE G6A,85,  73, 151,  90, 108, 100
    WAIT	

    SPEED 12
    MOVE G6D,113,  76, 146,  93, 96, 100
    MOVE G6A,90,  100, 95,  120, 115, 100
    MOVE G6C,120
    MOVE G6B,80
    WAIT	



    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        RETURN
    ENDIF

    SPEED 10
    MOVE G6D,109,  76, 146,  93, 97, 100
    MOVE G6A,90,  76, 148,  92, 110, 100
    WAIT	

    SPEED 4		
    MOVE G6D,98,  76, 146,  93, 100, 100
    MOVE G6A,98,  76, 146,  93, 100, 100	
    WAIT	

    ERX 4800,A, standstill_1
    IF A <> A_old THEN
        SPEED 5
        GOSUB standard_pose
        GOSUB Leg_motor_mode1
        RETURN
    ENDIF

    GOTO standstill_1


    RETURN
    '**********************************************	
    '**********************************************	
    '**********************************************	
    '************************************************
right_side_20:

    GOSUB SOUND_Walk_Move
    SPEED 12
    MOVE G6D, 93,  90, 120, 105, 104, 100
    MOVE G6A,103,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 93, 100, 100
    MOVE G6A,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 15
    MOVE G6D,98,  76, 145,  93, 100, 100
    MOVE G6A,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 8

    GOSUB standard_pose

    GOTO RX_EXIT
    '**********************************************

left_side_20:

    GOSUB SOUND_Walk_Move
    SPEED 12
    MOVE G6A, 93,  90, 120, 105, 104, 100
    MOVE G6D,103,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 93, 100, 100
    MOVE G6D,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 15
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 8

    GOSUB standard_pose
    GOTO RX_EXIT

    '**********************************************

right_side_70:
    GOSUB SOUND_Walk_Move
    SPEED 10
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 146,  93, 107, 100
    MOVE G6B,100,  40
    MOVE G6C,100,  40
    WAIT

    SPEED 12
    MOVE G6D, 102,  76, 147, 93, 100, 100
    MOVE G6A,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 10
    MOVE G6D,98,  76, 146,  93, 100, 100
    MOVE G6A,98,  76, 146,  93, 100, 100
    WAIT

    SPEED 15
    GOSUB standard_pose

    GOTO RX_EXIT
    '*************

left_side_70:
    GOSUB SOUND_Walk_Move

    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100	
    MOVE G6D,100,  76, 146,  93, 107, 100	
    MOVE G6B,100,  40
    MOVE G6C,100,  40
    WAIT

    SPEED 12
    MOVE G6A, 102,  76, 147, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 10
    MOVE G6A,98,  76, 146,  93, 100, 100
    MOVE G6D,98,  76, 146,  93, 100, 100
    WAIT

    SPEED 15	
    GOSUB standard_pose

    GOTO RX_EXIT
    '************************************************

catch_right_side_20:


    SPEED 12
    MOVE G6D, 93,  90, 120, 97, 104, 100
    MOVE G6A,103,  76, 145,  85, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 85, 100, 100
    MOVE G6A,90,  80, 140,  87, 107, 100
    WAIT

    SPEED 15
    MOVE G6D,98,  76, 145,  85, 100, 100
    MOVE G6A,98,  76, 145,  85, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '**********************************************

catch_left_side_20:


    SPEED 12
    MOVE G6A, 93,  90, 120, 97, 104, 100
    MOVE G6D,103,  76, 145,  85, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 85, 100, 100
    MOVE G6D,90,  80, 140,  87, 107, 100
    WAIT

    SPEED 15
    MOVE G6A,98,  76, 145,  85, 100, 100
    MOVE G6D,98,  76, 145,  85, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '**********************************************

catch_right_side_70:
    GOSUB SOUND_Walk_Move
    SPEED 10
    MOVE G6D, 90,  90, 120, 92, 110, 100
    MOVE G6A,100,  76, 146,  85, 107, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  76, 147, 85, 100, 100
    MOVE G6A,83,  76, 140,  92, 115, 100
    WAIT

    SPEED 10
    MOVE G6D,98,  76, 146,  85, 100, 100
    MOVE G6A,98,  76, 146,  85, 100, 100
    WAIT

    SPEED 15
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '*************

catch_left_side_70:
    GOSUB SOUND_Walk_Move

    SPEED 10
    MOVE G6A, 90,  90, 120, 97, 110, 100	
    MOVE G6D,100,  76, 146,  85, 107, 100	
    WAIT

    SPEED 12
    MOVE G6A, 102,  76, 147, 85, 100, 100
    MOVE G6D,83,  76, 140,  92, 115, 100
    WAIT

    SPEED 10
    MOVE G6A,98,  76, 146,  85, 100, 100
    MOVE G6D,98,  76, 146,  85, 100, 100
    WAIT

    SPEED 15	
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOTO RX_EXIT
    '************************************************
slow_left_side_50:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT


    SPEED 5
    MOVE G6D,110,  92, 124,  97,  93,  100
    MOVE G6A, 76,  72, 160,  82, 128,  100
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT

    SPEED 5
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT	
    '***********************
    SPEED 5
    MOVE G6A,110,  92, 124,  97,  93,  100
    MOVE G6D, 76,  72, 160,  82, 120,  100
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT

    SPEED 6
    MOVE G6D, 85,  80, 140, 95, 110, 100
    MOVE G6A,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110, '60
    MOVE G6A,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 2
    GOSUB standard_pose
    GOSUB All_motor_Reset	
    RETURN

    '**********************************************
    '************************************************
slow_right_side_50:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6D, 88,  71, 152,  91, 110, '60
    MOVE G6A,108,  76, 146,  93,  92, '60
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6D, 85,  80, 140, 95, 114, 100
    MOVE G6A,112,  76, 146,  93, 98, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT


    SPEED 5
    MOVE G6A,110,  92, 124,  97,  93,  100
    MOVE G6D, 76,  72, 160,  82, 128,  100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT

    SPEED 5
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT	
    '***********************
    SPEED 5
    MOVE G6D,110,  92, 124,  97,  93,  100
    MOVE G6A, 76,  72, 160,  82, 120,  100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT

    SPEED 6
    MOVE G6A, 85,  80, 140, 95, 110, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6C,100,  40,  80
    MOVE G6B,100,  40,  80
    WAIT

    SPEED 2
    GOSUB standard_pose
    GOSUB All_motor_Reset	
    RETURN

    '**********************************************

    '**********************************************
left_turn_50:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  86, 145,  83, 103, 100
    MOVE G6D,97,  66, 145,  103, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  83, 101, 100
    MOVE G6D,94,  66, 145,  103, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB standard_pose
    GOTO RX_EXIT
    '**********************************************
right_turn_50:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  66, 145,  103, 103, 100
    MOVE G6D,97,  86, 145,  83, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  103, 101, 100
    MOVE G6D,94,  86, 145,  83, 101, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB standard_pose

    GOTO RX_EXIT
    '**********************************************
    '**********************************************
left_turn_20:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
right_turn_20:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
left_turn_45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  106, 145,  63, 105, 100
    MOVE G6D,95,  46, 145,  123, 105, 100
    MOVE G6B,115
    MOVE G6C,85
    WAIT

    SPEED 10
    MOVE G6A,93,  106, 145,  63, 105, 100
    MOVE G6D,93,  46, 145,  123, 105, 100
    WAIT

    SPEED 8
    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '**********************************************
right_turn_45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    MOVE G6C,115
    MOVE G6B,85
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    GOSUB standard_pose
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
left_turn_60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  116, 145,  53, 105, 100
    MOVE G6D,95,  36, 145,  133, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  53, 105, 100
    MOVE G6D,90,  36, 145,  133, 105, 100
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT

    '**********************************************
right_turn_60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  36, 145,  133, 105, 100
    MOVE G6D,95,  116, 145,  53, 105, 100

    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  133, 105, 100
    MOVE G6D,90,  116, 145,  53, 105, 100

    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT

    '************************************************
    '**********************************************
catch_left_turn_50:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  86, 145,  75, 103, 100
    MOVE G6D,97,  66, 145,  95, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  75, 101, 100
    MOVE G6D,94,  66, 145,  95, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT
    '**********************************************
catch_right_turn_50:
    GOSUB SOUND_Walk_Move
    SPEED 5
    MOVE G6A,97,  66, 145,  95, 103, 100
    MOVE G6D,97,  86, 145,  75, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  95, 101, 100
    MOVE G6D,94,  86, 145,  75, 101, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT
    '**********************************************
    '**********************************************
catch_left_turn_20:

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  96, 145,  65, 105, 100
    MOVE G6D,95,  56, 145,  105, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  65, 105, 100
    MOVE G6D,93,  56, 145,  105, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
catch_right_turn_20:

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  56, 145,  105, 105, 100
    MOVE G6D,95,  96, 145,  65, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  105, 105, 100
    MOVE G6D,93,  96, 145,  65, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
catch_left_turn_45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  106, 145,  55, 105, 100
    MOVE G6D,95,  46, 145,  115, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  106, 145,  55, 105, 100
    MOVE G6D,93,  46, 145,  115, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '**********************************************
catch_right_turn_45:
    GOSUB SOUND_Walk_Move
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  46, 145,  115, 105, 100
    MOVE G6D,95,  106, 145,  55, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  115, 105, 100
    MOVE G6D,93,  106, 145,  55, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
catch_left_turn_60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  116, 145,  45, 105, 100
    MOVE G6D,95,  36, 145,  125, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  45, 105, 100
    MOVE G6D,90,  36, 145,  125, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '**********************************************
catch_right_turn_60:
    GOSUB SOUND_Walk_Move
    SPEED 15
    MOVE G6A,95,  36, 145,  125, 105, 100
    MOVE G6D,95,  116, 145,  45, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  125, 105, 100
    MOVE G6D,90,  116, 145,  45, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '************************************************
    '******* etc. motion  ****************************
    '************************************************

bow1:
    GOSUB SOUND_hello_minirobot_MF
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,100,  70, 125, 150, 100
    MOVE G6D,100,  70, 125, 150, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    DELAY 1000
    SPEED 6
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    '************************************************
bow2:
    GOSUB All_motor_mode3
    SPEED 4
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6B,110,  30,  80
    MOVE G6C,90,  30,  80
    WAIT

    SPEED 8
    MOVE G6D, 90, 95, 115, 105, 112
    MOVE G6A,113,  76, 146,  93,  94
    MOVE G6B,130,  30,  80
    MOVE G6C,75,  30,  80
    WAIT

    SPEED 8
    MOVE G6A,112,  86, 120, 120,  94
    MOVE G6D,90, 100, 155,  71, 112
    MOVE G6B,140,  30,  80
    MOVE G6C,70,  30,  80
    WAIT


    SPEED 10
    MOVE G6A,108,  85, 110, 140,  94
    MOVE G6D,85, 97, 145,  91, 112
    MOVE G6B,150,  20,  40
    MOVE G6C,60,  30,  80
    WAIT

    DELAY 1000
    '*******************
    GOSUB leg_motor_mode2
    SPEED 6
    MOVE G6D, 90, 95, 115, 105, 110
    MOVE G6A,114,  76, 146,  93,  96
    MOVE G6B,130,  30,  80
    MOVE G6C,75,  30,  80
    WAIT

    SPEED 8
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6B,110,  30,  80
    MOVE G6C,90,  30,  80
    WAIT

    SPEED 3
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    '************************************************


bow3:
    GOSUB All_motor_mode3

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  35,  80
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    'bow
    SPEED 8
    MOVE G6A,100,  55, 145,  145, 100, 100
    MOVE G6D,100,  55, 145,  145, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    DELAY 1000

    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOSUB All_motor_Reset


    RETURN
    '************************************************


cheer:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode2
    SPEED 15
    MOVE G6A,100,  80, 145,  75, 100
    MOVE G6D,100,  80, 145,  75, 100
    MOVE G6B,100,  180,  120
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 2

        MOVE G6B,100,  145,  100
        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6B,100,  180,  130
        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
win_ceremony1:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode2
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  180,  120
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 3

        MOVE G6B,100,  145,  100
        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6B,100,  180,  130
        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
win_ceremony2:
    SPEED 10
    GOSUB standard_pose
    GOSUB All_motor_mode3

    SPEED 8

    MOVE G6A, 100, 163,  75,  15, 100
    MOVE G6D, 100, 163,  75,  15, 100
    MOVE G6B,185, 100, 90
    MOVE G6C,185, 100, 90
    WAIT

    SPEED 2

    MOVE G6A, 100, 165,  70,  10, 100, 100
    MOVE G6D, 100, 165,  70,  10, 100, 100
    MOVE G6B,185, 100, 90
    MOVE G6C,185, 100, 90
    WAIT

    DELAY 400
    SPEED 15
    FOR I = 1 TO 5

        MOVE G6B,185, 20, 50
        MOVE G6C,185, 20, 50
        WAIT

        MOVE G6B,185, 70, 80
        MOVE G6C,185, 70, 80
        WAIT

    NEXT I

    MOVE G6B,100, 70, 80
    MOVE G6C,100, 70, 80
    WAIT

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A, 100, 145,  70,  80, 100, 100
    MOVE G6D, 100, 145,  70,  80, 100, 100
    MOVE G6B,100, 40, 90
    MOVE G6C,100, 40, 90
    WAIT

    SPEED 8
    MOVE G6A,100, 121,  80, 110, 101, 100
    MOVE G6D,100, 121,  80, 110, 101, 100
    MOVE G6B,100,  40,  80, , ,
    MOVE G6C,100,  40,  80, , ,
    WAIT

    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
    ''************************************************
win_ceremony3:
    GOSUB All_motor_mode3
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 4

        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN
    ''************************************************

loser_action1:

    GOSUB Leg_motor_mode3

    SPEED 10
    MOVE G6A,100, 140,  37, 140, 100, 100
    MOVE G6D,100, 140,  37, 140, 100, 100
    WAIT

    SPEED 3
    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    SPEED 8
    MOVE G6B,140
    MOVE G6C,140
    WAIT
    SPEED 4
    MOVE G6A,70, 163,  28, 160, 135
    MOVE G6D,70, 163,  28, 160, 135
    MOVE G6B,160,  15,  90
    MOVE G6C,185,  20,  85
    WAIT

    DELAY 400
    SPEED 10
    FOR i = 1 TO 8
        MOVE G6C,165,  20,  85
        WAIT
        MOVE G6C,188,  20,  85
        WAIT  	
    NEXT i
    DELAY 500

    GOSUB Leg_motor_mode3

    SPEED 10	
    MOVE G6A,  70, 165,  28, 162, 135
    MOVE G6D,  70, 165,  28, 162, 135
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    SPEED 6	
    MOVE G6A,  70, 145,  28, 142, 130
    MOVE G6D,  70, 145,  28, 142, 130
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    SPEED 10	
    MOVE G6A,  100, 145,  27, 142, 100
    MOVE G6D,  100, 145,  27, 142, 100
    MOVE G6B,  140, 15, 90
    MOVE G6C,  140, 15, 90
    WAIT

    SPEED 6
    MOVE G6A,  100, 138,  28, 155, 100
    MOVE G6D,  100, 138,  28, 155, 100
    MOVE G6B, 113,  30, 80
    MOVE G6C, 113,  30, 80
    WAIT

    GOSUB Leg_motor_mode2
    SPEED 8
    GOSUB standard_pose

    RETURN

    ''************************************************
loser_action2:
    GOSUB Arm_motor_mode3
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  185,  170
    WAIT	

    SPEED 4
    FOR i = 1 TO 8
        MOVE G6C,100,  170,  185
        WAIT

        MOVE G6C,100,  185,  170
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN
    ''************************************************
    ''************************************************
hug:
    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6B,100,  60,  80
    MOVE G6C,160,  50,  80
    WAIT

    SPEED 15
    MOVE G6A, 85,  76, 145, 94, 110
    MOVE G6D,108,  81, 135,  98, 98
    MOVE G6B,100,  60,  80
    MOVE G6C,160,  50,  80
    WAIT

    SPEED 6
    MOVE G6A, 90,  92, 115, 109, 125, 100
    MOVE G6D,103,  76, 141,  98,  82, 100
    MOVE G6B,160,  50,  80
    MOVE G6C,188,  50,  80
    WAIT	

    SPEED 5
    FOR i = 1 TO 6

        MOVE G6B,160,  50,  50
        MOVE G6C,188,  50,  50
        WAIT

        MOVE G6B,160,  55,  80
        MOVE G6C,188,  55,  80
        WAIT
    NEXT i


    SPEED 10
    MOVE G6A, 85,  76, 145, 94, 110
    MOVE G6D,108,  81, 135,  98, 98
    MOVE G6B,100,  40,  80
    MOVE G6C,160,  60,  80
    WAIT

    SPEED 10
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6B,100,  40,  80
    MOVE G6C,140,  60,  90
    WAIT

    SPEED 6
    MOVE G6A, 95,  75, 146,  93, 105
    MOVE G6D,109,  76, 146,  93,  92
    WAIT

    SPEED 3
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN


    ''************************************************
breathing:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6B, 150,  35, 70,
    MOVE G6C, 150,  35, 70,
    MOVE G6A,100,  63, 135, 140, 100,
    MOVE G6D,100,  63, 135, 140, 100,
    WAIT

    FOR I = 1 TO 4
        SPEED 7
        MOVE G6B, 155,  40, 90,
        MOVE G6C, 155,  40, 90,
        WAIT

        SPEED 5
        MOVE G6A,100,  58, 135, 155, 100,
        MOVE G6D,100,  58, 135, 155, 100,
        WAIT

        SPEED 7
        MOVE G6B, 155,  20, 70,
        MOVE G6C, 155,  20, 70,
        WAIT

        SPEED 5
        MOVE G6A,100,  48, 160, 135, 100,
        MOVE G6D,100,  48, 160, 135, 100,
        WAIT
    NEXT I


    SPEED 6
    MOVE G6A,100,  65, 135, 140, 100,
    MOVE G6D,100,  65, 135, 140, 100,
    MOVE G6B, 155,  40, 80,
    MOVE G6C, 155,  40, 80,
    WAIT

    SPEED 6
    GOSUB standard_pose
    GOSUB All_motor_Reset 	
    RETURN
    '************************************************







    '************************************************
    '************************************************
creep:

    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,100, 155,  28, 140, 100, 100
    MOVE G6D,100, 155,  28, 140, 100, 100
    MOVE G6B,180,  40,  85
    MOVE G6C,180,  40,  85
    WAIT

    SPEED 5	
    MOVE G6A, 100, 155,  53, 160, 100, 100
    MOVE G6D, 100, 155,  53, 160, 100, 100
    MOVE G6B,190,  30, 80
    MOVE G6C,190,  30, 80
    WAIT	

    GOSUB All_motor_mode2

    DELAY 300

    SPEED 8
    PTP SETOFF
    PTP ALLOFF
    HIGHSPEED SETON

    GOSUB GOSUB_RX_EXIT

creep_LOOP:


    MOVE G6A, 100, 160,  55, 160, 100
    MOVE G6D, 100, 145,  75, 160, 100
    MOVE G6B, 175,  25,  70
    MOVE G6C, 190,  50,  40
    WAIT
    ERX 4800, A, creep_1
    IF A = 8 THEN GOTO creep_1
    IF A = 9 THEN GOTO creep_right_turn_LOOP
    IF A = 7 THEN GOTO creep_left_turn_LOOP

    GOTO creep_stand

creep_1:
    MOVE G6A, 100, 150,  70, 160, 100
    MOVE G6D, 100, 140, 120, 120, 100
    MOVE G6B, 160,  25,  70
    MOVE G6C, 190,  25,  70
    WAIT

    MOVE G6D, 100, 160,  55, 160, 100
    MOVE G6A, 100, 145,  75, 160, 100
    MOVE G6C, 175,  25,  70
    MOVE G6B, 190,  50,  40
    WAIT

    ERX 4800, A, creep_2
    IF A = 8 THEN GOTO creep_2
    IF A = 9 THEN GOTO creep_right_turn_LOOP
    IF A = 7 THEN GOTO creep_left_turn_LOOP

    GOTO creep_stand

creep_2:
    MOVE G6D, 100, 140,  80, 160, 100
    MOVE G6A, 100, 140, 120, 120, 100
    MOVE G6C, 160,  25,  70
    MOVE G6B, 190,  25,  70
    WAIT

    GOTO creep_LOOP


    '**********************************
creep_left_turn:

    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,100, 155,  28, 140, 100, 100
    MOVE G6D,100, 155,  28, 140, 100, 100
    MOVE G6B,180,  40,  85
    MOVE G6C,180,  40,  85
    WAIT

    SPEED 5	
    MOVE G6A, 100, 155,  53, 160, 100, 100
    MOVE G6D, 100, 155,  53, 160, 100, 100
    MOVE G6B,190,  30, 80
    MOVE G6C,190,  30, 80
    WAIT	

    GOSUB All_motor_mode2

    SPEED 10
    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6C,175,  20, 80
    MOVE G6B,175,  20, 80
    WAIT

    SPEED 8
    PTP SETOFF
    PTP ALLOFF
    HIGHSPEED SETON

creep_left_turn_LOOP:

    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6B,175,  70, 20
    MOVE G6C,175,  10, 75
    WAIT	


    ERX 4800, A, creep_left_turn_1
    IF A = 8 THEN GOTO creep_LOOP
    IF A = 9 THEN GOTO creep_right_turn_LOOP
    IF A = 7 THEN GOTO creep_left_turn_1
    GOTO creep_stand

creep_left_turn_1:
    MOVE G6A, 100, 155,  110, 100, 110
    MOVE G6D, 100, 155,  110, 100, 110
    MOVE G6B,175,  80, 30
    MOVE G6C,175,  30, 95
    WAIT		


    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6B,175,  15, 75
    MOVE G6C,175,  60, 20
    WAIT		

    ERX 4800, A, creep_left_turn_2
    IF A = 8 THEN GOTO creep_LOOP
    IF A = 9 THEN GOTO creep_right_turn_LOOP
    IF A = 7 THEN GOTO creep_left_turn_2
    GOTO creep_stand

creep_left_turn_2:
    MOVE G6A, 100, 155,  110, 100, 110
    MOVE G6D, 100, 155,  110, 100, 110
    MOVE G6B,175,  10, 75
    MOVE G6C,175,  10, 75
    WAIT	

    GOTO creep_left_turn_LOOP



    '**********************************

    '**********************************
creep_right_turn:

    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,100, 155,  28, 140, 100, 100
    MOVE G6D,100, 155,  28, 140, 100, 100
    MOVE G6B,180,  40,  85
    MOVE G6C,180,  40,  85
    WAIT

    SPEED 5	
    MOVE G6A, 100, 155,  53, 160, 100, 100
    MOVE G6D, 100, 155,  53, 160, 100, 100
    MOVE G6B,190,  30, 80
    MOVE G6C,190,  30, 80
    WAIT	

    GOSUB All_motor_mode2

    SPEED 10
    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6C,175,  20, 80
    MOVE G6B,175,  20, 80
    WAIT

    SPEED 8
    PTP SETOFF
    PTP ALLOFF
    HIGHSPEED SETON

creep_right_turn_LOOP:

    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6C,175,  70, 20
    MOVE G6B,175,  10, 75
    WAIT	


    ERX 4800, A, creep_right_turn_1
    IF A = 8 THEN GOTO creep_LOOP
    IF A = 9 THEN GOTO creep_right_turn_1
    IF A = 7 THEN GOTO creep_left_turn_LOOP
    GOTO creep_stand

creep_right_turn_1:
    MOVE G6A, 100, 155,  110, 100, 110
    MOVE G6D, 100, 155,  110, 100, 110
    MOVE G6C,175,  80, 30
    MOVE G6B,175,  30, 95
    WAIT		


    MOVE G6A, 100, 160,  110, 100, 110
    MOVE G6D, 100, 160,  110, 100, 110
    MOVE G6C,175,  15, 75
    MOVE G6B,175,  60, 20
    WAIT		

    ERX 4800, A, creep_right_turn_2
    IF A = 8 THEN GOTO creep_LOOP
    IF A = 9 THEN GOTO creep_right_turn_2
    IF A = 7 THEN GOTO creep_left_turn_LOOP
    GOTO creep_stand

creep_right_turn_2:
    MOVE G6A, 100, 155,  110, 100, 110
    MOVE G6D, 100, 155,  110, 100, 110
    MOVE G6C,175,  10, 75
    MOVE G6B,175,  10, 75
    WAIT	

    GOTO creep_right_turn_LOOP



    '**********************************

    GOTO RX_EXIT
    '**********************************	
creep_stand:
    PTP SETON		
    PTP ALLON
    SPEED 15
    HIGHSPEED SETOFF



    SPEED 10
    MOVE G6A, 80, 155,  85, 150, 150, 100
    MOVE G6D, 80, 155,  85, 150, 150, 100
    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT



    MOVE G6A, 75, 162,  55, 162, 155, 100
    MOVE G6D, 75, 162,  59, 162, 155, 100
    MOVE G6B,188,  10, 100, 100, 100, 100
    MOVE G6C,188,  10, 100, 100, 100, 100
    WAIT

    SPEED 10
    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B,170,  10, 100, 100, 100, 100
    MOVE G6C,170,  10, 100, 100, 100, 100
    WAIT
    GOSUB Leg_motor_mode3	
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B,150,  60,  90, 100, 100, 100
    MOVE G6C,150,  60,  90, 100, 100, 100
    WAIT

    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B,130,  50,  85, 100, 100, 100
    MOVE G6C,130,  50,  85, 100, 100, 100
    WAIT
    DELAY 100

    MOVE G6A,100, 150,  33, 140, 100, 100
    MOVE G6D,100, 150,  33, 140, 100, 100
    WAIT
    SPEED 10

    GOSUB standard_pose

    GOTO RX_EXIT

    '******************************************************
front_tumbling:

    SPEED 15
    MOVE G6A,100, 155,  27, 140, 100, 100
    MOVE G6D,100, 155,  27, 140, 100, 100
    MOVE G6B,130,  30,  85
    MOVE G6C,130,  30,  85
    WAIT

    SPEED 10	
    MOVE G6A, 100, 165,  55, 165, 100, 100
    MOVE G6D, 100, 165,  55, 165, 100, 100
    MOVE G6B,185,  10, 100
    MOVE G6C,185,  10, 100
    WAIT

    SPEED 15
    MOVE G6A,100, 160, 110, 140, 100, 100
    MOVE G6D,100, 160, 110, 140, 100, 100
    MOVE G6B,140,  70,  20
    MOVE G6C,140,  70,  20
    WAIT

    SPEED 15
    MOVE G6A,100,  56, 110,  26, 100, 100
    MOVE G6D,100,  71, 177, 162, 100, 100
    MOVE G6B,170,  40,  70
    MOVE G6C,170,  40,  70
    WAIT

    SPEED 15
    MOVE G6A,100,  60, 110,  15, 100, 100
    MOVE G6D,100,  70, 120, 30, 100, 100
    MOVE G6B,170,  40,  70
    MOVE G6C,170,  40,  70
    WAIT

    SPEED 15
    MOVE G6A,100,  60, 110,  15, 100, 100
    MOVE G6D,100,  60, 110,  15, 100, 100
    MOVE G6B,190,  40,  70
    MOVE G6C,190,  40,  70
    WAIT
    DELAY 50

    SPEED 15
    MOVE G6A,100, 110, 70,  65, 100, 100
    MOVE G6D,100, 110, 70,  65, 100, 100
    MOVE G6B,190, 160, 115
    MOVE G6C,190, 160, 115
    WAIT

    SPEED 10
    MOVE G6A,100, 170,  70,  15, 100, 100
    MOVE G6D,100, 170,  70,  15, 100, 100
    MOVE G6B,190, 155, 120
    MOVE G6C,190, 155, 120
    WAIT

    SPEED 10
    MOVE G6A,100, 170,  30,  110, 100, 100
    MOVE G6D,100, 170,  30,  110, 100, 100
    MOVE G6B,190,  40,  60
    MOVE G6C,190,  40,  60
    WAIT

    SPEED 13
    GOSUB sit_pose

    SPEED 10
    GOSUB standard_pose

    RETURN

    '**********************************************
    '**********************************************
back_tumbling:

    SPEED 15
    MOVE G6A,100, 170,  71,  23, 100, 100
    MOVE G6D,100, 170,  71,  23, 100, 100
    MOVE G6B, 80,  50,  70
    MOVE G6C, 80,  50,  70
    WAIT	

    MOVE G6A,100, 133,  49,  23, 100, 100
    MOVE G6D,100, 133,  49,  23, 100, 100
    MOVE G6B, 45, 116,  15
    MOVE G6C, 45, 116,  15
    WAIT

    SPEED 15
    MOVE G6A,100, 133,  49,  23, 100, 100
    MOVE G6D,100,  70, 180, 160, 100, 100
    MOVE G6B, 45,  50,  70
    MOVE G6C, 45,  50,  70
    WAIT


    SPEED 15
    MOVE G6A,100, 133, 180, 160, 100, 100
    MOVE G6D,100,  133, 180, 160, 100, 100
    MOVE G6B, 10,  50,  70
    MOVE G6C, 10,  50,  70
    WAIT

    HIGHSPEED SETON

    MOVE G6A,100, 95, 180, 160, 100, 100
    MOVE G6D,100, 95, 180, 160, 100, 100
    MOVE G6B,160,  50,  70
    MOVE G6C,160,  50,  70
    WAIT

    HIGHSPEED SETOFF '

    SPEED 15
    MOVE G6A,100, 130, 120,  80, 100, 100
    MOVE G6D, 100, 130, 120,  80, 100, 100
    MOVE G6B,160, 160,  10
    MOVE G6C,160, 160,  10
    WAIT
    '
    SPEED 15
    MOVE G6A,100, 145, 150,  90, 100, 100
    MOVE G6D, 100, 145, 150,  90, 100, 100
    MOVE G6B,180, 90,  10
    MOVE G6C,180, 90,  10
    WAIT

    SPEED 10
    MOVE G6A, 100, 145,  85, 150, 100, 100
    MOVE G6D, 100, 145,  85, 150, 100, 100
    MOVE G6B,185,  40, 60
    MOVE G6C,185,  40, 60
    WAIT

    SPEED 15
    MOVE G6A, 100, 165,  55, 155, 100, 100
    MOVE G6D, 100, 165,  55, 155, 100, 100
    MOVE G6B,185,  10, 100
    MOVE G6C,185,  10, 100
    WAIT	

    GOSUB Leg_motor_mode2
    SPEED 15	
    MOVE G6A,  100, 165,  27, 162, 100
    MOVE G6D,  100, 165,  27, 162, 100
    MOVE G6B,  155, 15, 90
    MOVE G6C,  155, 15, 90
    WAIT

    SPEED 10	
    MOVE G6A,  100, 150,  27, 162, 100
    MOVE G6D,  100, 150,  27, 162, 100
    MOVE G6B,  140, 15, 90
    MOVE G6C,  140, 15, 90
    WAIT

    SPEED 6
    MOVE G6A,  100, 138,  27, 155, 100
    MOVE G6D,  100, 138,  27, 155, 100
    MOVE G6B, 113,  30, 80
    MOVE G6C, 113,  30, 80
    WAIT

    DELAY 100
    SPEED 10
    GOSUB standard_pose
    RETURN
    '************************************************
front_lie:

    SPEED 10
    MOVE G6A,100, 155,  25, 140, 100,
    MOVE G6D,100, 155,  25, 140, 100,
    MOVE G6B,130,  50,  85
    MOVE G6C,130,  50,  85
    WAIT

    SPEED 3
    MOVE G6A, 100, 165,  50, 160, 100,
    MOVE G6D, 100, 165,  50, 160, 100,
    MOVE G6B,185,  10, 100
    MOVE G6C,185,  10, 100
    WAIT

    SPEED 10
    MOVE G6A,100, 130, 120,  80, 100,
    MOVE G6D,100, 130, 120,  80, 100,
    MOVE G6B,125, 160,  10
    MOVE G6C,125, 160,  10
    WAIT	

    SPEED 12
    GOSUB standard_pose

    RETURN
    '**********************************************
    '******************************************
back_lie:

    SPEED 10
    MOVE G6A,100, 165,  40, 100, 100,
    MOVE G6D,100, 165,  40, 100, 100,
    MOVE G6B,110,  70,  50
    MOVE G6C,110,  70,  50
    WAIT

    SPEED 10
    MOVE G6A,100, 165,  70, 15, 100,
    MOVE G6D,100, 165,  70, 15, 100,
    MOVE G6B,30,  20,  95
    MOVE G6C,30,  20,  95
    WAIT

    SPEED 15
    MOVE G6A,100, 126,  60, 50, 100,
    MOVE G6D,100, 126,  60, 50, 100,
    MOVE G6B,20,  30,  90
    MOVE G6C,20,  30,  90
    WAIT

    SPEED 10
    MOVE G6A,100, 10,  83, 140, 100,
    MOVE G6D,100, 10,  83, 140, 100,
    MOVE G6B,20,  130,  15
    MOVE G6C,20,  130,  15
    WAIT

    SPEED 10
    MOVE G6A,100, 10,  100, 115, 100,
    MOVE G6D,100, 10,  100, 115, 100,
    MOVE G6B,100,  130,  15
    MOVE G6C,100,  130,  15
    WAIT

    SPEED 10
    GOSUB standard_pose

    RETURN
    '******************************************


    '**********************************************
    '**********************************************
left_tumbling:
    GOSUB Leg_motor_mode1
    SPEED 15
    GOSUB standard_pose


    SPEED 15
    MOVE G6D,100, 125,  62, 132, 100, 100
    MOVE G6A,100, 125,  62, 132, 100, 100
    MOVE G6B,105, 150, 140
    MOVE G6C,105, 150, 140
    WAIT

    SPEED 7
    MOVE G6D,83 , 108,  85, 125, 105, 100
    MOVE G6A,108, 125,  62, 132, 110, 100
    MOVE G6B,105, 155, 145
    MOVE G6C,105, 155, 145
    WAIT


    SPEED 10
    MOVE G6D,89,  125,  62, 130, 110, 100
    MOVE G6A,110, 125,  62, 130, 122, 100
    WAIT
    SPEED 8
    MOVE G6D, 89, 125,  62, 130, 150, 100
    MOVE G6A,106, 125,  62, 130, 150, 100
    MOVE G6B,105, 160, 190
    MOVE G6C,105, 168, 190
    WAIT

    SPEED 6
    MOVE G6D,120, 125,  62, 130, 170, 100
    MOVE G6A,104, 125,  62, 130, 170, 100
    WAIT

    SPEED 12
    MOVE G6D,120, 125,  62, 130, 183, 100
    MOVE G6A,110, 125,  62, 130, 185, 100
    WAIT

    DELAY 400

    SPEED 14
    MOVE G6D,120, 125,  62, 130, 168, 100
    MOVE G6A,120, 125  62, 130, 185, 100
    MOVE G6B,105, 120, 145
    MOVE G6C,105, 120, 145
    WAIT

    SPEED 12
    MOVE G6D,105, 125,  62, 130, 183, 100
    MOVE G6A, 86, 112,  73, 127, 100, 100
    MOVE G6B,105, 120, 135
    MOVE G6C,105, 120, 135
    WAIT

    SPEED 8
    MOVE G6D,107, 125,  62, 132, 113, 100
    MOVE G6A, 82, 110,  90, 120,  100, 100
    MOVE G6B,105, 50, 80
    MOVE G6C,105, 50, 80
    WAIT

    SPEED 6
    MOVE G6A,97, 125,  62, 132, 102, 100
    MOVE G6D,97, 125,  62, 132, 102, 100
    MOVE G6B,100, 50, 80
    MOVE G6C,100, 50, 80
    WAIT

    SPEED 10
    GOSUB standard_pose
    RETURN
    '**********************************************
    '**********************************************
right_tumbling:
    GOSUB Leg_motor_mode1
    SPEED 15
    GOSUB standard_pose


    SPEED 15
    MOVE G6A,100, 125,  62, 132, 100, 100
    MOVE G6D,100, 125,  62, 132, 100, 100
    MOVE G6B,105, 150, 140
    MOVE G6C,105, 150, 140
    WAIT

    SPEED 7
    MOVE G6A,83 , 108,  85, 125, 105, 100
    MOVE G6D,108, 125,  62, 132, 110, 100
    MOVE G6B,105, 155, 145
    MOVE G6C,105, 155, 145
    WAIT


    SPEED 10
    MOVE G6A,89,  125,  62, 130, 110, 100
    MOVE G6D,110, 125,  62, 130, 122, 100
    WAIT
    SPEED 8
    MOVE G6A, 89, 125,  62, 130, 150, 100
    MOVE G6D,106, 125,  62, 130, 150, 100
    MOVE G6B,105, 160, 190
    MOVE G6C,105, 168, 190
    WAIT

    SPEED 6
    MOVE G6A,120, 125,  62, 130, 170, 100
    MOVE G6D,104, 125,  62, 130, 170, 100
    WAIT

    SPEED 12
    MOVE G6A,120, 125,  62, 130, 183, 100
    MOVE G6D,110, 125,  62, 130, 185, 100
    WAIT

    DELAY 400

    SPEED 14
    MOVE G6A,120, 125,  60, 130, 168, 100
    MOVE G6D,120, 125  60, 130, 185, 100
    MOVE G6B,105, 120, 145
    MOVE G6C,105, 120, 145
    WAIT

    SPEED 12
    MOVE G6A,105, 125,  62, 130, 183, 100
    MOVE G6D, 86, 112,  73, 127, 100, 100
    MOVE G6B,105, 120, 135
    MOVE G6C,105, 120, 135
    WAIT

    SPEED 8
    MOVE G6A,107, 125,  62, 132, 113, 100
    MOVE G6D, 82, 110,  90, 120,  100, 100
    MOVE G6B,105, 50, 80
    MOVE G6C,105, 50, 80
    WAIT

    SPEED 6
    MOVE G6A,97, 125,  62, 132, 102, 100
    MOVE G6D,97, 125,  62, 132, 102, 100
    MOVE G6B,100, 50, 80
    MOVE G6C,100, 50, 80
    WAIT
    SPEED 10
    GOSUB standard_pose
    RETURN
    '**********************************************
    '**********************************************
left_foot_sit_standup:

    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6A,112,  77, 146,  93,  92' 60	
    MOVE G6D, 80,  71, 152,  91, 112', 60
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT


    SPEED 8
    MOVE G6A,113,  77, 146,  93,  92, 100	
    MOVE G6D,80,  150,  27, 143, 114, 100
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT

    DELAY 500


    SPEED 8
    MOVE G6A,113, 152,  27, 140, 92, 100
    MOVE G6D,85, 154,  27, 143, 114, 100,
    MOVE G6C,100,  100,  100
    MOVE G6B,100,  100,  100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 1000

    SPEED 3
    MOVE G6A,115, 152,  35, 140, 92, 100
    WAIT

    SPEED 8
    MOVE G6A,113,  77, 146,  93, 92, 100
    WAIT

    GOSUB Leg_motor_mode2
    DELAY 500

    MOVE G6A,112,  77, 146,  93,  92, 100		
    MOVE G6D, 80, 88, 125, 100, 115, 100
    MOVE G6B,100,  100,  100, , , ,
    MOVE G6C,100,  100,  100, , , ,
    WAIT


    SPEED 4
    GOSUB standard_pose
    GOSUB Leg_motor_mode1

    RETURN
    '******************************************	
right_foot_sit_standup:

    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6D,112,  77, 146,  93,  92, '60	
    MOVE G6A, 80,  71, 152,  91, 112,' 60
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT


    SPEED 8
    MOVE G6D,113,  77, 146,  93,  92, 100	
    MOVE G6A,80,  150,  27, 140, 114, 100
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT

    DELAY 500

    SPEED 8
    MOVE G6D,113, 152,  27, 140, 92, 100
    MOVE G6A,85, 154,  27, 140, 114, 100,
    MOVE G6C,100,  100,  100
    MOVE G6B,100,  100,  100
    WAIT

    GOSUB Leg_motor_mode1
    DELAY 1000

    SPEED 3
    MOVE G6D,115, 152,  35, 140, 92, 100
    WAIT

    SPEED 8
    MOVE G6D,113,  77, 146,  93, 92, 100
    WAIT

    GOSUB Leg_motor_mode2
    DELAY 500


    MOVE G6D,112,  77, 146,  93,  92, 100		
    MOVE G6A, 80, 88, 125, 100, 115, 100
    MOVE G6B,100,  100,  100, , , ,
    MOVE G6C,100,  100,  100, , , ,
    WAIT


    SPEED 4
    GOSUB standard_pose
    GOSUB Leg_motor_mode1

    RETURN
    '**********************************************
    '********************************************	
hand_standing:
    GOSUB front_lie
    GOSUB Arm_motor_mode1
    GOSUB Leg_motor_mode3

    SPEED 10
    MOVE G6B, 115,  45,  70,  ,  ,  ,
    MOVE G6C,115,  45,  70,  ,  ,  ,
    WAIT

    MOVE G6A,100, 125,  65,  10, 100
    MOVE G6D,100, 125,  65,  10, 100
    MOVE G6B, 130,  45,  70,  ,  ,  ,
    MOVE G6C,130,  45,  70,  ,  ,  ,
    WAIT

    SPEED 6
    MOVE G6A,100,  89, 129,  57, 100,
    MOVE G6D, 100,  89, 129,  57, 100
    MOVE G6B, 180,  45,  70,  ,  ,  ,
    MOVE G6C, 180,  45,  70,  ,  ,  ,
    WAIT

    MOVE G6A,100,  64, 169,  60, 100,
    MOVE G6D, 100,  64, 169,  60, 100
    MOVE G6B, 190,  45,  70,  ,  ,  ,
    MOVE G6C, 190,  45,  70,  ,  ,  ,
    WAIT
    DELAY 500

    SPEED 12

    FOR i = 1 TO 4

        MOVE G6A,100, 141,  30, 120, 100
        MOVE G6D, 100,  64, 169,  60, 100
        WAIT

        MOVE G6D,100, 141,  30, 120, 100
        MOVE G6A, 100,  64, 169,  60, 100
        WAIT

    NEXT i

    MOVE G6A,100,  64, 169,  60, 100,
    MOVE G6D, 100,  64, 169,  60, 100
    MOVE G6B, 190,  45,  70,  ,  ,  ,
    MOVE G6C, 190,  45,  70,  ,  ,  ,
    WAIT

    DELAY 300

    SPEED 4
    FOR i = 1 TO 3


        MOVE G6A,70,  64, 169,  60, 130,
        MOVE G6D, 70,  64, 169,  60, 130
        WAIT

        MOVE G6A,100,  64, 169,  60, 100,
        MOVE G6D, 100,  64, 169,  60, 100
        WAIT
    NEXT i

    DELAY 300	
    SPEED 10
    MOVE G6A,100,  89, 129,  65, 100,
    MOVE G6D,100,  89, 129,  65, 100
    MOVE G6B, 180,  45,  70,  ,  ,  ,
    MOVE G6C, 180,  45,  70,  ,  ,  ,
    WAIT

    SPEED 10
    MOVE G6A,100, 125,  65,  10, 100,
    MOVE G6D, 100, 125,  65,  10, 100
    MOVE G6B, 160,  45,  70,  ,  ,  ,
    MOVE G6C, 160,  45,  70,  ,  ,  ,
    WAIT

    SPEED 10
    MOVE G6A,100, 125,  65,  10, 100,
    MOVE G6D, 100, 125,  65,  10, 100
    MOVE G6B, 110,  45,  70,  ,  ,  ,
    MOVE G6C, 110,  45,  70,  ,  ,  ,
    WAIT
    SPEED 10
    GOSUB standard_pose

    GOSUB back_standup

    RETURN
    '**********************************************	
korea_old_dance:

    DIM w1 AS BYTE
    GOSUB Leg_motor_mode2
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT


    SPEED 5
    MOVE G6A, 80,  74, 146, 94, 116, 100
    MOVE G6D,108,  81, 137,  98, 98, 100
    MOVE G6B,100,  70,  90
    MOVE G6C,100,  70,  90	
    WAIT

    SPEED 5
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT	



    SPEED 4
    MOVE G6A,94,  94, 145,  45, 106
    MOVE G6D,94,  94, 145,  45, 106
    WAIT	

    HIGHSPEED SETON


    FOR I= 1 TO 3
        SPEED 6
        FOR w1= 0 TO 2

            MOVE G6B,100,  150,  140,
            MOVE G6C,100,  100,  190,
            MOVE G6A, 95,  94, 145,  45, 107,
            MOVE G6D, 89,  94, 145,  45, 113,
            WAIT

            MOVE G6C,100,  150,  140,
            MOVE G6B,100,  100,  190,
            MOVE G6D, 95,  94, 145,  45, 107,
            MOVE G6A, 89,  94, 145,  45, 113,
            WAIT

        NEXT w1

        SPEED 12
        MOVE G6C,100,  100,  190,
        MOVE G6B,100,  75,  100,
        MOVE G6A, 95,  94, 145,  45, 107,
        MOVE G6D, 89,  94, 145,  45, 113,
        WAIT

        SPEED 12
        MOVE G6C,100,  150,  140,
        MOVE G6B,100,  100,  100,
        MOVE G6D, 95,  94, 145,  45, 107,
        MOVE G6A, 89,  94, 145,  45, 113,
        WAIT

        DELAY 200
        SPEED 6
        FOR w1= 0 TO 2


            MOVE G6B,100,  150,  140,
            MOVE G6C,100,  100,  190,
            MOVE G6A, 95,  94, 145,  45, 107,
            MOVE G6D, 89,  94, 145,  45, 113,
            WAIT

            MOVE G6C,100,  150,  140,
            MOVE G6B,100,  100,  190,
            MOVE G6D, 95,  94, 145,  45, 107,
            MOVE G6A, 89,  94, 145,  45, 113,
            WAIT

        NEXT w1

        SPEED 15
        MOVE G6B,100,  100,  190,
        MOVE G6C,100,  75,  100,
        MOVE G6D, 89,  94, 145,  45, 113,
        MOVE G6A, 95,  94, 145,  45, 107,
        WAIT

        SPEED 12
        MOVE G6B,100,  150,  140,
        MOVE G6C,100,  100,  100,
        MOVE G6D, 95,  94, 145,  45, 107,
        MOVE G6A, 89,  94, 145,  45, 113,
        WAIT

        DELAY 100
    NEXT I
    HIGHSPEED SETOFF

    GOSUB Arm_motor_mode3	
    GOSUB Leg_motor_mode1
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 98, 100
    MOVE G6D,100,  76, 145,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    SPEED 5
    DELAY 50
    GOSUB standard_pose


    RETURN

    '************************************************

    '******************************************	


soar:

    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110, 100
    MOVE G6D,112,  76, 146,  93,  92, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT


    SPEED 10
    MOVE G6A, 90,  98, 105,  115, 115, 100
    MOVE G6D,114,  74, 145,  98,  93, 100
    MOVE G6B,100,  150,  150
    MOVE G6C,100,  150,  150
    WAIT

    SPEED 6
    MOVE G6A, 90, 121,  36, 105, 115,  100
    MOVE G6D,114,  60, 146, 138,  93,  100
    WAIT

    SPEED 6
    GOSUB Leg_motor_mode2
    MOVE G6A, 90,  98, 105,  64, 115,  100
    MOVE G6D,114,  42, 170, 160,  93,  100
    MOVE G6B,100, 160, 180
    MOVE G6C,100, 160, 180
    WAIT

    SPEED 10
    MOVE G6A, 90, 117,  41, 113, 115,  60
    MOVE G6D,114,  33, 176, 160,  93,  60
    MOVE G6B,100, 160, 180
    MOVE G6C,100, 160, 180
    WAIT


    FOR i = 0 TO 2
        SPEED 7
        MOVE G6A, 90, 117,  41, 113, 115,  100
        MOVE G6D,114,  33, 176, 160,  93,  100
        MOVE G6B,100, 180, 130, , ,  70
        MOVE G6C,100, 180, 130, , ,
        WAIT
        SPEED 15
        MOVE G6A, 90,  63, 165,  47, 115,  100
        MOVE G6D,114,  43, 176, 160,  93,  100
        MOVE G6B,100,  70,  50, , ,
        MOVE G6C,100,  70,  50, , ,
        WAIT
    NEXT i

    FOR i = 0 TO 3
        SPEED 6
        MOVE G6A, 90,  74, 176,  32, 115,  100
        MOVE G6D,114,  39, 176, 160,  93,  100
        MOVE G6B,170, 169, 117, , , 130
        MOVE G6C,170, 169, 117, , ,
        WAIT

        SPEED 15
        HIGHSPEED SETON
        MOVE G6A, 90,  36, 154,  32, 115,  100
        MOVE G6D,114,  39, 176, 160,  93,  100
        MOVE G6B,170,  40,  70, , ,
        MOVE G6C,170,  40,  70, , ,
        WAIT
        DELAY 100
        HIGHSPEED SETOFF
    NEXT i
    '****************

    SPEED 1
    HIGHSPEED SETON
    FOR i = 1 TO 15
        SPEED i
        MOVE G6B,170,  80,  80
        MOVE G6C,170,  80,  80
        WAIT

        MOVE G6B,170,  120,  120
        MOVE G6C,170,  120,  120
        WAIT
    NEXT i
    DELAY 100
    HIGHSPEED SETOFF
    DELAY 500
    '****************
    SPEED 6
    MOVE G6A, 90,  98, 105,  64, 115,  100
    MOVE G6D,114,  39, 170, 160,  93,  100
    MOVE G6B,100, 160, 180
    MOVE G6C,100, 160, 180
    WAIT


    MOVE G6A, 90, 121,  36, 105, 115,  100
    MOVE G6D,114,  60, 146, 138,  93,  100
    MOVE G6B,100,  150,  150
    MOVE G6C,100,  150,  150
    WAIT

    SPEED 4
    MOVE G6A, 85,  98, 105,  115, 115, 100
    MOVE G6D,115,  74, 145,  98,  93, 100
    WAIT

    SPEED 8
    MOVE G6A, 85,  71, 152,  91, 110, 100
    MOVE G6D,108,  76, 146,  93,  92, 100
    MOVE G6B,100,  70,  80
    MOVE G6C,100,  70,  80
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  80
    MOVE G6C,100,  35,  80
    WAIT

    SPEED 2
    GOSUB standard_pose	
    GOSUB All_motor_Reset
    RETURN
    '******************************************
    '******************************************
flying:

    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6D, 88,  71, 152,  91, 110, 100
    MOVE G6A,112,  76, 146,  93,  92, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT


    SPEED 10
    MOVE G6D, 90,  98, 105,  115, 115, 100
    MOVE G6A,114,  74, 145,  98,  93, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT

    SPEED 6
    MOVE G6D, 90, 121,  36, 105, 115,  100
    MOVE G6A,114,  60, 146, 138,  93,  100
    MOVE G6B,130,  100,  100
    MOVE G6C,130,  100,  100
    WAIT

    SPEED 6
    GOSUB Leg_motor_mode2
    MOVE G6D, 90,  98, 145,  54, 115,  100
    MOVE G6A,114,  45, 170, 160,  93,  100
    MOVE G6B,170, 100, 100
    MOVE G6C,170, 100, 100
    WAIT

    GOSUB Leg_motor_mode4
    '****************
    FOR I = 0 TO 3
        SPEED 6
        MOVE G6D, 90,  98, 145,  54, 115,  100
        MOVE G6A,114,  45, 170, 160,  93,  100
        MOVE G6B,170, 150, 140
        MOVE G6C,170, 50, 70
        WAIT

        SPEED 6
        MOVE G6D, 90,  98, 145,  54, 115,  100
        MOVE G6A,114,  45, 170, 160,  93,  100
        MOVE G6C,170, 150, 140
        MOVE G6B,170, 50, 70
        WAIT

    NEXT I
    DELAY 300

    SPEED 10
    MOVE G6D, 90,  98, 145,  54, 115,  100
    MOVE G6A,114,  45, 170, 160,  93,  100
    MOVE G6B,170, 100, 100
    MOVE G6C,170, 100, 100
    WAIT

    '****************
    SPEED 5
    MOVE G6D, 90,  98, 105,  64, 115,  100
    MOVE G6A,114,  45, 170, 160,  93,  100
    MOVE G6B,170, 100, 100
    MOVE G6C,170, 100, 100
    WAIT
    GOSUB Leg_motor_mode2

    SPEED 5
    MOVE G6D, 90, 121,  36, 105, 115,  100
    MOVE G6A,113,  64, 146, 138,  93,  100
    MOVE G6B,140,  100,  100
    MOVE G6C,140,  100,  100
    WAIT

    SPEED 4
    MOVE G6D, 85,  98, 105,  115, 115, 100
    MOVE G6A,113,  74, 145,  98,  93, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT

    SPEED 8
    MOVE G6D, 85,  71, 152,  91, 110, 100
    MOVE G6A,108,  76, 146,  93,  92, 100
    MOVE G6B,100,  70,  80
    MOVE G6C,100,  70,  80
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  80
    MOVE G6C,100,  35,  80
    WAIT

    SPEED 2
    GOSUB standard_pose	
    GOSUB All_motor_Reset
    RETURN
    '******************************************
    '************************************************
front_back_tilt_check:
    IF tilt_measurement_check = 0 THEN
        RETURN
    ENDIF
    FOR i = 0 TO COUNT_MAX
        A = AD(front_back_tilt_AD_port)	'tilt front back
        IF A > 250 OR A < 5 THEN RETURN
        IF A > MIN AND A < MAX THEN RETURN
        DELAY tilt_time_check
    NEXT i

    IF A < MIN THEN GOSUB tilt_front
    IF A > MAX THEN GOSUB tilt_back

    RETURN
    '**************************************************
tilt_front:
    A = AD(front_back_tilt_AD_port)
    'IF A < MIN THEN GOSUB front_standup
    IF A < MIN THEN  GOSUB back_standup
    RETURN

tilt_back:
    A = AD(front_back_tilt_AD_port)
    'IF A > MAX THEN GOSUB back_standup
    IF A > MAX THEN GOSUB front_standup
    RETURN
    '**************************************************
left_right_tilt_check:
    '  IF tilt_measurement_check = 0 THEN
    '        RETURN
    '    ENDIF
    FOR i = 0 TO COUNT_MAX
        B = AD(left_right_tilt_AD_port)	'tilt left right
        IF B > 250 OR B < 5 THEN RETURN
        IF B > MIN AND B < MAX THEN RETURN
        DELAY tilt_time_check
    NEXT i

    IF B < MIN OR B > MAX THEN
        SPEED 8
        MOVE G6B,140,  40,  80
        MOVE G6C,140,  40,  80
        WAIT
        GOSUB standard_pose	
        RETURN

    ENDIF
    RETURN
    '**************************************************
    '**************************************************
right_kick:
    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6A,110,  77, 145,  93,  92, 100	
    MOVE G6D, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6A,113,  75, 145,  100,  95	
    MOVE G6D, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode2
    HIGHSPEED SETON

    SPEED 15
    MOVE G6A,113,  73, 145,  85,  95	
    MOVE G6D, 83,  20, 172,  155, 114
    MOVE G6C,50
    MOVE G6B,150
    WAIT


    DELAY 400
    HIGHSPEED SETOFF


    SPEED 10
    MOVE G6A,113,  72, 145,  97,  95
    MOVE G6D, 83,  58, 122,  130, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT	

    SPEED 8
    MOVE G6A,113,  77, 145,  95,  95	
    MOVE G6D, 80,  80, 142,  95, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT	

    SPEED 8
    MOVE G6A,110,  77, 145,  93,  93, 100	
    MOVE G6D, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 3
    GOSUB standard_pose	
    GOSUB Leg_motor_mode1
    DELAY 400

    RETURN


    '******************************************
left_kick:

    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6D,110,  77, 145,  93,  92, 100	
    MOVE G6A, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6D,113,  75, 145,  100,  95	
    MOVE G6A, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode2
    HIGHSPEED SETON

    SPEED 15
    MOVE G6D,113,  73, 145,  85,  95	
    MOVE G6A, 83,  20, 172,  155, 114
    MOVE G6B,50
    MOVE G6C,150
    WAIT


    DELAY 400
    HIGHSPEED SETOFF


    SPEED 10
    MOVE G6D,112,  72, 145,  97,  95
    MOVE G6A, 83,  58, 122,  130, 114
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,	
    WAIT	

    SPEED 8
    MOVE G6D,113,  77, 145,  95,  95	
    MOVE G6A, 80,  80, 142,  95, 114
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT	

    SPEED 8
    MOVE G6D,110,  77, 145,  93,  93, 100	
    MOVE G6A, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 3
    GOSUB standard_pose	
    GOSUB Leg_motor_mode1
    DELAY 400

    RETURN

    '******************************************
    '**************************************
LED_ON_OFF2:

    OUT 52,1
    DELAY 150

    OUT 52,0
    DELAY 150
    RETURN
    '**************************************
LED_ON_OFF:

    OUT 52,1
    DELAY 150
    OUT 52,0
    DELAY 150

    OUT 52,1
    DELAY 150
    OUT 52,0
    DELAY 150
    RETURN
    '**************************************
    '**************************************
back_dancer2:

    GOSUB All_motor_mode3

    GOSUB LED_ON_OFF2

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80, 100, 100, 100
    MOVE G6C,100,  40,  80, 100, 100, 100
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  90, 100, 100, 100
    MOVE G6C,100,  40,  90, 100, 100, 100
    WAIT


    SPEED 5
    MOVE G6A, 80,  74, 146, 94, 116, 100
    MOVE G6D,108,  81, 137,  98, 98, 100
    MOVE G6B,100,  70,  90, 100, 100, 100
    MOVE G6C,100,  70,  90, 100, 100, 100 	
    WAIT

    SPEED 4
    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100
    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100, 100
    WAIT	


    GOSUB LED_ON_OFF2
    '**** song start pose ******
    SPEED 3
    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100
    WAIT

    '**********************************
    FOR i = 0 TO 3
        SPEED 4
        MOVE G6A,108,  92, 119,  106, 99
        MOVE G6D,86,  76, 145,  94, 107
        WAIT

        SPEED 4
        MOVE G6A,102,  78, 139,  98, 84
        MOVE G6D,92,  90, 115,  110, 122
        WAIT

        SPEED 4
        MOVE G6D,108,  92, 119,  106, 99
        MOVE G6A,86,  76, 145,  94, 107
        WAIT

        SPEED 4
        MOVE G6D,102,  78, 139,  98, 84
        MOVE G6A,92,  90, 115,  110, 122
        WAIT

    NEXT i

    SPEED 3
    MOVE G6A,108,  92, 119,  106, 99
    MOVE G6D,86,  76, 145,  94, 107
    MOVE G6B,, , , , ,80
    WAIT

    GOSUB Leg_motor_mode1
    SPEED 4
    MOVE G6A,98,  76, 145,  93, 98, 100
    MOVE G6D,98,  76, 145,  93, 98, 100
    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100, 100
    WAIT



    SPEED 6
    GOSUB standard_pose

    GOSUB All_motor_Reset


    RETURN
    '******************************************
twist_dance:

    GOSUB All_motor_Reset

    SPEED 8
    MOVE G6A,88,  76, 145,  93, 110
    MOVE G6D,88,  76, 145,  93, 110
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT

    DELAY 500
    HIGHSPEED SETON

    SPEED 8	
    MOVE G6B,100,  100,  120
    MOVE G6C,100,  50,  90
    WAIT

    SPEED 15
    MOVE G6B,100,  150,  180
    MOVE G6C,100,  60,  100
    WAIT
    DELAY 400

    HIGHSPEED SETOFF
    GOSUB Arm_motor_mode3
    SPEED 6
    MOVE G6B,100,  150,  150
    MOVE G6C,100,  150,  150
    WAIT

    HIGHSPEED SETON
    GOSUB Arm_motor_mode1
    SPEED 8
    MOVE G6C,100,  150,  100
    MOVE G6B,100,  100,  100
    WAIT
    DELAY 300

    SPEED 15
    MOVE G6C,100,  150,  150
    MOVE G6B,100,  50,  100
    WAIT
    DELAY 300
    HIGHSPEED SETOFF

    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode4

    FOR I = 2 TO 5
        TEMP = I * 3
        SPEED TEMP
        MOVE G6A,  99,  96, 111, 107,  82,
        MOVE G6D,  72,  89, 120, 103, 142,
        MOVE G6B, 170,  70,  50,  ,  ,
        MOVE G6C,  100, 140, 150,  ,  ,
        WAIT

        MOVE G6D,  99,  96, 111, 107,  82,
        MOVE G6A,  72,  89, 120, 103, 142,
        MOVE G6C, 170,  70,  50,  ,  ,
        MOVE G6B,  100, 140, 150,  ,  ,
        WAIT
    NEXT I

    HIGHSPEED SETON
    FOR I = 2 TO 4
        TEMP = I * 3
        SPEED TEMP
        MOVE G6A,  99,  96, 111, 107,  82,
        MOVE G6D,  72,  89, 120, 103, 142,
        MOVE G6B, 170,  70,  50,  ,  ,
        MOVE G6C,  100, 140, 150,  ,  ,
        WAIT

        MOVE G6D,  99,  96, 111, 107,  82,
        MOVE G6A,  72,  89, 120, 103, 142,
        MOVE G6C, 170,  70,  50,  ,  ,
        MOVE G6B,  100, 140, 150,  ,  ,
        WAIT
    NEXT I

    HIGHSPEED SETOFF

    DELAY 300
    GOSUB Leg_motor_mode1
    SPEED 15
    MOVE G6A,98,  76, 145,  93, 98, 100
    MOVE G6D,98,  76, 145,  93, 98, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    GOSUB standard_pose


    RETURN
    '**********************************************
    '******************************************
arirang_dance:

    GOSUB All_motor_Reset

    HIGHSPEED SETON
    SPEED 8
    MOVE G6A,88,  76, 145,  93, 110
    MOVE G6D,88,  76, 145,  93, 110
    MOVE G6B,100,  100, 100
    MOVE G6C,100,  100,  100
    WAIT

    DELAY 300



    HIGHSPEED SETOFF

    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode4

    FOR I = 1 TO 8
        SPEED 10
        MOVE G6A,  99,  96, 111, 107,  82,
        MOVE G6D,  72,  89, 120, 103, 142,
        MOVE G6B,100,  170, 150
        MOVE G6C,100,  70,  70
        WAIT

        SPEED 10
        MOVE G6A,  87,  92, 115, 105,  112,
        MOVE G6D,  87,  92, 115, 105, 112,
        MOVE G6B,100,  80, 180
        MOVE G6C,100,  120,  20
        WAIT

        '***************************
        SPEED 10
        MOVE G6D,  99,  96, 111, 107,  82,
        MOVE G6A,  72,  89, 120, 103, 142,
        MOVE G6C,100,  170, 150
        MOVE G6B,100,  70,  70
        WAIT

        SPEED 10
        MOVE G6A,  87,  92, 115, 105,  112,
        MOVE G6D,  87,  92, 115, 105, 112,
        MOVE G6C,100,  80, 180
        MOVE G6B,100,  120,  20
        WAIT
    NEXT I

    SPEED 15
    MOVE G6A,  87,  92, 115, 105,  112,
    MOVE G6D,  87,  92, 115, 105, 112,
    MOVE G6C,100,  80, 90
    MOVE G6B,100,  80,  90
    WAIT

    DELAY 300
    GOSUB Leg_motor_mode1
    SPEED 15
    MOVE G6A,98,  76, 145,  93, 98, 100
    MOVE G6D,98,  76, 145,  93, 98, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    GOSUB standard_pose


    RETURN
    '**********************************************
flying_stand:
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6A,100, 140,  37, 140, 100, 100
    MOVE G6D,100, 140,  37, 140, 100, 100
    WAIT

    SPEED 3
    GOSUB sit_pose

    HIGHSPEED SETON
    FOR i = 1 TO 2
        SPEED 6
        MOVE G6B,100,  150,  115
        MOVE G6C,100,  150,  115
        WAIT   	

        SPEED 8
        MOVE G6B,100,  40,  80
        MOVE G6C,100,  40,  80
        WAIT
    NEXT i
    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6B,100,  150,  115
    MOVE G6C,100,  150,  115
    WAIT

    SPEED 6
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    MOVE G6A,100, 133,  50, 132, 100, 100
    MOVE G6D,100, 133,  50, 132, 100, 100
    WAIT

    SPEED 10
    MOVE G6B,100,  150,  115
    MOVE G6C,100,  150,  115
    WAIT


    SPEED 6
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    MOVE G6A,100, 120,  80, 112, 100, 100
    MOVE G6D,100, 120,  80, 112, 100, 100
    WAIT

    SPEED 10
    MOVE G6B,100,  150,  115
    MOVE G6C,100,  150,  115
    WAIT

    SPEED 6
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    MOVE G6A,100, 88,  125, 100, 100, 100
    MOVE G6D,100, 88,  125, 100, 100, 100
    WAIT

    SPEED 10
    MOVE G6B,100,  150,  115
    MOVE G6C,100,  150,  115
    WAIT

    SPEED 6
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    MOVE G6A,100, 76,  145, 93, 100, 100
    MOVE G6D,100, 76,  145, 93, 100, 100
    WAIT

    FOR i = 1 TO 3
        SPEED 10
        MOVE G6B,100,  150,  115
        MOVE G6C,100,  150,  115
        WAIT

        SPEED 10
        MOVE G6B,100,  40,  80
        MOVE G6C,100,  40,  80
        WAIT
    NEXT i

    HIGHSPEED SETOFF
    SPEED 5
    GOSUB standard_pose
    GOSUB All_motor_Reset       	
    RETURN


    '**********************************************

chanson_dance:

    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80, 100, 100, 100
    MOVE G6C,160,  30,  80, 100, 100, 100
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,110,  76, 145,  93, 98, 100
    MOVE G6B,100,  40,  90, , , 55
    MOVE G6C,185,  15,  15	
    WAIT


    SPEED 4
    MOVE G6A, 80,  74, 145, 94, 116, 100
    MOVE G6D,108,  81, 135,  98, 98, 100
    MOVE G6B,100,  40,  90, , , 55
    MOVE G6C,185,  15,  15	
    WAIT

    SPEED 6
    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100
    MOVE G6B,100,  40,  90, , , 100
    MOVE G6C,185,  30,  10	
    WAIT	

    '**** song start pose******
    SPEED 5
    MOVE G6A,98,  79, 145,  83, 103, 100
    MOVE G6D,98,  79, 145,  83, 103, 100
    MOVE G6B,100, 50, 90, , , 100
    MOVE G6C,185,  30,  10	
    WAIT
    '**** song start pose******

    SPEED 4
    FOR I = 0 TO 1

        MOVE G6B,100,  80,  90, , , 80
        MOVE G6C,180,  30,  10	
        WAIT	

        MOVE G6B,100,  60,  90, , , 120
        MOVE G6C,185,  35,  10	
        WAIT	

    NEXT I


    SPEED 4
    MOVE G6A,95, 100, 145,  53, 105, 100
    MOVE G6D,95,  60, 145,  93, 105, 100
    MOVE G6B,100, 40, 90, , , 145
    WAIT

    SPEED 5
    FOR I = 0 TO 1

        MOVE G6B,100,  120,  120, , , 80
        MOVE G6C,180,  30,  10	
        WAIT	

        MOVE G6B,100,  80,  90, , , 120
        MOVE G6C,185,  35,  10	
        WAIT	

    NEXT I

    SPEED 4
    MOVE G6A,98,  79, 145,  83, 103, 100
    MOVE G6D,98,  79, 145,  83, 103, 100
    MOVE G6B,100, 40, 90, , ,100
    WAIT


    SPEED 4
    MOVE G6D,95, 100, 145,  53, 105, 100
    MOVE G6A,95,  60, 145,  93, 105, 100
    MOVE G6B,, , , , , 55
    WAIT


    SPEED 4
    FOR I = 0 TO 1

        MOVE G6B,120, 60, 90, , ,80
        WAIT
        MOVE G6B,80, 40, 90, , , 120
        WAIT

    NEXT I

    SPEED 4
    MOVE G6A,98,  79, 145,  83, 103, 100
    MOVE G6D,98,  79, 145,  83, 103, 100
    MOVE G6B,100, 50, 70, , , 100
    MOVE G6C,185,  40,  10	
    WAIT

    '******************************************
    '******************************************
    SPEED 3
    MOVE G6A,108,  95, 119,  96, 99
    MOVE G6D,86,  82, 145,  83, 107
    MOVE G6B,80, 50, 80, , , 70
    MOVE G6C,185,  20,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,100, 120, 110, , , 60
    MOVE G6C,175,  40,  10	
    WAIT


    SPEED 3
    MOVE G6D,108,  95, 119,  96, 99
    MOVE G6A,86,  82, 145,  83, 107
    MOVE G6B,100, 130, 120, , , 70
    MOVE G6C,185,  40,  10	
    WAIT

    SPEED 4
    MOVE G6D,112,  82, 139,  86, 84
    MOVE G6A,80,  79, 145,  83, 122
    MOVE G6B,120, 50, 70, , , 100
    MOVE G6C,185,  30,  10	
    WAIT


    '****************************
    SPEED 4
    MOVE G6A,108,  78, 119,  136, 99
    MOVE G6D,86,  65, 145,  123, 107
    MOVE G6B,120, 40, 80, , , 110
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,120, 20, 80, , , 120
    MOVE G6C,175,  40,  10	
    WAIT

    SPEED 4
    MOVE G6A,108,  78, 119,  136, 99
    MOVE G6D,86,  65, 145,  123, 107
    MOVE G6B,120, 40, 80, , , 90
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,120, 20, 80, , , 70
    MOVE G6C,190,  20,  10	
    WAIT

    '****************************
    SPEED 4
    MOVE G6A,108,  95, 119,  96, 99
    MOVE G6D,86,  82, 145,  83, 107
    MOVE G6B,100, 40, 90, , , 80
    MOVE G6C,185,  20,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,100, 80, 95, , , 70
    MOVE G6C,175,  40,  10	
    WAIT

    SPEED 3
    MOVE G6D,108,  95, 119,  96, 99
    MOVE G6A,86,  82, 145,  83, 107
    MOVE G6B,70, 130, 120, , , 110
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6D,108,  86, 139,  76, 90
    MOVE G6A,85,  83, 145,  73, 122
    MOVE G6B,150, 40, 70, , , 120
    MOVE G6C,190,  30,  10	
    WAIT


    SPEED 5
    FOR I = 0 TO 2
        MOVE G6B,150, 40, 70, , , 110
        MOVE G6C,190,  20,  10	
        WAIT
        MOVE G6B,150, 40, 70, , , 90
        MOVE G6C,185,  30,  10	
        WAIT
    NEXT I

    '****************************
    SPEED 4
    MOVE G6A,108,  78, 119,  136, 99
    MOVE G6D,86,  65, 145,  123, 107
    MOVE G6B,120, 40, 80, , , 110
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,112,  83, 139,  86, 84
    MOVE G6D,80,  80, 145,  83, 122
    MOVE G6B,190, 20, 80, , , 120
    MOVE G6C,175,  40,  10	
    WAIT

    SPEED 4
    MOVE G6D,105,  102, 119,  76, 99
    MOVE G6A,87,  89, 145,  63, 107
    MOVE G6B,80, 150, 120, , , 50
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6D,100,  82, 139,  91, 84
    MOVE G6A,95,  104, 105,  102, 122
    MOVE G6B,150, 100, 90, , , 60
    MOVE G6C,185,  20,  10	
    WAIT

    SPEED 4
    FOR I = 0 TO 2
        MOVE G6B,150, 100, 90, , ,70
        MOVE G6C,190,  20,  10	
        WAIT
        MOVE G6B,190, 100, 90, , ,90
        MOVE G6C,185,  30,  10	
        WAIT
    NEXT I

    '************
    SPEED 3
    MOVE G6D,100,  72, 139,  101, 84
    MOVE G6A,95,  114, 105,  92, 122
    MOVE G6B,150, 100, 90, , , 120
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,100,  72, 139,  101, 84
    MOVE G6D,95,  114, 105,  92, 122
    MOVE G6B,150, 100, 90, , , 60
    MOVE G6C,185,  30,  10	
    WAIT
    '****************
    SPEED 3
    MOVE G6D,100,  72, 139,  101, 84
    MOVE G6A,95,  114, 105,  92, 122
    MOVE G6B,150, 70, 80, , , 90
    MOVE G6C,185,  30,  10	
    WAIT

    SPEED 4
    MOVE G6A,100,  72, 139,  101, 84
    MOVE G6D,95,  114, 105,  92, 122
    MOVE G6B,120, 130, 120, , , 60
    MOVE G6C,185,  30,  10	
    WAIT
    '************
    SPEED 3
    MOVE G6A,98,  87, 145,  63, 103, 100
    MOVE G6D,98,  87, 145,  63, 103, 100
    MOVE G6B,60, 180, 110, , , 100
    MOVE G6C,190,  30,  10	
    WAIT
    GOSUB LED_ON_OFF2
    SPEED 5
    FOR I = 0 TO 3
        MOVE G6B,, , , , , 95
        MOVE G6C,190,  40,  10	
        WAIT
        MOVE G6B,, , , , , 105
        MOVE G6C,190,  30,  10	
        WAIT    	

    NEXT I	

    '*************************

    DELAY 1000

    SPEED 8
    MOVE G6A,98,  87, 145,  63, 103, 100
    MOVE G6D,98,  87, 145,  63, 103, 100
    MOVE G6B,120,  80,  80
    MOVE G6C,120,  80,  80
    WAIT

    GOSUB Leg_motor_mode1
    SPEED 7
    MOVE G6A,102,  76, 145,  93, 98, 100
    MOVE G6D,102,  76, 145,  93, 98, 100
    WAIT

    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    GOSUB bow3

    RETURN

    '************************************************

korea_comic_dance:

    GOSUB All_motor_mode3


    '**********

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6B,130,  60,  90
    MOVE G6C,160,  30,  80
    WAIT

    SPEED 12
    MOVE G6A, 85,  80, 140, 95, 114
    MOVE G6D,110,  76, 145,  93, 98
    MOVE G6B,150,  80,  90
    MOVE G6C,185,  15,  15	
    WAIT


    SPEED 12
    MOVE G6A, 80,  74, 145, 94, 116
    MOVE G6D,108,  81, 135,  98, 98
    MOVE G6B,180,  90, 90
    MOVE G6C,185,  15,  15	
    WAIT

    SPEED 6
    MOVE G6A,100,  96, 105,  113, 110
    MOVE G6D,85,  76, 145,  93, 105
    MOVE G6B,180,  90, 90
    MOVE G6C,185,  15,  15	
    WAIT	

    DELAY 300

    FOR i = 1 TO 2

        SPEED 4
        MOVE G6D,100,  96, 105,  113, 110
        MOVE G6A,85,  76, 145,  93, 105
        MOVE G6B,180,  90, 90
        MOVE G6C,185,  15,  15	
        WAIT	


        SPEED 4
        MOVE G6A,100,  96, 105,  113, 110
        MOVE G6D,85,  76, 145,  93, 105
        MOVE G6B,180,  90, 90
        MOVE G6C,185,  15,  15	
        WAIT

    NEXT i

    DELAY 300

    SPEED 8
    MOVE G6D,100,  96, 105,  113, 110
    MOVE G6A,85,  76, 145,  93, 105
    MOVE G6C,180,  90, 90
    MOVE G6B,185,  15,  15	
    WAIT	

    FOR i = 1 TO 2

        SPEED 4
        MOVE G6A,100,  96, 105,  113, 110
        MOVE G6D,85,  76, 145,  93, 105
        MOVE G6C,180,  90, 90
        MOVE G6B,185,  15,  15	
        WAIT

        SPEED 4
        MOVE G6D,100,  96, 105,  113, 110
        MOVE G6A,85,  76, 145,  93, 105
        MOVE G6C,180,  90, 90
        MOVE G6B,185,  15,  15	
        WAIT	

    NEXT i


    DELAY 300

    SPEED 10
    MOVE G6D,95,  80, 130,  110, 105
    MOVE G6A,95,  80, 130,  110, 105
    MOVE G6C,100,  70, 80
    MOVE G6B,100,  70,  80	
    WAIT		

    GOSUB Leg_motor_mode1
    SPEED 7
    MOVE G6A,102,  76, 145,  93, 98, 100
    MOVE G6D,102,  76, 145,  93, 98, 100
    WAIT

    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN
    '************************************************
come_on_action:
    GOSUB All_motor_mode3

    SPEED 10
    MOVE G6B,100,  40,  80
    MOVE G6C,180,  30,  80
    WAIT


    SPEED 15
    FOR i = 1 TO 3
        MOVE G6B,80,  40,  90
        MOVE G6C,185,  15,  80	
        WAIT

        MOVE G6B,80,  40,  90
        MOVE G6C,185,  15,  20	
        WAIT
    NEXT i

    SPEED 10
    MOVE G6B,80,  40,  90
    MOVE G6C,185,  25,  90	
    WAIT
    DELAY 400

    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN

    '************************************************

    '************************************************
    '************************************************
    '************************************************
    '************************************************

arm_pose_copy:
    GOSUB Arm_motor_mode3
    SPEED 10
    MOVE G6C,100,  70,  100
    WAIT

    MOTOROFF G6C	
    SPEED 15

    TEMPO 230
    MUSIC "cde"	

    DELAY 1000

arm_pose_copy_1:

    'right arm read
    S12 = MOTORIN(12)
    S13 = MOTORIN(13)
    S14 = MOTORIN(14)

    'left arm copy
    SERVO 6,S12
    SERVO 7,S13
    SERVO 8,S14


    ERX 4800,A,arm_pose_copy_1
    IF A = 26 THEN
        TEMPO 230
        MUSIC "cdefgab"

        GOSUB MOTOR_ON
        SPEED 5
        GOSUB standard_pose

        GOTO RX_EXIT
    ENDIF	


    GOTO arm_pose_copy_1
    '******************************************
matrix:
    SPEED 10
    GOSUB standard_pose
    GOSUB All_motor_mode3

    SPEED 8

    MOVE G6A, 100, 163,  75,  15, 100, 100
    MOVE G6D, 100, 163,  75,  15, 100, 100
    MOVE G6B,185, 120, 130, 100, 100, 100
    MOVE G6C,185, 120, 130, 100, 100, 100
    WAIT

    SPEED 2

    MOVE G6A, 100, 168,  70,  10, 100, 100
    MOVE G6D, 100, 168,  70,  10, 100, 100
    MOVE G6B,185, 120, 130
    MOVE G6C,185, 120, 130
    WAIT

    DELAY 1000
    SPEED 10
    FOR I = 1 TO 5

        MOVE G6B,185, 20, 50
        MOVE G6C,185, 20, 50
        WAIT

        MOVE G6B,185, 70, 80
        MOVE G6C,185, 70, 80
        WAIT

    NEXT I

    MOVE G6B,100, 70, 80
    MOVE G6C,100, 70, 80
    WAIT

    SPEED 10
    FOR I = 1 TO 5

        MOVE G6B,100, 90, 90
        MOVE G6C,100, 90, 90
        WAIT

        MOVE G6B,100, 40, 70
        MOVE G6C,100, 40, 70
        WAIT

    NEXT I

    DELAY 500
    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A, 100, 145,  70,  80, 100, 100
    MOVE G6D, 100, 145,  70,  80, 100, 100
    MOVE G6B,100, 40, 90, 100, 100, 100
    MOVE G6C,100, 40, 90, 100, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100, 121,  80, 110, 101, 100
    MOVE G6D,100, 121,  80, 110, 101, 100
    MOVE G6B,100,  40,  80, , ,
    MOVE G6C,100,  40,  80, , ,
    WAIT

    SPEED 8
    GOSUB standard_pose
    RETURN
    '******************************************
continue_dance1: '48 sec
    GOSUB SOUND_BGM10
    GOSUB cheer
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB right_foot_sit_standup
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB left_foot_sit_standup
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB back_dancer2
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB korea_old_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB bow3
    GOSUB SOUND_STOP
    GOTO RX_EXIT


    '******************************************
continue_dance2: '80 sec
    GOSUB SOUND_BGM7
    GOSUB matrix
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB breathing
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB korea_comic_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB flying_stand
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB soar
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB twist_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    GOSUB bow2
    GOSUB SOUND_STOP
    GOTO RX_EXIT
    '******************************************
total_dance1: ' sec
    GOSUB SOUND_robolink_title_song

    GOSUB bow3	
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN

    GOSUB loser_action2
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB back_dancer2
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB korea_old_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500

    '*********************
    GOSUB breathing
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB flying
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB korea_comic_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB right_foot_sit_standup
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB arirang_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB flying_stand
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB matrix
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB soar
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB twist_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 300

    '  GOSUB chanson_dance
    '    DELAY 500

    GOSUB hand_standing
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 200

    GOSUB bow2

    GOSUB SOUND_STOP
    GOTO RX_EXIT
    '******************************************
total_dance2: '46 sec
    DANCE_check = 0
    GOSUB SOUND_MUSIC42
    GOSUB chanson_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB hug
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB back_dancer2
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB loser_action1
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB arirang_dance
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB flying
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 300
    GOSUB dice_game
    GOSUB DANCE_STOP
    IF DANCE_check = 1 THEN GOTO STOP_MAIN
    DELAY 500
    GOSUB bow3
    GOTO RX_EXIT
    '******************************************
total_dance3: '
    GOSUB SOUND_BGM5
    GOSUB chanson_dance
    GOSUB SOUND_STOP

    GOTO RX_EXIT
    '******************************************
cup_catch:
    GOSUB All_motor_mode3
    SPEED 8
    MOVE G6A,100,  76, 145,  90, 100, 100
    MOVE G6D,100,  76, 145,  90, 100, 100
    MOVE G6B,190,  30,  80
    MOVE G6C,190,  30,  80
    WAIT

    SPEED 8
    MOVE G6A,100, 143,  28, 135, 190, 100
    MOVE G6D,100, 143,  28, 135, 190, 100
    MOVE G6B,190,  30,  80
    MOVE G6C,190,  30,  80
    WAIT


    DELAY 1000
    SPEED 8
    MOVE G6A,100, 143,  28, 90, 190, 100
    MOVE G6D,100, 143,  28, 90, 190, 100
    MOVE G6B,180,  30,  80
    MOVE G6C,180,  30,  80
    WAIT

    SPEED 8
    MOVE G6B,170,  20,  40
    MOVE G6C,170,  20,  40
    WAIT
    DELAY 500


    SPEED 8
    MOVE G6A,100, 143,  28, 135, 190, 100
    MOVE G6D,100, 143,  28, 135, 190, 100
    MOVE G6B,190,  20,  40
    MOVE G6C,190,  20,  40
    WAIT

    SPEED 6
    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  90, 100, 100
    MOVE G6D,100,  76, 145,  90, 100, 100
    WAIT


    RETURN

    '************************************************
thing_catch:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A,100,  33, 188,  155, 100
    MOVE G6D,100,  33, 188,  155, 100
    MOVE G6B,185,  35,  80
    MOVE G6C,185,  35,  80
    WAIT

    '****************
    MOVE G6B,185,  15,  60
    MOVE G6C,185,  15,  60
    WAIT

    SPEED 4
    MOVE G6A,100,  33, 170,  155, 100
    MOVE G6D,100,  33, 170,  155, 100
    WAIT

    SPEED 5
    MOVE G6A,100,  60, 150,  115, 100
    MOVE G6D,100,  60, 150,  115, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOSUB All_motor_Reset
    thing_catch_state = 1
    RETURN
    '************************************************
    '************************************************
thing_lay:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A,100,  35, 170,  155, 100
    MOVE G6D,100,  35, 170,  155, 100
    WAIT

    DELAY 300

    MOVE G6B,185,  40,  80
    MOVE G6C,185,  40,  80
    WAIT

    SPEED 5
    MOVE G6A,100,  65, 150,  105, 100
    MOVE G6D,100,  65, 150,  105, 100
    MOVE G6B,140,  40,  80
    MOVE G6C,140,  40,  80
    WAIT


    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset
    thing_catch_state = 0
    RETURN
    '************************************************
    '******************************************
front_two_hands_punch:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A, 92, 100, 110, 100, 107
    MOVE G6D, 92, 100, 110, 100, 107
    MOVE G6B,185, 130,  15
    MOVE G6C,185, 130,  15
    WAIT

    SPEED 10
    MOVE G6B,185, 50,  15
    MOVE G6C,185, 50,  15
    WAIT

    SPEED 13
    FOR I = 0 TO 1
        MOVE G6B,185,  10, 80
        MOVE G6C,185, 80,  10
        WAIT
        DELAY 200
        MOVE G6B,185, 80,  10
        MOVE G6C,185,  10, 80
        WAIT
        DELAY 200

    NEXT I

    MOVE G6A, 92, 100, 113, 100, 107
    MOVE G6D, 92, 100, 113, 100, 107
    MOVE G6B,185, 130,  10
    MOVE G6C,185, 130,  10
    WAIT

    HIGHSPEED SETOFF
    SPEED 12
    MOVE G6A, 102, 100, 113, 100, 98
    MOVE G6D, 102, 100, 113, 100, 98
    MOVE G6B,100,  80,  60
    MOVE G6C,100,  80,  60
    WAIT

    GOSUB standard_pose

    GOTO RX_EXIT
    ''**********************************************

    '******************************************
front_up_punch:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,98,  70, 146,  103, 100
    MOVE G6D,98,  70, 146,  103, 100
    MOVE G6B,133, 30,  80
    MOVE G6C,133, 30,  80
    WAIT

    SPEED 10
    MOVE G6B,133, 15,  70
    MOVE G6C,133, 15,  70
    WAIT

    SPEED 13
    MOVE G6A,98,  77, 146,  73, 100
    MOVE G6D,98,  77, 146,  73, 100
    MOVE G6B,185, 15,  70
    MOVE G6C,185, 15,  70
    WAIT

    HIGHSPEED SETOFF
    DELAY 1000

    SPEED 12
    MOVE G6A,98,  70, 146,  103, 100
    MOVE G6D,98,  70, 146,  103, 100
    MOVE G6B,133, 30,  80
    MOVE G6C,133, 30,  80
    WAIT

    SPEED 10
    GOSUB standard_pose

    GOTO RX_EXIT
    ''**********************************************
    '******************************************
back_up_punch:
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,98,  79, 146,  83, 100
    MOVE G6D,98,  79, 146,  83, 100
    MOVE G6B,80, 30,  80
    MOVE G6C,80, 30,  80
    WAIT

    SPEED 10
    MOVE G6B,80, 20,  70
    MOVE G6C,80, 20,  70
    WAIT

    SPEED 13
    MOVE G6A,98,  68, 146,  118, 100
    MOVE G6D,98,  68, 146,  118, 100
    MOVE G6B,15, 10,  70
    MOVE G6C,15, 10,  70
    WAIT

    HIGHSPEED SETOFF
    DELAY 1000

    SPEED 12
    MOVE G6A,98,  68, 146,  103, 100
    MOVE G6D,98,  68, 146,  103, 100
    MOVE G6B,80, 30,  80
    MOVE G6C,80, 30,  80
    WAIT

    SPEED 8
    GOSUB standard_pose

    GOTO RX_EXIT
    ''**********************************************
left_front_punch:
    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,185,  80,  20
    MOVE G6C,50,  40,  80
    WAIT

    SPEED 10
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,185,  80,  20
    MOVE G6C,50,  40,  80
    WAIT
    GOSUB All_motor_Reset
    SPEED 12
    HIGHSPEED SETON

    MOVE G6A,95,  84, 105, 126,  105,
    MOVE G6D, 86, 110, 136,  69, 114,
    MOVE G6B, 189,  30,  80
    MOVE G6C,  50,  40,  80
    WAIT

    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 12
    MOVE G6A,93,  80, 130, 110,  105,
    MOVE G6D, 93, 80, 130,  110, 105,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 6
    MOVE G6A,101,  80, 130, 110,  98,
    MOVE G6D, 101, 80, 130,  110, 98,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
    ''**********************************************
right_front_punch:
    GOSUB Leg_motor_mode3
    SPEED 15
    MOVE G6A,108,  76, 146,  93,  92
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6B,50,  40,  80
    MOVE G6C,185,  80,  20
    WAIT

    SPEED 10
    MOVE G6A,112,  76, 146,  93, 98
    MOVE G6D, 85,  80, 140, 95, 114
    MOVE G6B,50,  40,  80
    MOVE G6C,185,  80,  20
    WAIT
    GOSUB All_motor_Reset
    SPEED 12
    HIGHSPEED SETON

    MOVE G6A, 86, 110, 136,  69, 114,
    MOVE G6D,95,  84, 105, 126,  105,
    MOVE G6B,  50,  40,  80
    MOVE G6C, 189,  30,  80
    WAIT

    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 12
    MOVE G6A, 93, 80, 130,  110, 105,
    MOVE G6D,93,  80, 130, 110,  105,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT

    SPEED 6
    MOVE G6A, 101, 80, 130,  110, 98,
    MOVE G6D,101,  80, 130, 110,  98,
    MOVE G6B, 100,  40,  80
    MOVE G6C, 100,  40,  80
    WAIT
    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
    ''**********************************************
left_side_punch:
    HIGHSPEED SETON
    GOSUB Leg_motor_mode3
    SPEED 8
    MOVE G6D,108,  76, 146,  93,  92
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6C,100,  60,  90, , ,
    MOVE G6B,100,  170,  15, , ,
    WAIT

    GOSUB All_motor_Reset

    SPEED 8
    MOVE G6D,110,  76, 146,  93,  92
    MOVE G6A, 88,  85, 130,  100, 110
    MOVE G6C,100,  60,  90, , ,
    MOVE G6B,100,  170,  45, , ,
    WAIT

    SPEED 13
    MOVE G6D, 63, 76,  160, 85, 130	
    MOVE G6A, 88, 125,  70, 120, 115
    MOVE G6C,100,  70,  100
    MOVE G6B,100, 125, 108
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 15

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
    ''**********************************************
right_side_punch:
    HIGHSPEED SETON
    GOSUB Leg_motor_mode3
    SPEED 8
    MOVE G6A,108,  76, 146,  93,  92
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6B,100,  60,  90, , ,
    MOVE G6C,100,  170,  15, , ,
    WAIT

    GOSUB All_motor_Reset

    SPEED 8
    MOVE G6A,110,  76, 146,  93,  92
    MOVE G6D, 88,  85, 130,  100, 110
    MOVE G6B,100,  60,  90, , ,
    MOVE G6C,100,  170,  45, , ,
    WAIT

    SPEED 13
    MOVE G6A, 63, 76,  160, 85, 130	
    MOVE G6D, 88, 125,  70, 120, 115
    MOVE G6B,100,  70,  100
    MOVE G6C,100, 125, 108
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF
    SPEED 15

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOTO RX_EXIT
    ''**********************************************
    '**********************************************
left_side_back_punch:

    HIGHSPEED SETON
    SPEED 12
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,15,  40,  80
    MOVE G6C,115,  40,  80
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT

    SPEED 12
    GOSUB standard_pose

    GOTO RX_EXIT

    '**********************************************
right_side_back_punch:


    HIGHSPEED SETON
    SPEED 12
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,115,  40,  80
    MOVE G6C,15,  40,  80
    WAIT


    DELAY 1000
    HIGHSPEED SETOFF

    SPEED 15
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 12
    GOSUB standard_pose
    GOTO RX_EXIT


    '************************************************
    '************************************************
scissors:
    GOSUB SOUND_scissors
    GOSUB Leg_motor_mode2
    SPEED 12
    MOVE G6A,100,  96, 145,  73, 100, 100
    MOVE G6D,100,  56, 145,  113, 100, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    DELAY 1000

    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset
    RETURN

    '************************************************
rock:
    GOSUB SOUND_rock
    GOSUB Leg_motor_mode2
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  60,  50
    MOVE G6C,100,  60,  50
    WAIT

    DELAY 1000

    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset

    RETURN

    '************************************************
paper:
    GOSUB SOUND_paper
    GOSUB Leg_motor_mode2
    SPEED 12
    MOVE G6A,91,  76, 145,  93, 108
    MOVE G6D,91,  76, 145,  93, 108
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT

    DELAY 1000

    SPEED 5
    MOVE G6A,101,  76, 145,  93, 98
    MOVE G6D,101,  76, 145,  93, 98
    WAIT

    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset
    RETURN

    '************************************************
blue_white_flag_pose:
    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,100,  76, 145,  88, 100
    MOVE G6D,100,  76, 145,  88, 100
    MOVE G6B,135,  35,  80
    MOVE G6C,135,  35,  80
    WAIT

    RETURN
    '************************************************

blue_left_up:
    GOSUB SOUND_blue_up
    SPEED 15
    MOVE G6B,165
    WAIT
    MOVE G6B,135
    WAIT
    RETURN
    '************************************************
blue_left_down:
    GOSUB SOUND_blue_down
    SPEED 15
    MOVE G6B,105
    WAIT
    MOVE G6B,135
    WAIT
    RETURN
    '************************************************
white_right_up:
    GOSUB SOUND_white_up
    SPEED 15
    MOVE G6C,165
    WAIT
    MOVE G6C,135
    WAIT
    RETURN
    '************************************************
white_right_down:
    GOSUB SOUND_white_down
    SPEED 15
    MOVE G6C,105
    WAIT
    MOVE G6C,135
    WAIT

    RETURN
    '************************************************
dice_game:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A,100,  30, 188,  155, 100
    MOVE G6D,100,  30, 188,  155, 100
    MOVE G6B,185,  30,  80
    MOVE G6C,185,  30,  80
    WAIT

    MOVE G6B,185,  15,  65
    MOVE G6C,185,  15,  65
    WAIT

    SPEED 4
    MOVE G6A,100,  30, 170,  155, 100
    MOVE G6D,100,  30, 170,  155, 100
    WAIT

    SPEED 5
    MOVE G6A,100,  60, 150,  115, 100
    MOVE G6D,100,  60, 150,  115, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  74, 145,  85, 100
    MOVE G6D,100,  74, 145,  85, 100
    WAIT


    TEMP = RND
    TEMP = TEMP MOD 3

    IF TEMP = 0 THEN

        SPEED 4
        MOVE G6B,135,  13,  50
        MOVE G6C,188,  13,  50
        WAIT

        SPEED 15
        MOVE G6C,188,  60,  50
        MOVE G6B,165,  13,  50
        WAIT

    ELSEIF TEMP = 1 THEN

        SPEED 4
        MOVE G6C,135,  13,  50
        MOVE G6B,188,  13,  50
        WAIT

        SPEED 15
        MOVE G6B,188,  60,  50
        MOVE G6C,165,  13,  50
        WAIT

    ELSE

        SPEED 15
        MOVE G6B,188,  50,  65
        MOVE G6C,188,  50,  65
        WAIT

    ENDIF


    DELAY 1000

    SPEED 10
    MOVE G6B,140,  70,  80
    MOVE G6C,140,  70,  80
    WAIT


    SPEED 4
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOSUB All_motor_Reset
    RETURN
    '************************************************
    '************************************************
cup_throw_game:
    GOSUB All_motor_mode3
    SPEED 5
    MOVE G6A,100,  30, 188,  155, 100
    MOVE G6D,100,  30, 188,  155, 100
    MOVE G6B,185,  30,  80
    MOVE G6C,185,  30,  80
    WAIT

    MOVE G6B,185,  15,  65
    MOVE G6C,185,  15,  65
    WAIT

    SPEED 4
    MOVE G6A,100,  30, 170,  155, 100
    MOVE G6D,100,  30, 170,  155, 100
    WAIT

    SPEED 5
    MOVE G6A,100,  60, 150,  115, 100
    MOVE G6D,100,  60, 150,  115, 100
    WAIT

    SPEED 6
    MOVE G6A,100,  74, 145,  85, 100
    MOVE G6D,100,  74, 145,  85, 100
    WAIT

    DELAY 500

    SPEED 10
    MOVE G6B,188,  50,  65
    MOVE G6C,188,  50,  65
    WAIT

    DELAY 1000

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT

    GOSUB All_motor_Reset
    RETURN
    '************************************************

    '************************************************
    '********************************************
    '********************************************

penalty_left:
    SPEED 10

    '*************
    MOVE G6A,90,  78, 155,  103, 100, 100
    MOVE G6D,90,  66, 140,  83, 100, 100
    WAIT

    DELAY 20	
    SPEED 15
    MOVE G6A,100,  76, 146,  93, 100, 100
    MOVE G6D,100,  76, 146,  93, 100, 100
    WAIT

    DELAY 200	
    '*************
    GOTO RX_EXIT

    '************************************************
    '************************************************

penalty_right:
    SPEED 10

    '*************
    MOVE G6D,90,  78, 155,  103, 100, 100
    MOVE G6A,90,  66, 140,  83, 100, 100
    WAIT

    DELAY 20	
    SPEED 15
    MOVE G6D,100,  76, 146,  93, 100, 100
    MOVE G6A,100,  76, 146,  93, 100, 100
    WAIT

    DELAY 200	
    '*************
    GOTO RX_EXIT
    '************************************************
    '************************************************
stairs_left_up_3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A, 90, 100, 110, 100, 114
    MOVE G6D,113,  78, 146,  93,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6A, 90, 140, 35, 130, 114
    MOVE G6D,113,  73, 155,  90,  94
    WAIT


    SPEED 12
    MOVE G6A,  80, 40, 115, 160, 114,
    MOVE G6D,113,  70, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 7
    MOVE G6A, 105, 70, 100, 160, 100,
    MOVE G6D,80,  90, 165,  70, 100
    MOVE G6B,160,50
    MOVE G6C,160,40
    WAIT

    SPEED 6
    MOVE G6A, 113, 90, 80, 160,95,
    MOVE G6D,70,  95, 165,  65, 105
    MOVE G6B,180,50
    MOVE G6C,180,30
    WAIT

    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 8
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,75,  90, 165,  70, 105
    WAIT

    SPEED 12
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,90,  120, 40,  140, 108
    WAIT

    SPEED 10
    MOVE G6A, 114, 90, 110, 130,95,
    MOVE G6D,90,  95, 90,  145, 108
    MOVE G6B,140,50
    MOVE G6C,140,30
    WAIT

    SPEED 10
    MOVE G6A, 110, 90, 110, 130,95,
    MOVE G6D,80,  85, 110,  135, 108
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 5
    MOVE G6D, 98, 90, 110, 125,99,
    MOVE G6A,98,  90, 110,  125, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 6
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    '****************************************

stairs_right_up_3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6A,108,  76, 146,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6D, 90, 100, 110, 100, 114
    MOVE G6A,113,  78, 146,  93,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6D, 90, 140, 35, 130, 114
    MOVE G6A,113,  73, 155,  90,  94
    WAIT


    SPEED 12
    MOVE G6D,  80, 40, 115, 160, 114,
    MOVE G6A,113,  70, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 7
    MOVE G6D, 105, 70, 100, 160, 100,
    MOVE G6A,80,  90, 165,  70, 100
    MOVE G6C,160,50
    MOVE G6B,160,40
    WAIT

    SPEED 6
    MOVE G6D, 113, 90, 80, 160,95,
    MOVE G6A,70,  95, 165,  65, 105
    MOVE G6C,180,50
    MOVE G6B,180,30
    WAIT

    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 8
    MOVE G6D, 114, 90, 100, 150,95,
    MOVE G6A,75,  90, 165,  70, 105
    WAIT

    SPEED 12
    MOVE G6D, 114, 90, 100, 150,95,
    MOVE G6A,90,  120, 40,  140, 108
    WAIT

    SPEED 10
    MOVE G6D, 114, 90, 110, 130,95,
    MOVE G6A,90,  95, 90,  145, 108
    MOVE G6C,140,50
    MOVE G6B,140,30
    WAIT

    SPEED 10
    MOVE G6D, 110, 90, 110, 130,95,
    MOVE G6A,80,  85, 110,  135, 108
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 5
    MOVE G6D, 98, 90, 110, 125,99,
    MOVE G6A,98,  90, 110,  125, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 6
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    '********************************************	

    '************************************************
stairs_left_down_3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 145,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A, 90, 100, 115, 105, 114
    MOVE G6D,113,  76, 145,  93,  94
    WAIT

    GOSUB Leg_motor_mode2


    SPEED 12
    MOVE G6A,  80, 30, 155, 150, 114,
    MOVE G6D,113,  65, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6A,  80, 30, 175, 150, 114,
    MOVE G6D,113,  115, 65,  140,  94
    MOVE G6B,70,50
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,90, 20, 150, 150, 110
    MOVE G6D,110,  155, 35,  120,94
    MOVE G6B,100,50
    MOVE G6C,140,40
    WAIT

    '****************************

    SPEED 8
    MOVE G6A,100, 30, 150, 150, 100
    MOVE G6D,100,  155, 70,  100,100
    MOVE G6B,140,50
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A,114, 70, 130, 150, 94
    MOVE G6D,80,  125, 140,  85,114
    MOVE G6B,170,50
    MOVE G6C,100,40
    WAIT

    GOSUB Leg_motor_mode2	
    SPEED 10
    MOVE G6A,114, 70, 130, 150, 94
    MOVE G6D,80,  125, 50,  150,114
    WAIT

    SPEED 9
    MOVE G6A,114, 75, 130, 120, 94
    MOVE G6D,80,  85, 90,  150,114
    WAIT

    SPEED 8
    MOVE G6A,112, 80, 130, 110, 94
    MOVE G6D,80,  75,130,  115,114
    MOVE G6B,130,50
    MOVE G6C,100,40
    WAIT

    SPEED 6
    MOVE G6D, 98, 80, 130, 105,99,
    MOVE G6A,98,  80, 130,  105, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 4
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    '****************************************
    '************************************************
stairs_right_down_3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6A,108,  76, 145,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6D, 90, 100, 115, 105, 114
    MOVE G6A,113,  76, 145,  93,  94
    WAIT

    GOSUB Leg_motor_mode2


    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114,
    MOVE G6A,113,  65, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6D,  80, 30, 175, 150, 114,
    MOVE G6A,113,  115, 65,  140,  94
    MOVE G6B,70,50
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6D,90, 20, 150, 150, 110
    MOVE G6A,110,  155, 35,  120,94
    MOVE G6C,100,50
    MOVE G6B,140,40
    WAIT

    '****************************

    SPEED 8
    MOVE G6D,100, 30, 150, 150, 100
    MOVE G6A,100,  155, 70,  100,100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT

    SPEED 10
    MOVE G6D,114, 70, 130, 150, 94
    MOVE G6A,80,  125, 140,  85,114
    MOVE G6C,170,50
    MOVE G6B,100,40
    WAIT

    GOSUB Leg_motor_mode2	
    SPEED 10
    MOVE G6D,114, 70, 130, 150, 94
    MOVE G6A,80,  125, 50,  150,114
    WAIT

    SPEED 9
    MOVE G6D,114, 75, 130, 120, 94
    MOVE G6A,80,  85, 90,  150,114
    WAIT

    SPEED 8
    MOVE G6D,112, 80, 130, 110, 94
    MOVE G6A,80,  75,130,  115,114
    MOVE G6C,130,50
    MOVE G6B,100,40
    WAIT

    SPEED 6
    MOVE G6D, 98, 80, 130, 105,99,
    MOVE G6A,98,  80, 130,  105, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 4
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN
    '************************************************
    '************************************************

    '************************************************
left_hand_side_up:

    SPEED 15
    MOVE G6B,,100
    WAIT

    GOSUB standard_pose
    RETURN
    '**********************************************
right_hand_side_up:
    SPEED 15
    MOVE G6C,,100
    WAIT

    GOSUB standard_pose
    RETURN
    '**********************************************
leeper_left:

    HIGHSPEED SETON
    SPEED 7
    MOVE G6D,65, 85,  120, 110, 90, 100
    MOVE G6A,110, 143,  28, 142, 130, 100
    MOVE G6B,185,  100,  80
    MOVE G6C,185,  100,  80
    WAIT

    DELAY 2000
    HIGHSPEED SETOFF
    SPEED 10
    GOSUB sit_pose
    SPEED 8
    GOSUB standard_pose


    RETURN
    '**********************************************
leeper_right:

    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,65, 85,  120, 110, 90, 100
    MOVE G6D,110, 143,  28, 142, 130, 100
    MOVE G6B,185,  100,  80
    MOVE G6C,185,  100,  80
    WAIT

    DELAY 2000
    HIGHSPEED SETOFF
    SPEED 10
    GOSUB sit_pose
    SPEED 8
    GOSUB standard_pose

    RETURN
    '**********************************************
leeper_front:

    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,80, 143,  28, 142, 118, 100
    MOVE G6D,80, 143,  28, 142, 118, 100
    MOVE G6B,100,  60,  80, 100, 100, 100
    MOVE G6C,100,  60,  80, 100, 100, 100
    WAIT

    DELAY 2000
    HIGHSPEED SETOFF
    SPEED 8
    GOSUB standard_pose

    RETURN
    '**********************************************

    '**********************************************

throw_right:
    GOSUB All_motor_mode3
    SPEED 7
    MOVE G6A,100,  76, 145,  95, 100
    MOVE G6D,100,  76, 145,  95, 100
    MOVE G6B,100,  185,  110
    MOVE G6C,100,  185,  110
    WAIT

    GOSUB GOSUB_RX_EXIT
throw_right_1:
    ERX 4800, A, throw_right_1
    '****************
    SPEED 4
    MOVE G6B,,  ,  135
    MOVE G6C,,  ,  135
    WAIT

    DELAY 500
    GOSUB GOSUB_RX_EXIT	

throw_right_2:
    ERX 4800, A, throw_right_2
    IF A = 26 THEN
        SPEED 10
        GOSUB standard_pose
        GOSUB All_motor_Reset	
        GOTO RX_EXIT
    ELSEIF A = 4 THEN
        GOTO throw_left_3
    ELSEIF A = 5 THEN
        GOTO throw_front_3
    ELSEIF A = 6 THEN
        GOTO throw_right_3
    ENDIF
throw_right_3:
    GOSUB Leg_motor_mode2
    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    WAIT

    SPEED 8
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    WAIT


    SPEED 6
    MOVE G6A,100,  96, 125,  85, 100
    MOVE G6D,100,  96, 125,  85, 100
    MOVE G6B,135,  ,
    MOVE G6C,135,  ,
    WAIT

    GOSUB All_motor_Reset
    HIGHSPEED SETON

    SPEED 12
    MOVE G6A,100,  66, 145,  115, 100
    MOVE G6D,100,  66, 145,  115, 100
    MOVE G6B,75,  , 125
    MOVE G6C,75,  , 125
    WAIT	

    DELAY 800
    HIGHSPEED SETOFF

    GOSUB All_motor_mode3
    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN
    RETURN
    '**********************************************
throw_left:
    GOSUB All_motor_mode3
    SPEED 7
    MOVE G6A,100,  76, 145,  95, 100
    MOVE G6D,100,  76, 145,  95, 100
    MOVE G6B,100,  185,  110
    MOVE G6C,100,  185,  110
    WAIT

    GOSUB GOSUB_RX_EXIT
throw_left_1:
    ERX 4800, A, throw_left_1
    '****************
    SPEED 4
    MOVE G6B,,  ,  135
    MOVE G6C,,  ,  135
    WAIT

    DELAY 500
    GOSUB GOSUB_RX_EXIT	

throw_left_2:
    ERX 4800, A, throw_left_2
    IF A = 26 THEN
        SPEED 10
        GOSUB standard_pose
        GOSUB All_motor_Reset	
        GOTO RX_EXIT
    ELSEIF A = 4 THEN
        GOTO throw_left_3
    ELSEIF A = 5 THEN
        GOTO throw_front_3
    ELSEIF A = 6 THEN
        GOTO throw_right_3
    ENDIF
throw_left_3:
    GOSUB Leg_motor_mode2
    SPEED 6
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6A,100,  76, 145,  93, 100
    WAIT

    SPEED 8
    MOVE G6D,95,  46, 145,  123, 105, 100
    MOVE G6A,95,  106, 145,  63, 105, 100
    WAIT

    SPEED 10
    MOVE G6D,93,  46, 145,  123, 105, 100
    MOVE G6A,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6A,100,  76, 145,  93, 100
    WAIT


    SPEED 6
    MOVE G6A,100,  96, 125,  85, 100
    MOVE G6D,100,  96, 125,  85, 100
    MOVE G6B,135,  ,
    MOVE G6C,135,  ,
    WAIT	
    GOSUB All_motor_Reset
    HIGHSPEED SETON

    SPEED 12
    MOVE G6A,100,  66, 145,  115, 100
    MOVE G6D,100,  66, 145,  115, 100
    MOVE G6B,75,  , 125
    MOVE G6C,75,  , 125
    WAIT	

    DELAY 800
    HIGHSPEED SETOFF

    GOSUB All_motor_mode3
    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN
    RETURN
    '**********************************************
throw_front:
    GOSUB All_motor_mode3
    SPEED 7
    MOVE G6A,100,  76, 145,  95, 100
    MOVE G6D,100,  76, 145,  95, 100
    MOVE G6B,100,  185,  110
    MOVE G6C,100,  185,  110
    WAIT

    GOSUB GOSUB_RX_EXIT
throw_front_1:
    ERX 4800, A, throw_front_1
    '****************
    SPEED 4
    MOVE G6B,,  ,  135
    MOVE G6C,,  ,  135
    WAIT

    DELAY 500
    GOSUB GOSUB_RX_EXIT	

throw_front_2:
    ERX 4800, A, throw_front_2
    IF A = 26 THEN
        SPEED 10
        GOSUB standard_pose
        GOSUB All_motor_Reset	
        GOTO RX_EXIT
    ELSEIF A = 4 THEN
        GOTO throw_left_3
    ELSEIF A = 5 THEN
        GOTO throw_front_3
    ELSEIF A = 6 THEN
        GOTO throw_right_3
    ENDIF
throw_front_3:
    SPEED 5
    MOVE G6A,100,  96, 125,  85, 100
    MOVE G6D,100,  96, 125,  85, 100
    MOVE G6B,135,  ,
    MOVE G6C,135,  ,
    WAIT

    GOSUB All_motor_Reset
    HIGHSPEED SETON

    SPEED 12
    MOVE G6A,100,  66, 145,  115, 100
    MOVE G6D,100,  66, 145,  115, 100
    MOVE G6B,75,  , 125
    MOVE G6C,75,  , 125
    WAIT	

    DELAY 800
    HIGHSPEED SETOFF

    GOSUB All_motor_mode3
    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN
    '**********************************************
right_shoot:
    GOSUB Leg_motor_mode3
    SPEED 4
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6C, 100,40
    MOVE G6B, 100,40
    WAIT

    GOSUB Leg_motor_mode1
    HIGHSPEED SETON
    SPEED 8
    MOVE G6D, 80, 95, 115, 105, 140
    MOVE G6A,113,  78, 146,  93,  94
    MOVE G6C, 100,60
    MOVE G6B, 100,60
    WAIT

    DELAY 100
    HIGHSPEED SETOFF
    GOSUB Leg_motor_mode3
    SPEED 8
    MOVE G6A, 106,  76, 146,  93,  96		
    MOVE G6D,  88,  71, 152,  91, 106
    MOVE G6B, 100,35
    MOVE G6C, 100,35
    WAIT	

    GOSUB Leg_motor_mode3
    SPEED 3
    GOSUB standard_pose
    GOSUB Leg_motor_mode1


    RETURN
    '**********************************************
left_shoot:
    GOSUB Leg_motor_mode3
    SPEED 4
    MOVE G6A,  88,  71, 152,  91, 110
    MOVE G6D, 108,  76, 146,  93,  94
    MOVE G6B, 100,40
    MOVE G6C, 100,40
    WAIT

    GOSUB Leg_motor_mode1
    HIGHSPEED SETON

    SPEED 8
    MOVE G6A, 80, 95, 115, 105, 140
    MOVE G6D,113,  78, 146,  93,  94
    MOVE G6B, 100,60
    MOVE G6C, 100,60
    WAIT

    DELAY 100
    HIGHSPEED SETOFF
    GOSUB Leg_motor_mode3

    SPEED 8
    MOVE G6D, 106,  76, 146,  93,  96		
    MOVE G6A,  88,  71, 152,  91, 106
    MOVE G6B, 100,35
    MOVE G6C, 100,35
    WAIT	

    GOSUB Leg_motor_mode3
    SPEED 3
    GOSUB standard_pose
    GOSUB Leg_motor_mode1

    RETURN

    '**********************************************
back_shoot:
    IF walk_order = 0 THEN

        GOSUB Leg_motor_mode2
        SPEED 4

        MOVE G6A,110,  77, 145,  93,  92, 100	
        MOVE G6D, 85,  71, 152,  91, 114, 100
        MOVE G6C,100,  40,  80, , , ,
        MOVE G6B,100,  40,  80, , , ,	
        WAIT

        SPEED 10
        MOVE G6A,114,  78, 147,  85,  95	
        MOVE G6D, 83,  85, 122,  100, 114
        WAIT


        HIGHSPEED SETON

        SPEED 15
        MOVE G6A,114,  75, 147,  110,  95	
        MOVE G6D, 83,  110, 122,  75, 114
        MOVE G6B,80
        MOVE G6C,120
        WAIT


        DELAY 100
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3

        SPEED 10
        MOVE G6A,114,  74, 147,  97,  95
        MOVE G6D, 83,  85, 122,  105, 114
        MOVE G6C,100,  40,  80, , , ,
        MOVE G6B,100,  40,  80, , , ,	
        WAIT	

        SPEED 8
        MOVE G6A,113,  76, 147,  95,  95	
        MOVE G6D, 80,  76, 142,  95, 114
        MOVE G6C,100,  40,  80, , , ,
        MOVE G6B,100,  40,  80, , , ,
        WAIT	

        SPEED 8
        MOVE G6A,110,  77, 147,  93,  93, 100	
        MOVE G6D, 80,  71, 154,  91, 114, 100
        WAIT


        SPEED 3
        GOSUB standard_pose	
        GOSUB Leg_motor_mode1
        walk_order = 1
    ELSE
        GOSUB Leg_motor_mode2
        SPEED 4

        MOVE G6D,110,  77, 145,  93,  92, 100	
        MOVE G6A, 85,  71, 152,  91, 114, 100
        MOVE G6B,100,  40,  80, , , ,
        MOVE G6C,100,  40,  80, , , ,	
        WAIT

        SPEED 10
        MOVE G6D,114,  78, 147,  85,  95	
        MOVE G6A, 83,  85, 122,  100, 114
        WAIT


        HIGHSPEED SETON

        SPEED 15
        MOVE G6D,114,  75, 147,  110,  95	
        MOVE G6A, 83,  110, 122,  75, 114
        MOVE G6C,80
        MOVE G6B,120
        WAIT


        DELAY 100
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3

        SPEED 10
        MOVE G6D,114,  74, 147,  97,  95
        MOVE G6A, 83,  85, 122,  105, 114
        MOVE G6B,100,  40,  80, , , ,
        MOVE G6C,100,  40,  80, , , ,	
        WAIT	

        SPEED 8
        MOVE G6D,113,  76, 147,  95,  95	
        MOVE G6A, 80,  76, 142,  95, 114
        MOVE G6B,100,  40,  80, , , ,
        MOVE G6C,100,  40,  80, , , ,
        WAIT	

        SPEED 8
        MOVE G6D,110,  77, 147,  93,  93, 100	
        MOVE G6A, 80,  71, 154,  91, 114, 100
        WAIT


        SPEED 3
        GOSUB standard_pose	
        GOSUB Leg_motor_mode1
        walk_order = 0
    ENDIF




    RETURN

    '************************************************
RND_MOTION:

    GOSUB All_motor_mode3

RND_MOTION_LOOP:
    'FOR J = 1 TO replay_number
    public_way_check = 0



    SPEED 3
    TEMP = RND
    TEMP = TEMP MOD 80

    S11= 60 + TEMP
    SERVO 11,S11

    '***********
    TEMP = RND
    TEMP = TEMP MOD 30

    SPEED 1

    S6= 90 + TEMP
    TEMP = TEMP MOD 2
    IF TEMP = 0 THEN
        SERVO 6,S6
    ENDIF

    '***********	
    TEMP = RND
    TEMP = TEMP MOD 30

    S12= 90 + TEMP

    TEMP = TEMP MOD 2
    IF TEMP = 0 THEN
        SERVO 12,S12
    ENDIF


    '*********************************	
    FOR I = 1 TO 150
        DELAY 15' 195
        ERX 4800,A ,RND_MOTION_1
        IF A = 26 THEN	' ♂
            GOSUB SOUND_STOP
            OUT 52,0
            SPEED 5
            GOSUB standard_pose
            GOSUB All_motor_Reset
            GOSUB beep_music
            RETURN
        ELSEIF A = 21 THEN ' ♀: front
            SPEED 6
            MOVE G6B,160,  25,  70, , ,100
            MOVE G6C,160,  25,  70
            WAIT
            SPEED 8
            MOVE G6B,160,  25,  80, , ,100
            MOVE G6C,160,  25,  80
            WAIT		
            I = 1
            public_way_check = 1

        ELSEIF A = 15 THEN  ' A: left front
            SPEED 6
            MOVE G6B,160,  70,  70, , ,70
            MOVE G6C,160,  25,  70
            WAIT
            SPEED 8
            MOVE G6B,160,  50,  90, , ,55
            MOVE G6C,160,  15,  40
            WAIT
            I = 1
            public_way_check = 1

        ELSEIF A = 30 THEN  ' ⒐: right
            SPEED 6
            MOVE G6C,175,  70,  70
            MOVE G6B,160,  25,  70, , ,140
            WAIT
            SPEED 10
            MOVE G6C,175,  90,  95
            MOVE G6B,175,  15,  20, , ,170
            WAIT
            I = 1
            public_way_check = 1

        ELSEIF A = 28 THEN 	' ⒎: left
            SPEED 6
            MOVE G6B,175,  70,  70, , ,60
            MOVE G6C,160,  25,  70
            WAIT
            SPEED 10
            MOVE G6B,175,  90,  95
            MOVE G6C,175,  15,  20, , ,30
            WAIT
            I = 1
            public_way_check = 1

        ELSEIF A = 20 THEN   ' B: right front
            SPEED 6
            MOVE G6C,160,  70,  70
            MOVE G6B,160,  25,  70, , ,130
            WAIT
            SPEED 8
            MOVE G6C,160,  50,  90
            MOVE G6B,160,  15,  40, , ,145
            WAIT
            I = 1
            public_way_check = 1

        ELSEIF A = 1 THEN
            GOSUB SOUND_public1
        ELSEIF A = 2 THEN
            GOSUB SOUND_public2
        ELSEIF A = 3 THEN
            GOSUB SOUND_public3
        ELSEIF A = 4 THEN
            GOSUB SOUND_public4
        ELSEIF A = 5 THEN
            GOSUB SOUND_public5
        ELSEIF A = 6 THEN
            GOSUB SOUND_public6
        ELSEIF A = 7 THEN
            GOSUB SOUND_public7
        ELSEIF A = 8 THEN
            GOSUB SOUND_public8
        ELSEIF A = 9 THEN
            GOSUB SOUND_public9
        ENDIF

        GOSUB GOSUB_RX_EXIT


RND_MOTION_1:
        IF I < 10 THEN
            OUT 52,1
        ELSEIF I > 10 THEN
            OUT 52,0
        ENDIF
    NEXT I
    '***********

    IF public_way_check = 1 THEN
        SPEED 6
        MOVE G6B,130,  40,  80, , ,100
        MOVE G6C,130,  40,  80
        WAIT

        MOVE G6B,100,  30,  80, , ,100
        MOVE G6C,100,  30,  80
        WAIT
    ENDIF


    GOTO RND_MOTION_LOOP
    '***********************************
    SPEED 3
    GOSUB standard_pose
    GOSUB All_motor_Reset
    GOSUB beep_music

    RETURN

soar_pose:
    GOSUB All_motor_mode3

    SPEED 12
    MOVE G6A, 88,  71, 152,  91, 110, 100
    MOVE G6D,112,  76, 146,  93,  92, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT


    SPEED 10
    MOVE G6A, 90,  98, 105,  115, 115, 100
    MOVE G6D,114,  74, 145,  98,  93, 100
    MOVE G6B,100,  150,  150
    MOVE G6C,100,  150,  150
    WAIT

    SPEED 6
    MOVE G6A, 90, 121,  36, 105, 115,  100
    MOVE G6D,114,  60, 146, 138,  93,  100
    WAIT

    SPEED 6
    GOSUB Leg_motor_mode2
    MOVE G6A, 90,  98, 135,  44, 115,  100
    MOVE G6D,114,  45, 170, 160,  93,  100
    MOVE G6B,170,  120,  120 , , , 60
    MOVE G6C,170,  120,  120
    WAIT

soar_pose_WAIT:
    ERX 4800,A,soar_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO soar_pose_WAIT
    ENDIF

    SPEED 4
    MOVE G6A, 85,  98, 105,  115, 115, 100
    MOVE G6D,115,  74, 145,  98,  93, 100
    MOVE G6B,100,  150,  150, , , 100
    MOVE G6C,100,  150,  150
    WAIT

    SPEED 8
    MOVE G6A, 85,  71, 152,  91, 110, 100
    MOVE G6D,108,  76, 146,  93,  92, 100
    MOVE G6B,100,  70,  80
    MOVE G6C,100,  70,  80
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  80
    MOVE G6C,100,  35,  80
    WAIT

    SPEED 2
    GOSUB standard_pose	
    GOSUB All_motor_Reset



    RETURN
    '**********************************************
fighter_pose:

    SPEED 6
    MOVE G6B, 120,  40,  90
    MOVE G6C, 120,  40,  90
    WAIT

    SPEED 6
    MOVE G6A,  70,  78, 141, 95, 127, 100
    MOVE G6D,  97, 107,  93, 116, 102, 100
    MOVE G6B, 145,  66,  87, , ,  50
    MOVE G6C, 170,  15,  32, , ,
    WAIT

    GOSUB All_motor_mode3
fighter_pose_WAIT:
    ERX 4800,A,fighter_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO fighter_pose_WAIT
    ENDIF
    GOSUB All_motor_Reset
    SPEED 6
    MOVE G6B, 120,  40,  90
    MOVE G6C, 120,  40,  90
    WAIT
    SPEED 8
    GOSUB standard_pose

    RETURN
    '**********************************************
side_punch_pose:

    SPEED 8
    MOVE G6A, 63, 76,  160, 85, 130	
    MOVE G6D, 88, 125,  70, 120, 115
    MOVE G6B,100,  70,  100, , ,  150
    MOVE G6C,100, 125, 108
    WAIT

    GOSUB All_motor_mode3
side_punch_pose_WAIT:
    ERX 4800,A,side_punch_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO side_punch_pose_WAIT
    ENDIF
    GOSUB All_motor_Reset
    SPEED 8
    GOSUB standard_pose


    RETURN
    '**********************************************
one_foot_lift_pose:
    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6D,112,  77, 146,  93,  92, '60	
    MOVE G6A, 80,  71, 152,  91, 112,' 60
    MOVE G6C,100,  100,  100, , , ,
    MOVE G6B,100,  100,  100, , , ,	
    WAIT
    SPEED 8
    MOVE G6D,113,  77, 146,  93,  92, 100	
    MOVE G6A,80,  150,  27, 140, 114, 100
    MOVE G6C,100,  100,  100, , ,
    MOVE G6B,100,  100,  100, , , 100
    WAIT
    GOSUB All_motor_mode3
one_foot_lift_pose_WAIT:
    ERX 4800,A,one_foot_lift_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO one_foot_lift_pose_WAIT
    ENDIF

    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6D,112,  77, 146,  93,  92, 100		
    MOVE G6A, 80, 88, 125, 100, 115, 100
    MOVE G6B,100,  100,  100, , , ,
    MOVE G6C,100,  100,  100, , , ,
    WAIT

    SPEED 4
    GOSUB standard_pose
    GOSUB Leg_motor_mode1

    RETURN
    '**********************************************
kick_pose:
    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6A,110,  77, 145,  93,  92, 100	
    MOVE G6D, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6A,113,  75, 145,  100,  95	
    MOVE G6D, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6A,113,  73, 145,  85,  95	
    MOVE G6D, 83,  20, 172,  155, 114
    MOVE G6C,50
    MOVE G6B,150
    WAIT
kick_pose_WAIT:
    ERX 4800,A,kick_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO kick_pose_WAIT
    ENDIF

    SPEED 10
    MOVE G6A,113,  72, 145,  97,  95
    MOVE G6D, 83,  58, 122,  130, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT	

    SPEED 8
    MOVE G6A,113,  77, 145,  95,  95	
    MOVE G6D, 80,  80, 142,  95, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT	

    SPEED 8
    MOVE G6A,110,  77, 145,  93,  93, 100	
    MOVE G6D, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 3
    GOSUB standard_pose	
    GOSUB Leg_motor_mode1



    RETURN
    '**********************************************
future_pose:
    SPEED 6
    MOVE G6C, 100,  40,  90
    MOVE G6B, 150,  40,  90
    WAIT
    SPEED 10
    MOVE G6C,100,  100,  100,
    MOVE G6B,190,  15,  15, , , 100
    WAIT

    GOSUB All_motor_mode3
    SPEED 8
    MOVE G6A,96,  106, 89,  123, 130, 100
    MOVE G6D,85,  76, 145,  93, 85, 100
    MOVE G6C,100,  110,  110,
    MOVE G6B,160,  15,  20, , , 160
    WAIT

future_pose_WAIT:
    ERX 4800,A,future_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO future_pose_WAIT
    ENDIF

    SPEED 6
    MOVE G6C, 100,  40,  90
    MOVE G6B, 150,  40,  90, , , 100
    WAIT
    GOSUB Leg_motor_mode2
    SPEED 6
    GOSUB standard_pose	
    GOSUB Leg_motor_mode1
    RETURN
    '**********************************************
korea_old_dance_pose:
    GOSUB Leg_motor_mode2
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80, , ,100
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT


    SPEED 5
    MOVE G6A, 80,  74, 146, 94, 116, 100
    MOVE G6D,108,  81, 137,  98, 98, 100
    MOVE G6B,100,  70,  90
    MOVE G6C,100,  70,  90	
    WAIT

    SPEED 5
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT	

    SPEED 4
    MOVE G6C,100,  150,  140
    MOVE G6B,100,  100,  100, , ,70
    MOVE G6D, 95,  94, 145,  45, 107,
    MOVE G6A, 89,  94, 145,  45, 113,
    WAIT


korea_old_dance_pose_WAIT:
    ERX 4800,A,korea_old_dance_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO korea_old_dance_pose_WAIT
    ENDIF
    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 95, 100
    MOVE G6D,100,  76, 145,  93, 95, 100
    MOVE G6B,100,  30,  80, , ,100
    MOVE G6C,100,  30,  80
    WAIT
    SPEED 5
    GOSUB standard_pose



    RETURN
    '**********************************************
walk_pose:

    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6C, 100,35
    MOVE G6B, 100,35
    WAIT

    SPEED 10'walk_speed

    MOVE G6D, 90, 100, 115, 105, 114
    MOVE G6A,113,  78, 146,  93,  94
    MOVE G6C,70,35
    MOVE G6B,130,30
    WAIT

walk_pose_WAIT:
    ERX 4800,A,walk_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO walk_pose_WAIT
    ENDIF

    SPEED 5

    MOVE G6A, 106,  76, 146,  93,  96		
    MOVE G6D,  88,  71, 152,  91, 106
    MOVE G6B, 100,35
    MOVE G6C, 100,35
    WAIT	


    SPEED 3
    GOSUB standard_pose
    GOSUB All_motor_Reset
    RETURN

    '******************************************
sorry_pose:
    GOSUB Arm_motor_mode3
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  185,  170
    WAIT	
    SPEED 4
    MOVE G6B,100,  30,  80, , ,130
    MOVE G6C,90,  170,  185
    WAIT

sorry_pose_WAIT:
    ERX 4800,A,sorry_pose_WAIT
    IF A <> 26 THEN
        GOSUB beep_music
        GOTO sorry_pose_WAIT
    ENDIF

    SPEED 8
    GOSUB standard_pose
    GOSUB All_motor_Reset

    RETURN

    '**********************************************
    '**********************************************
    '**********************************************

motor_ONOFF_LED:
    IF motor_ONOFF = 1  THEN
        OUT 52,1
        DELAY 200
        OUT 52,0
        DELAY 200
    ENDIF
    RETURN
    '**********************************************
LOW_Voltage:

    B = AD(6)

    IF B < low_volt THEN
        GOSUB caution_music

    ENDIF

    RETURN
    '**********************************************
    '******************************************	
    '***************WJM*********************************


queue_change_for_robot1:
    '第一个动作
    SPEED 15
    MOVE G6B,101,  99, 100, 100, 100, 100
    MOVE G6C,102, 100, 100, 100, 100, 100
    WAIT
    DELAY 9150

    GOTO standard_pose
    RETURN

queue_change_for_robot4:
    '第一个动作
    SPEED 15
    MOVE G6B,101,  99, 100, 100, 100, 100
    MOVE G6C,102, 100, 100, 100, 100, 100
    WAIT
    DELAY 8200

    GOTO standard_pose
    RETURN

back_walk_3:
    step=0
    walk_speed = 12'6
    left_right_speed = 6'3
    left_right_speed2 = 4'2
    fall_check = 0
    GOSUB Leg_motor_mode3



    IF walk_order = 0 THEN
        walk_order = 1

        SPEED 4
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35
        WAIT

        'HIGHSPEED SETON
        SPEED 10'walk_speed
        MOVE G6A, 90, 95, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT

        GOTO back_walk_3_1	
    ELSE
        walk_order = 0

        SPEED 4
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        'HIGHSPEED SETON
        SPEED 10'walk_speed
        MOVE G6D, 90, 95, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT

        GOTO back_walk_3_2

    ENDIF


back_walk_3_1:
    IF step = 3 THEN
        GOTO standard_pose
        RETURN
    ENDIF
    step = step + 1
    SPEED walk_speed
    GOSUB Leg_motor_mode2
    MOVE G6D,110,  76, 144, 100,  93
    MOVE G6A, 90, 93, 155,  71, 112
    WAIT

    SPEED left_right_speed2
    GOSUB Leg_motor_mode3
    MOVE G6D,90,  46, 163, 110, 114
    MOVE G6A,110,  77, 147,  90,  94
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    MOVE G6A,112,  77, 147,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, back_walk_3_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        MOVE G6A, 106,  76, 146,  93,  96		
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	

        SPEED 3
        GOSUB standard_pose
        'GOSUB Leg_motor_mode1
        ' GOSUB zyro_OFF
        GOTO RX_EXIT
    ENDIF
    '**********

back_walk_3_2:
    IF step = 3 THEN
        GOTO standard_pose
        RETURN
    ENDIF
    step = step + 1
    SPEED walk_speed
    GOSUB Leg_motor_mode2
    MOVE G6A,110,  76, 144, 100,  93
    MOVE G6D,90, 93, 155,  71, 112
    WAIT

    SPEED left_right_speed2
    GOSUB Leg_motor_mode3
    MOVE G6A, 90,  46, 163, 110, 114
    MOVE G6D,110,  77, 147,  90,  94
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,112,  76, 147,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    ERX 4800,A, back_walk_3_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        GOSUB Leg_motor_mode3
        SPEED 5

        MOVE G6D, 106,  76, 146,  93,  96		
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	

        SPEED 3
        GOSUB standard_pose
        'GOSUB Leg_motor_mode1
        ' GOSUB zyro_OFF
        GOTO RX_EXIT
    ENDIF  	

    GOTO back_walk_3_1

front_walk_3:
    walk_speed = 10'5
    left_right_speed = 5'8'3
    left_right_speed2 = 4'5'2
    fall_check = 0
    step = 0
    GOSUB Leg_motor_mode3

    IF walk_order = 0 THEN
        walk_order = 1

        SPEED 4
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35
        WAIT

        SPEED 10'walk_speed
        MOVE G6A, 90, 100, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT


        GOTO front_walk_3_1	
    ELSE
        walk_order = 0

        SPEED 4
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 10'walk_speed
        MOVE G6D, 90, 100, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT


        GOTO front_walk_3_2	

    ENDIF


    '*******************************
    'team2 6.2
dangerous_begin:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 101,  37,  94,  ,  ,
    MOVE G6C, 100,  43,  90,  ,  ,
    WAIT



    DELAY 500

    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 101,  58,  95,  ,  ,
    MOVE G6C, 100,  63,  91,  ,  ,
    WAIT

    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 100,  34,  81,  ,  ,
    MOVE G6C, 100,  34,  81,  ,  ,
    WAIT

    DELAY 1200
    SPEED 3

    'MOVE G6A, 95,  83, 119, 110, 104,
    'MOVE G6D,  95,  83, 119, 110, 104,
    MOVE G6A,  97,  98, 119,  93, 103,
    MOVE G6D,  98, 101, 115,  94, 103,
    MOVE G6B, 117,  31,  81,  ,  ,
    MOVE G6C,  87,  33,  81,  ,  ,
    WAIT
    'same
    MOVE G6A,  97,  98, 119,  93, 103,
    MOVE G6D,  96, 102, 115,  94, 103,
    MOVE G6B, 117,  31,  81,  ,  ,
    MOVE G6C,  87,  33,  81,  ,  ,
    WAIT



    MOVE G6A, 95,  76, 145,  93, 104,
    MOVE G6D, 95,  76, 145,  93, 104,
    MOVE G6B, 143,  31,  81,  ,  ,
    MOVE G6C,  70,  32,  81,  ,  ,
    WAIT



    MOVE G6A, 95,  83, 119, 110,  104,
    MOVE G6D, 95,  82, 119, 110,  104,
    MOVE G6B,  87,  33,  81,  ,  ,
    MOVE G6C, 117,  31,  81,  ,  ,
    WAIT


    MOVE G6A, 95,  76, 145,  93, 104,
    MOVE G6D, 95,  76, 145,  93, 104,
    MOVE G6B, 70,  32,  81,  ,  ,
    MOVE G6C, 143,  31,  81,  ,  ,
    WAIT
    '************************************************	走路完毕
    SPEED 12

    MOVE G6A,  94,  95, 116,  94, 109,
    MOVE G6D,  94,  95, 116,  94, 109,
    MOVE G6B,  99,  32,  81,  ,  ,
    MOVE G6C,  99,  32,  81,  ,  ,
    WAIT

    MOVE G6B,  99,  32,  81,  ,  ,140
    MOVE G6A,  96,  88, 130,  94, 107,
    MOVE G6D,  92,  88, 130,  93, 107,
    MOVE G6C,  99,  32,  81,  ,  ,
    WAIT

    MOVE G6B,  99,  32,  81,  ,  ,  100
    MOVE G6A,  96,  88, 130,  94, 107,
    MOVE G6D,  92,  88, 130,  93, 107,
    MOVE G6C,  99,  32,  81,  ,  ,
    WAIT

    DELAY 1150



    MOVE G6A,  91,  95, 116,  94, 109,
    MOVE G6D,  91,  95, 116,  94, 109,
    MOVE G6B,  99,  52,  82,  ,  ,
    MOVE G6C,  99,  53,  82,  ,  ,
    WAIT

    MOVE G6B,  99,  32,  81,  ,  ,140
    MOVE G6A, 95,  84, 119, 110, 104,
    MOVE G6D,  95,  83, 119, 110, 104,
    MOVE G6C,  99,  32,  81,  ,  ,
    WAIT

    MOVE G6B,  99,  32,  81,  ,  ,100
    'MOVE G6A,  96,  88, 130,  94, 107,
    'MOVE G6D,  92,  88, 130,  93, 107,
    MOVE G6A, 95,  83, 119, 110, 104,
    MOVE G6D,  95,  83, 119, 110, 104,
    MOVE G6C,  99,  32,  81,  ,  ,
    WAIT
    DELAY 1200





    MOVE G6A, 95,  83, 119, 110, 104,
    MOVE G6D,  95,  83, 119, 110, 104,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    '* 走路开始
    DELAY 1450

    SPEED 15
    MOVE G6A, 95,  83, 119, 110, 104,
    MOVE G6D,  95,  83, 119, 110, 104,
    MOVE G6B, 118,  22,  97,  ,  ,
    MOVE G6C,  90,  23,  98,  ,  ,
    WAIT


    SPEED 3

    MOVE G6A, 95,  83, 119, 110, 104,
    MOVE G6D,  95,  83, 119, 110, 104,
    MOVE G6B, 117,  31,  81,  ,  ,
    MOVE G6C,  87,  33,  81,  ,  ,
    WAIT

    MOVE G6A, 95,  83, 119, 110,  104,
    MOVE G6D, 95,  83, 119, 110,  104,
    MOVE G6B, 117,  31,  81,  ,  ,
    MOVE G6C,  87,  33,  81,  ,  ,
    WAIT


    MOVE G6A, 95,  76, 145,  93, 104,
    MOVE G6D, 95,  76, 145,  93, 104,
    MOVE G6B, 143,  31,  81,  ,  ,
    MOVE G6C,  70,  32,  81,  ,  ,
    WAIT



    MOVE G6A, 95,  83, 119, 110,  104,
    MOVE G6D, 95,  83, 119, 110,  104,
    MOVE G6B,  87,  33,  81,  ,  ,
    MOVE G6C, 117,  31,  81,  ,  ,
    WAIT



    MOVE G6A, 95,  76, 145,  93, 104,
    MOVE G6D, 95,  76, 145,  93, 104,
    MOVE G6B, 70,  32,  81,  ,  ,
    MOVE G6C, 143,  31,  81,  ,  ,
    WAIT


    '**********举手的动作

    SPEED 12

    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    
    MOVE G6A, 95,  76, 145,  93, 104,
    MOVE G6D,  95,  76, 145,  93, 104,
    MOVE G6B, 156,  26,  50,  ,  ,
    MOVE G6C, 102, 188,  82,  ,  ,

    MOVE G6A, 95,  76, 145,  93, 104,
    MOVE G6D,  95,  76, 145,  93, 104,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT


    '*******    举手动作结束  接下来是两个方向耸肩并看向对应方向的动作


    '	MOVE G6A, 100,  76, 145,  93, 104,
    '    MOVE G6D, 95,  76, 145,  93, 104,
    '	MOVE G6B, 100,  30,  80,  ,  ,
    '	MOVE G6C, 100,  30,  80,  ,  ,
    DELAY  900

    SPEED 12

    MOVE G6B, 101,  55,  101,  ,  , 70
    MOVE G6A, 100, 104, 108,  94, 101,
    MOVE G6D,  96, 102, 111,  93, 103,
    MOVE G6C, 100,  20,  99,  ,  ,
    WAIT


    MOVE G6B, 100,  20,  99,  ,  , 130
    MOVE G6A,  89,  99, 116,  91, 102,
    MOVE G6D, 103, 108, 102,  95, 102,
    MOVE G6C, 101,  61,  99,  ,  ,
    WAIT


    '***********   两次快速的左右看 之后两个慢速的左右动
    DELAY 200



    '简单的动手动作
    HIGHSPEED SETON
    SPEED 4

    MOVE G6A,  89,  99, 116,  91, 102,
    MOVE G6D, 103, 108, 102,  95, 102,
    MOVE G6B,  94,  11, 172,  ,  ,
    MOVE G6C,  97,  10, 177,  ,  ,
    DELAY 200
    SPEED 7
    MOVE G6A, 100,  76, 145,  93, 104,
    MOVE G6D,  95,  76, 145,  93, 104,
    MOVE G6B, 100,  30,  80,  ,  ,100
    MOVE G6C, 100,  30,  80,  ,  ,
    DELAY 200



    MOVE G6A, 104, 106, 108,  97, 107,
    MOVE G6D,  91,  85, 134,  90,  97,
    MOVE G6B, 104,  11, 169,  ,  ,
    MOVE G6C,  99, 114, 103,  ,  ,
    WAIT
    DELAY 400


    MOVE G6A, 96,  76, 145,  93, 104,
    MOVE G6D,  96,  76, 145,  93, 104,
    MOVE G6B, 104,  11, 169,  ,  ,
    MOVE G6C,  99, 114, 103,  ,  ,
    DELAY 200
    MOVE G6A, 78,  76, 145,  93, 104,
    MOVE G6D,  78,  76, 145,  93, 104,
    MOVE G6B, 100,  30,  80,  ,  ,100
    MOVE G6C, 100,  30,  80,  ,  ,
    DELAY 200

    SPEED 10
    MOVE G6A,  96,  76, 145,  93, 104,
    MOVE G6D,  96,  76, 145,  93, 104,
    MOVE G6B, 103,  47, 184,  ,  ,
    MOVE G6C, 104,  33,  89,  ,  ,

    SPEED 6
    MOVE G6A,  96,  76, 145,  93, 104,
    MOVE G6D,  96,  76, 145,  93, 104,
    MOVE G6B, 103, 104, 106,  ,  ,
    MOVE G6C, 104,  33,  89,  ,  ,
    DELAY 200
    SPEED 10
    MOVE G6A, 100,  76, 145,  93, 104,
    MOVE G6D,  95,  76, 145,  93, 104,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 105,  49, 188,  ,  ,

    SPEED 6
    MOVE G6A,  96,  76, 145,  93, 104,
    MOVE G6D,  96,  76, 145,  93, 104,
    MOVE G6C, 103, 104, 106,  ,  ,
    MOVE G6B, 104,  33,  89,  ,  ,
    DELAY 200
    SPEED 10
    MOVE G6A,  96,  76, 145,  93, 104,
    MOVE G6D,  96,  76, 145,  93, 104,
    MOVE G6B, 103,  47, 184,  ,  ,
    MOVE G6C, 104,  33,  89,  ,  ,
    SPEED 6

    MOVE G6A,  96,  76, 145,  93, 104,
    MOVE G6D,  96,  76, 145,  93, 104,
    MOVE G6B, 103, 104, 106,  ,  ,
    MOVE G6C, 104,  33,  89,  ,  ,

    DELAY 200

    'shenwanshou


    DELAY 50




    SPEED 3

    MOVE G6A, 100, 104, 108,  94, 101,
    MOVE G6D, 100, 104, 108,  94, 101,
    MOVE G6B, 101,  14, 160,  ,  ,
    MOVE G6C, 100,  17, 162,  ,  ,
    WAIT
    SPEED 6
    MOVE G6A, 100, 104, 108,  94, 101,
    MOVE G6D, 100, 104, 108,  94, 101,
    MOVE G6B, 108,  99, 102,  ,  ,
    MOVE G6C, 100, 100, 107,  ,  ,
    WAIT

    DELAY 200

    MOVE G6A, 100,  76, 145,  93, 104,
    MOVE G6D,  95,  76, 145,  93, 104,
    MOVE G6B,  98, 102, 103,  ,  ,
    MOVE G6C, 108,  31,  87,  ,  ,
    DELAY 200
    SPEED 6
    MOVE G6A, 100, 104, 108,  94, 101,
    MOVE G6D, 100, 104, 108,  94, 101,
    MOVE G6B,  66,  19,  91,  ,  ,
    MOVE G6C, 169,  16,  90,  ,  ,
    DELAY 200
    SPEED 4
    MOVE G6A, 100,  76, 145,  93, 104,
    MOVE G6D,  95,  76, 145,  93, 104,
    MOVE G6B, 100,  30,  80,  ,  ,100
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    DELAY 1000
    SPEED 4
    MOVE G6A,  94,  81, 140,  94, 103,
    MOVE G6D, 102,  89, 122, 100, 103,
    MOVE G6B, 100,  30,  80,  ,  , 40
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    SPEED 4
    MOVE G6A, 100,  76, 145,  93, 104,
    MOVE G6D,  95,  76, 145,  93, 104,
    MOVE G6B, 100,  30,  80,  ,  ,100
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    DELAY 200
    MOVE G6A, 100, 104, 108,  94, 101,
    MOVE G6D, 100, 104, 108,  94, 101,
    MOVE G6B, 110,  93,  92,  ,  ,
    MOVE G6C, 106,  93,  96,  ,  ,
    WAIT
    DELAY 100
    MOVE G6A,  90,  76, 145,  93, 110,
    MOVE G6D,  92,  76, 145,  93, 110,
    MOVE G6B, 110,  93,  92,  ,  ,
    MOVE G6C, 106,  93,  96,  ,  ,
    WAIT
    MOVE G6A,  90,  76, 145,  93, 110,
    MOVE G6D,  92,  76, 145,  93, 110,
    MOVE G6B, 139,  41,  92,  ,  ,
    MOVE G6C, 139,  35,  97,  ,  ,
    WAIT
    DELAY 400
    MOVE G6A,  89, 108, 102, 102, 111,
    MOVE G6D,  91, 107, 100, 103, 110,
    MOVE G6B, 138,  25,  37,  ,  ,
    MOVE G6C, 140,  25,  39,  ,  ,

    SPEED 4
    MOVE G6A,  90,  76, 145,  93, 110,
    MOVE G6D,  92,  76, 145,  93, 110,
    MOVE G6B, 110,  93,  92,  ,  ,
    MOVE G6C, 106,  93,  96,  ,  ,
    WAIT
    SPEED 5
    DELAY 200
    MOVE G6A,  89, 108, 102, 102, 111,
    MOVE G6D,  91, 107, 100, 103, 110,
    MOVE G6B, 102,  42,  65,  ,  ,
    MOVE G6C, 184,  20,  82,  ,  ,
    WAIT
    DELAY 200
    MOVE G6A,  90,  76, 145,  93, 110,
    MOVE G6D,  92,  76, 145,  93, 110,
    MOVE G6B, 107,  42,  68,  ,  ,
    MOVE G6C, 190,  94,  97,  ,  ,
    WAIT
    DELAY 200
    MOVE G6A,  90,  76, 145,  93, 110,
    MOVE G6D,  92,  76, 145,  93, 110,
    MOVE G6B, 102,  42,  65,  ,  ,
    MOVE G6C, 184,  20,  82,  ,  ,
    WAIT
    DELAY 250
    SPEED 8
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 101,  30,  80,  ,  ,
    MOVE G6C,  94, 126, 178,  ,  ,
    WAIT
    DELAY 200
    SPEED 4
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    DELAY 200

    '动手动作结束
    RETURN



happy:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3

    HIGHSPEED SETON
    SPEED 8


    




    FOR i=1 TO 3

        'MOVE G6A,  94,  76, 114, 121,  83,
        'MOVE G6D,  84, 100,  79, 136, 139,

        MOVE G6A,  93,  82, 110, 125,  92,
        MOVE G6D,  88,  94,  90, 132, 128,

        WAIT
        DELAY 100
        MOVE G6A,92,85,105,126,101,
        MOVE G6D,89,91,95,131,119,
        WAIT
        MOVE G6A,91,88,100,128,110,
        MOVE G6D,90,88,100,129,110,
        WAIT
        MOVE G6A,90,91,95,130,119,
        MOVE G6D,91,85,105,127,101,
        WAIT
        'delay

        'MOVE G6D,  90,  76, 114, 121,  83,
        'MOVE G6A,  86, 100,  79, 136, 139,
        MOVE G6A,  88,  94,  90, 132, 128,
        MOVE G6D,  93,  82, 110, 125,  92,

        WAIT

        DELAY 100
        MOVE G6A,90,91,95,130,119,
        MOVE G6D,91,85,105,127,101,
        WAIT
        MOVE G6A,91,88,100,128,110,
        MOVE G6D,90,88,100,129,110,
        WAIT
        MOVE G6A,92,85,105,126,101,
        MOVE G6D,89,91,95,131,119,
        WAIT
    NEXT i	
    GOSUB Leg_motor_mode2
    SPEED 9
    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,  100


    RETURN

lookatleft_lookatright:

    '*******    举手动作结束  接下来是两个方向耸肩并看向对应方向的动作


    '	MOVE G6A, 100,  76, 145,  93, 104,
    '    MOVE G6D, 95,  76, 145,  93, 104,
    '	MOVE G6B, 100,  30,  80,  ,  ,
    '	MOVE G6C, 100,  30,  80,  ,  ,

    SPEED 8

    MOVE G6A, 100, 100, 117,  94, 103,
    MOVE G6D,  96, 104, 112,  94, 104,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT



    SPEED 12

    MOVE G6A, 100, 104, 108,  94, 101,
    MOVE G6D,  96, 102, 111,  93, 103,
    MOVE G6B, 101,  55,  81,  ,  , 70
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT


    MOVE G6A,  96,  99, 116,  91, 102,
    MOVE G6D, 103, 108, 102,  95, 102,
    MOVE G6B, 100,  30,  80,  ,  , 130
    MOVE G6C, 101,  61,  81,  ,  ,
    WAIT

    '***********   两次快速的左右看 之后两个慢速的左右动
    DELAY 200

    SPEED 6

    MOVE G6A, 100, 104, 108,  94, 101,
    MOVE G6D,  96, 102, 111,  93, 103,
    MOVE G6B, 101,  55,  81,  ,  , 70
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    DELAY 200

    MOVE G6A,  96,  99, 116,  91, 102,
    MOVE G6D, 103, 108, 102,  95, 102,
    MOVE G6B, 100,  30,  80,  ,  , 130
    MOVE G6C, 101,  61,  81,  ,  ,
    WAIT

    DELAY 200
    MOVE G6A, 100, 104, 108,  94, 101,
    MOVE G6D,  96, 102, 111,  93, 103,
    MOVE G6B, 101,  55,  81,  ,  , 70
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    DELAY 200
    MOVE G6A,  96,  99, 116,  91, 102,
    MOVE G6D, 103, 108, 102,  95, 102,
    MOVE G6B, 100,  30,  80,  ,  , 130
    MOVE G6C, 101,  61,  81,  ,  ,
    WAIT



    WAIT
    DELAY 700


dangerous_kaitou:

    GOSUB Arm_motor_mode2
    GOSUB Leg_motor_mode2

    MOVE G6B,  92,  45,  62,  ,  ,
    MOVE G6C,  92,  45,  62,  ,  ,
    MOVE G6A, 101,  47, 187,  60, 100,
    MOVE G6D, 101,  51, 170,  65,  100,
    WAIT

    DELAY 7000
    HIGHSPEED SETON
    SPEED 6
    MOVE G6A, 101,  47, 187,  60, 100,
    MOVE G6D, 101,  51, 170,  65,  100,
    MOVE G6B,  98,  42,  98,  ,  ,
    MOVE G6C,  99,  49,  91,  ,  ,
    WAIT
    MOVE G6B,  92,  45,  62,  ,  ,
    MOVE G6C,  92,  45,  62,  ,  ,
    MOVE G6A, 101,  47, 187,  60, 100,
    MOVE G6D, 101,  51, 170,  65,  100,
    WAIT
    DELAY 8500
    '	MOVE G6A, 100, 100, 144,  49, 102,
    'MOVE G6D, 104, 101, 142,  51,  95,
    'MOVE G6B,  98,  42,  98,  ,  ,
    'MOVE G6C,  99,  49,  91,  ,  ,
    'WAIT
    MOVE G6A, 101,  47, 155,  86, 100,
    MOVE G6D, 102,  51, 155,  87, 100,
    MOVE G6B,  92,  45,  62,  ,  ,
    MOVE G6C,  92,  45,  62,  ,  ,
    WAIT

    MOVE G6B,  92,  45,  62,  ,  ,
    MOVE G6C,  92,  45,  62,  ,  ,
    MOVE G6A, 101,  47, 187,  60, 100,
    MOVE G6D, 101,  51, 170,  65,  100,
    WAIT
    DELAY 700
    HIGHSPEED SETOFF
    SPEED 6

    MOVE G6B,  92,  45,  62,  ,  ,
    MOVE G6C,  92,  45,  62,  ,  ,
    MOVE G6A, 101,  47, 187,  60, 100,
    MOVE G6D, 101,  51, 170,  65,  100,
    WAIT

    '    SPEED 6
    '    MOVE G6A,100,  60, 110,  15, 100, 100
    '    MOVE G6D,100,  70, 120, 30, 100, 100
    '    MOVE G6B,165,  40,  70
    '    MOVE G6C,170,  40,  70
    '    WAIT

    SPEED 6
    MOVE G6A,100,  60, 110,  15, 100, 100
    MOVE G6D,100,  60, 110,  15, 100, 100
    MOVE G6B,185,  40,  70
    MOVE G6C,190,  40,  70
    WAIT
    DELAY 50

    SPEED 9
    MOVE G6A,100, 110, 70,  65, 100, 100
    MOVE G6D,100, 111, 68,  65, 100, 100
    MOVE G6B,185, 160, 115
    MOVE G6C,190, 160, 115
    WAIT

    MOVE G6A,100, 170,  70,  15, 100, 100
    MOVE G6D,100, 170,  68,  15, 100, 100
    MOVE G6B,185, 155, 120
    MOVE G6C,190, 155, 120
    WAIT


    MOVE G6A,100, 170,  30,  110, 100, 100
    MOVE G6D,100, 168,  26,  110, 100, 100
    MOVE G6B,185,  40,  60
    MOVE G6C,190,  40,  60
    WAIT



    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  24, 142, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT






    MOVE G6A,  98, 135,  54, 126, 102,
    MOVE G6D,  100, 135,  52, 126, 100,
    MOVE G6B, 160,  25,  84,  ,  ,
    MOVE G6C, 165,  24,  93,  ,  ,
    WAIT

    DELAY 200


    MOVE G6A,96, 99,  106, 110, 104, 100
    MOVE G6D,96, 99,  106, 110, 104, 100
    MOVE G6B, 186,  25,  84,  ,  ,
    MOVE G6C, 190,  25,  93,  ,  ,
    WAIT

    DELAY 200



    pose = 0
    DELAY 100
    SPEED 7
    FOR k=0 TO 5
        MOVE G6A,  67,  88, 112, 110, 128,
        MOVE G6D, 106, 130,  72, 107,  97,
        MOVE G6B, 138,  43,  98,  ,  ,  30
        MOVE G6C,  65, 163, 189,  ,  ,
        WAIT

        MOVE G6A,  43,  88, 112, 110, 128,
        MOVE G6D, 106, 130,  72, 107,  97,
        MOVE G6B, 138,  43,  98,  ,  ,
        MOVE G6C,  31, 163, 189,  ,  ,
        WAIT
        MOVE G6A,  67,  88, 112, 110, 128,
        MOVE G6D, 106, 130,  72, 107,  97,
        MOVE G6B, 138,  43,  98,  ,  ,
        MOVE G6C,  65, 163, 189,  ,  ,
        WAIT
    NEXT k
    SPEED 6
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 101,  76, 145,  93, 100,
    MOVE G6B, 100,  30,  80,  ,  ,100
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT










    SPEED 4
    GOSUB standard_pose
    GOSUB All_motor_Reset
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    RETURN

nobody_niuniu:

    MOVE G6A,  93,  96, 111, 107, 109,
    MOVE G6D,  87,  89, 120, 103, 109,
    MOVE G6B,  52,  26,  50,  ,  ,
    MOVE G6C,  54,  45,  38,  ,  ,
    WAIT

    SPEED 9
    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B,  52,  26,  50,  ,  ,
    MOVE G6C,  54,  45,  38,  ,  ,
    WAIT


    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6D,  99,  96, 111, 107,  82,
    MOVE G6B,  61,  51,  71,  ,  ,
    MOVE G6C,  62,  52,  76,  ,  ,
    WAIT

    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B, 100, 122, 133,  ,  ,
    MOVE G6C,  97, 131, 124,  ,  ,
    WAIT

    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6D,  99,  96, 111, 107,  82,
    MOVE G6B, 109, 168, 144,  ,  ,
    MOVE G6C, 103, 168, 145,  ,  ,
    WAIT

    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B, 100, 122, 133,  ,  ,
    MOVE G6C,  97, 131, 124,  ,  ,
    WAIT
    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6D,  99,  96, 111, 107,  82,
    MOVE G6B,  61,  51,  71,  ,  ,
    MOVE G6C,  62,  52,  76,  ,  ,
    WAIT
    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B,  52,  26,  50,  ,  ,
    MOVE G6C,  54,  50,  38,  ,  ,
    WAIT

    '*******************************狂扭****************
    SPEED 12
    MOVE G6D,  99,  96, 111, 107,  82,
    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6C, 170,  70,  50,  ,  ,
    MOVE G6B,  100, 140, 150,  ,  ,


    WAIT
    DELAY 300

    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B, 170,  70,  50,  ,  ,
    MOVE G6C,  100, 140, 150,  ,  ,
    WAIT
    DELAY 450


    SPEED 15



    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B, 170,  70,  50,  ,  ,
    MOVE G6C,  100, 140, 150,  ,  ,
    WAIT

    MOVE G6D,  99,  96, 111, 107,  82,
    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6C, 170,  70,  50,  ,  ,
    MOVE G6B,  100, 140, 150,  ,  ,
    WAIT


    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B, 170,  70,  50,  ,  ,
    MOVE G6C,  100, 140, 150,  ,  ,
    WAIT

    MOVE G6D,  99,  96, 111, 107,  82,
    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6C, 170,  70,  50,  ,  ,
    MOVE G6B,  100, 140, 150,  ,  ,
    WAIT





    RETURN



    ' 5.31  第一次合并结束


nobody_onestep_right:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3



    '****************平移*****************************

    FOR i=1 TO 1
        SPEED 5





        MOVE G6D,  95,  71, 152,  91, 105,
        MOVE G6A, 103,  76, 146,  93,  98,
        MOVE G6C, 127,  42,  68,  ,  ,
        MOVE G6B, 100,  40,  80,  ,  ,
        WAIT


        'MOVE G6A, 88,  71, 152,  91, 110, '60
        '        MOVE G6D,108,  76, 146,  93,  92, '60
        '        MOVE G6B, 127,  42,  68,  ,  ,
        '        MOVE G6C,100,  40,  80
        '        WAIT

        SPEED 8
        MOVE G6D, 85,  80, 140, 95, 114, 100
        MOVE G6A,112,  76, 146,  93, 98, 100
        MOVE G6C, 136,  52,  63,  ,  ,
        MOVE G6B,100,  40,  80
        WAIT


        SPEED 8
        MOVE G6A,110,  92, 124,  97,  93,  100
        MOVE G6D, 78,  71, 159,  82, 127,  100
        MOVE G6C, 152,  53,  48,  ,  ,
        MOVE G6B,100,  40,  80, , , ,
        WAIT

        SPEED 8
        MOVE G6D,94,  76, 145,  93, 106, 100
        MOVE G6A,94,  76, 145,  93, 106, 100
        MOVE G6C, 164,  45,  39,  ,  ,
        MOVE G6B,100,  40,  80
        WAIT	
        '***********************
        SPEED 8
        MOVE G6D,110,  92, 124,  97,  93,  100
        MOVE G6A, 76,  70, 160,  82, 120,  100
        MOVE G6C, 173,  58,  13,  ,  ,
        MOVE G6B,100,  40,  80, , , ,
        WAIT

        SPEED 13
        MOVE G6A, 87,  80, 140, 95, 110, 100
        MOVE G6D,112,  76, 146,  93, 98, 100
        MOVE G6C, 177,  37,  13,  ,  ,
        MOVE G6B,100,  40,  80
        WAIT

        SPEED 14
        MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D, 115,  77, 146,  93,  90, '60	
        MOVE G6C,100,  40,  80
        MOVE G6B,100,  40,  80
        WAIT

    NEXT i






    '****************************起脚*******************
    GOSUB Leg_motor_mode2

    SPEED 12
    MOVE G6D, 115,  77, 146,  93,  90, '60	
    MOVE G6A, 84,  70, 152,  91, 118,' 60
    MOVE G6B, 106,  46,  70,  ,  ,
    MOVE G6C, 102,  30,  75,  ,  ,
    WAIT
    DELAY 400
    SPEED 7
    HIGHSPEED SETON




    '*********************抬脚***************

    MOVE G6A,  98, 121,  31, 110, 120,
    MOVE G6D, 115,  77, 146,  93,  92,
    MOVE G6B, 189,  32,  94,  , , 70
    MOVE G6C, 189,  11,  55,  ,  ,
    
    
    WAIT

    '***********************************


    HIGHSPEED SETOFF
    DELAY 200
    GOSUB All_motor_mode3

    '************************************************************'


    SPEED 13
    HIGHSPEED SETON
    ''拍手‘’
    MOVE G6A,  98, 121,  31, 110, 120,
    MOVE G6D, 115,  77, 146,  93,  92,
    MOVE G6B, 164,  16,  74,  ,  ,
    MOVE G6C, 164,  16,  74,  ,  ,
    WAIT
    'MOVE G6D,112,  77, 146,  93,  92, 100	
    MOVE G6D, 115,  77, 146,  93,  92,
    MOVE G6A,  98, 121,  31, 110, 120,
    MOVE G6B, 168,  24,  34,  ,  ,
    MOVE G6C, 164,  30,  35,  ,  ,
    WAIT
    MOVE G6D, 115,  77, 146,  93,  92,
    MOVE G6A,  98, 121,  31, 110, 120,
    MOVE G6B, 164,  16,  74,  ,  ,
    MOVE G6C, 164,  16,  74,  ,  ,
    WAIT
    MOVE G6A,  98, 121,  31, 110, 120,
    MOVE G6D, 115,  77, 146,  93,  92,
    MOVE G6B, 168,  24,  34,  ,  ,
    MOVE G6C, 164,  30,  35,  ,  ,
    WAIT





    HIGHSPEED SETOFF

    DELAY 50
    SPEED 8
    HIGHSPEED SETON
    MOVE G6A,  98, 121,  31, 110, 120,
    MOVE G6D, 115,  77, 146,  93,  92,
    MOVE G6C, 189,  11,  55,  ,  ,
    MOVE G6B, 189,  32,  94,  ,  ,70
    WAIT



    '****************落脚*****************************'

    MOVE G6D, 115,  77, 146,  93,  92,
    MOVE G6A, 80, 90, 125, 102, 118, 100
    MOVE G6B, 106,  46,  70,  ,  ,100
    MOVE G6C, 102,  30,  75,  ,  ,
    WAIT
    HIGHSPEED SETOFF
    ' MOVE G6A,  91,  87, 124, 100, 117,
    '    MOVE G6D, 112,  77, 146,  93,  92,
    '    MOVE G6B, 106,  46,  70,  ,  ,
    '    MOVE G6C, 102,  30,  75,  ,  ,
    '    WAIT

    '
    'MOVE G6A,  85,  85, 133,  95, 113,
    'MOVE G6D, 112,  77, 146,  93,  92,
    'MOVE G6B, 106,  46,  70,  ,  ,
    'MOVE G6C, 102,  30,  75,  ,  ,
    'WAIT
    '
    'MOVE G6A,  91,  84, 134,  95, 112,
    'MOVE G6D, 112,  77, 146,  93,  92,
    'MOVE G6B, 106,  46,  70,  ,  ,
    'MOVE G6C, 102,  30,  75,  ,  ,
    'WAIT

    MOVE G6A,  94,  84, 134,  97, 110,
    MOVE G6D, 102,  77, 146,  93,  95,
    MOVE G6B, 106,  46,  70,  ,  ,
    MOVE G6C, 102,  30,  75,  ,  ,
    WAIT

    MOVE G6A,  97,  85, 134,  96, 107,
    MOVE G6D,  98,  77, 146,  93, 100,
    MOVE G6B, 106,  46,  70,  ,  ,
    MOVE G6C, 102,  30,  75,  ,  ,
    WAIT



    'GOSUB standard_pose

    RETURN
nobody_onestep_left:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3



    '****************平移*****************************

    FOR i=1 TO 1
        SPEED 5





        MOVE G6A,  95,  71, 152,  91, 105,
        MOVE G6D, 103,  76, 146,  93,  98,
        MOVE G6B, 127,  42,  68,  ,  ,
        MOVE G6C, 100,  40,  80,  ,  ,
        WAIT


        'MOVE G6A, 88,  71, 152,  91, 110, '60
        '        MOVE G6D,108,  76, 146,  93,  92, '60
        '        MOVE G6B, 127,  42,  68,  ,  ,
        '        MOVE G6C,100,  40,  80
        '        WAIT

        SPEED 8
        MOVE G6A, 85,  80, 140, 95, 114, 100
        MOVE G6D,112,  76, 146,  93, 98, 100
        MOVE G6B, 136,  52,  63,  ,  ,
        MOVE G6C,100,  40,  80
        WAIT


        SPEED 8
        MOVE G6D,110,  92, 124,  97,  93,  100
        MOVE G6A, 78,  71, 159,  82, 127,  100
        MOVE G6B, 152,  53,  48,  ,  ,
        MOVE G6C,100,  40,  80, , , ,
        WAIT

        SPEED 8
        MOVE G6A,94,  76, 145,  93, 106, 100
        MOVE G6D,94,  76, 145,  93, 106, 100
        MOVE G6B, 164,  45,  39,  ,  ,
        MOVE G6C,100,  40,  80
        WAIT	
        '***********************
        SPEED 8
        MOVE G6A,110,  92, 124,  97,  93,  100
        MOVE G6D, 76,  70, 160,  82, 120,  100
        MOVE G6B, 173,  58,  13,  ,  ,
        MOVE G6C,100,  40,  80, , , ,
        WAIT

        SPEED 13
        MOVE G6D, 87,  80, 140, 95, 110, 100
        MOVE G6A,112,  76, 146,  93, 98, 100
        MOVE G6B, 177,  37,  13,  ,  ,
        MOVE G6C,100,  40,  80
        WAIT

        SPEED 14
        MOVE G6D, 88,  71, 152,  91, 110, '60
        MOVE G6A,108,  76, 146,  93,  92, '60
        MOVE G6B,100,  40,  80
        MOVE G6C,100,  40,  80
        WAIT

    NEXT i





    '****************************起脚*******************
    GOSUB Leg_motor_mode2

    SPEED 12
    MOVE G6A,112,  77, 146,  93,  92, 60	
    MOVE G6D, 80,  71, 152,  91, 118, 60
    MOVE G6C, 106,  46,  70,  ,  ,
    MOVE G6B, 102,  30,  75,  ,  ,
    WAIT
    DELAY 150
    SPEED 7
    HIGHSPEED SETON







    MOVE G6A,114,  77, 146,  93,  92, 100	
    MOVE G6D,  98, 121,  31, 110, 118,
    MOVE G6B, 189,  11,  55,  ,  ,130
    MOVE G6C, 189,  32,  94,  ,  ,70
    WAIT






    HIGHSPEED SETOFF
    DELAY 200
    GOSUB All_motor_mode3

    '************************************************************


    SPEED 13
    HIGHSPEED SETON
    '  拍手‘’
    MOVE G6D,  98, 121,  31, 110, 118,
    MOVE G6A, 113,  77, 146,  93,  92,
    MOVE G6C, 164,  16,  74,  ,  ,
    MOVE G6B, 164,  16,  74,  ,  ,
    WAIT
    MOVE G6A,112,  77, 146,  93,  92, 100		
    MOVE G6D,  98, 121,  31, 110, 118,
    MOVE G6C, 168,  24,  34,  ,  ,
    MOVE G6B, 164,  30,  35,  ,  ,
    WAIT
    MOVE G6A,112,  77, 146,  93,  92, 100		
    MOVE G6D,  98, 121,  31, 110, 118,
    MOVE G6C, 164,  16,  74,  ,  ,
    MOVE G6B, 164,  16,  74,  ,  ,
    WAIT
    MOVE G6D,  98, 121,  31, 110, 118,
    MOVE G6A,112,  77, 146,  93,  92, 100
    MOVE G6C, 168,  24,  34,  ,  ,
    MOVE G6B, 164,  30,  35,  ,  ,
    WAIT
    HIGHSPEED SETOFF

    DELAY 50
    SPEED 8
    HIGHSPEED SETON
    MOVE G6D,  98, 121,  31, 110, 118,
    MOVE G6A, 113,  77, 146,  93,  92,
    MOVE G6B, 189,  11,  55,  ,  ,
    MOVE G6C, 189,  32,  94,  ,  ,70
    WAIT



    '****************落脚*****************************

    MOVE G6A,112,  77, 146,  93,  92, 100		
    MOVE G6D, 80, 91, 125, 100, 118, 100
    MOVE G6C, 106,  46,  70,  ,  ,100
    MOVE G6B, 102,  30,  75,  ,  ,100
    WAIT
    HIGHSPEED SETOFF
    MOVE G6A, 103,  77, 146,  93,  95,
    MOVE G6D,  89,  82, 133,  97, 116,
    MOVE G6B, 102,  30,  75,  ,  ,
    MOVE G6C, 106,  46,  70,  ,  ,
    WAIT





    GOSUB standard_pose

    RETURN

nobody:
    GOSUB  nobody_onestep_right
    GOSUB  nobody_onestep_left
    GOSUB  nobody_niuniu
    GOSUB standard_pose	
    GOSUB All_motor_Reset
    RETURN





dangerous_all2:

    GOSUB dangerous_kaitou
    DELAY 1500
    GOSUB dangerous_papa
    DELAY 200
    GOSUB happy
    GOSUB dangerous
    DELAY 700
    HIGHSPEED SETOFF
    GOSUB dangerous_tong
    GOSUB standard_pose

    RETURN




dangerous_all:
    'GOSUB nobody
    'GOSUB nobody_small
    'DELAY 2000
    GOSUB dangerous_begin
    DELAY 270
    GOSUB dangerous_papa
    DELAY 200
    GOSUB happy
    GOSUB dangerous
    DELAY 700
    HIGHSPEED SETOFF
    GOSUB dangerous_tong
    GOSUB standard_pose

    RETURN




dangerous:





    SPEED 5
    HIGHSPEED SETON
    MOVE G6A,  95,  96,  89, 132, 105,
    MOVE G6D,  95,  96,  89, 132, 105,
    MOVE G6B, 168,  48,  53,  ,  ,
    MOVE G6C, 137,  31,  20,  ,  ,
    WAIT

    MOVE G6A, 95, 96, 89, 132, 105,
    MOVE G6D, 95, 96, 89, 132, 105,
    MOVE G6B,  71,  30, 102,  ,  ,
    MOVE G6C,137, 31, 20, , ,
    WAIT
    DELAY 400

    FOR i=0 TO 4
        MOVE G6A, 95, 96, 89, 132, 105,
        MOVE G6D, 95, 96, 89, 132, 105,
        MOVE G6B,  71,  30, 102,  ,  ,
        MOVE G6C,137, 31, 20, , ,
        WAIT
        DELAY 330
        MOVE G6A,  96, 105,  96, 103, 104,  
		MOVE G6D,  96, 105,  96, 103, 104,  
		MOVE G6B,  71,  30, 102,  ,  ,  
		MOVE G6C, 137,  31,  20,  ,  ,  
		WAIT
		DELAY 330
    NEXT i


    MOVE G6A,  95, 106, 109,  87, 108,
    MOVE G6D,  95, 106, 109,  87, 108,
    MOVE G6B,  67,  61,  82,  ,  ,
    MOVE G6C, 146,  64,  80,  ,  ,
    WAIT
    GOSUB STANDARD_POSE

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,115
    MOVE G6B,85
    WAIT
	DELAY 200
  '  SPEED 10
'    MOVE G6A,93,  46, 145,  123, 105, 100
'    MOVE G6D,93,  106, 145,  63, 105, 100
'    WAIT

    SPEED 8

    GOSUB Leg_motor_mode2
    
    GOSUB standard_pose


    RETURN
    HIGHSPEED SETOFF




dangerous_motherday:
    '按0

    MOVE G6A,  81,  99, 133,  82, 119,
    MOVE G6D,  91, 106,  96, 114, 110,
    MOVE G6B,  59,  43,  93,  ,  ,130
    MOVE G6C, 126,  29,  82,  ,  ,
    WAIT
    DELAY 1000
    SPEED 14
    MOVE G6A,  81,  99, 133,  82, 119,
    MOVE G6D,  91, 106,  96, 114, 110,
    MOVE G6B,  71,  40, 128,  ,  ,130
    MOVE G6C, 153,  42, 126,  ,  ,
    WAIT
    DELAY 300
    HIGHSPEED SETON
    SPEED 7
    MOVE G6A,  96,  99, 111, 103, 105,
    MOVE G6D,  99, 102, 102, 111, 103,
    MOVE G6B, 134,  17,  71,  ,  ,100
    MOVE G6C, 141,  13,  73,  ,  ,
    WAIT
    HIGHSPEED SETOFF

    '*********************（迈右脚）***************************
    'MOVE G6A,  96,  99, 111, 103, 105,
    '    MOVE G6D,  99, 102, 102, 111, 103,
    '    MOVE G6B, 102,  46,  62,  ,  ,
    '    MOVE G6C, 102,  46,  62,  ,  ,
    '    WAIT

    '*************************************




    MOVE G6A, 109, 103, 111, 103, 101,
    MOVE G6D,  96,  99, 109, 110, 103,
    MOVE G6B, 102,  46,  62,  ,  ,
    MOVE G6C, 102,  46,  62,  ,  ,
    WAIT













    '*****************************



    MOVE G6A, 115, 101,  94, 119,  91,
    MOVE G6D,  95, 109,  81, 115, 107,
    MOVE G6B,  68,  15,  54,  ,  ,
    MOVE G6C,  75,  31,  47,  ,  ,
    WAIT

    MOVE G6A, 115, 101,  94, 119,  91,
    MOVE G6D,  96, 119,  41, 139, 126,
    MOVE G6B,  68,  15,  54,  ,  ,
    MOVE G6C,  75,  31,  47,  ,  ,
    WAIT


    MOVE G6A, 115, 101,  94, 119,  91,
    MOVE G6D,  81,  70, 107, 142, 127,
    MOVE G6B,  68,  15,  54,  ,  ,
    MOVE G6C,  75,  31,  47,  ,  ,
    WAIT
    MOVE G6A, 111, 101, 100, 119,  94,
    MOVE G6D,  80,  69, 114, 129, 122,
    MOVE G6B,  68,  15,  54,  ,  ,
    MOVE G6C,  75,  31,  47,  ,  ,
    WAIT

    '***********************************************************

    MOVE G6A, 111, 101, 100, 119,  94,
    MOVE G6D, 105,  85,  64, 156, 110,
    MOVE G6B,  68,  15,  54,  ,  ,
    MOVE G6C,  75,  31,  47,  ,  ,
    WAIT

    MOVE G6A,  96,  99, 111, 103, 105,
    MOVE G6D,  99, 102, 102, 111, 103,
    MOVE G6B,  68,  15,  54,  ,  ,
    MOVE G6C,  75,  31,  47,  ,  ,
    WAIT
    '*************************************************************









    '******************************迈左脚（复制上面代码，改动ADBC为DACB）*********************************
    MOVE G6D,  96,  99, 111, 103, 105,
    MOVE G6A,  99, 102, 102, 111, 103,
    MOVE G6C,  68,  15,  54,  ,  ,
    MOVE G6B,  75,  31,  47,  ,  ,
    WAIT



    MOVE G6D, 115, 101,  94, 119,  91,
    MOVE G6A,  95, 109,  81, 115, 107,
    MOVE G6C,  68,  15,  54,  ,  ,
    MOVE G6B,  75,  31,  47,  ,  ,
    WAIT

    MOVE G6D, 115, 101,  94, 119,  91,
    MOVE G6A,  96, 119,  41, 139, 126,
    MOVE G6C,  68,  15,  54,  ,  ,
    MOVE G6B,  75,  31,  47,  ,  ,
    WAIT


    MOVE G6D, 115, 101,  94, 119,  91,
    MOVE G6A,  81,  70, 107, 142, 127,
    MOVE G6C,  68,  15,  54,  ,  ,
    MOVE G6B,  75,  31,  47,  ,  ,
    WAIT
    MOVE G6D, 111, 101, 100, 119,  94,
    MOVE G6A,  80,  69, 114, 129, 122,
    MOVE G6C,  68,  15,  54,  ,  ,
    MOVE G6B,  75,  31,  47,  ,  ,
    WAIT

    '***********************************************************
    MOVE G6D, 111, 101, 100, 119,  94,
    MOVE G6A, 105,  85,  64, 156, 110,
    MOVE G6C,  68,  15,  54,  ,  ,
    MOVE G6B,  75,  31,  47,  ,  ,
    WAIT

    MOVE G6D,  96,  99, 111, 103, 105,
    MOVE G6A,  99, 102, 102, 111, 103,
    MOVE G6C,  68,  15,  54,  ,  ,
    MOVE G6B,  75,  31,  47,  ,  ,
    WAIT



    RETURN




dangerous_tong:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    HIGHSPEED SETOFF
    SPEED 15
MOVE G6A, 100,  80, 145,  87, 100,
        MOVE G6D, 100,  80, 145,  87, 100,
        MOVE G6B,  65,  30,  80,  ,  ,
        MOVE G6C,  65,  30,  80,  ,  ,
        WAIT
        
        DELAY 200


    FOR i=1 TO 4


        MOVE G6A, 100,  80, 145,  87, 100,
        MOVE G6D, 100,  80, 145,  87, 100,
        MOVE G6B,  65,  30,  80,  ,  ,
        MOVE G6C,  65,  30,  80,  ,  ,
        WAIT

        DELAY 150

        MOVE G6A, 100,  95, 145,  55, 100,
        MOVE G6D, 100,  95, 145,  55, 100,
        MOVE G6B,  65,  30,  80,  ,  ,
        MOVE G6C,  65,  30,  80,  ,  ,
        WAIT


    NEXT i

    MOVE G6A, 100,  80, 145,  80, 100,
    MOVE G6D, 100,  80, 145,  80, 100,
    MOVE G6B,  65,  30,  80,  ,  ,
    MOVE G6C,  65,  30,  80,  ,  ,
    WAIT

    RETURN










dangerous_papa:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3


    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 101,  76, 145,  93, 100,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    DELAY 100
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3

    HIGHSPEED SETON
    SPEED 8
    MOVE G6A,  95,  90, 120, 105, 105,
    MOVE G6D,  95,  90, 120, 105, 105,
    MOVE G6B, 101,  62,  81,  ,  ,  170
    MOVE G6C, 101,  62,  81,  ,  ,
    WAIT

    DELAY 100

    MOVE G6A,  95,  90, 120, 105, 105,
    MOVE G6D,  95,  90, 120, 105, 105,
    MOVE G6B, 104,  51,  77,  ,  ,
    MOVE G6C, 104,  51,  77,  ,  ,
    WAIT



    MOVE G6A,  95,  90, 120, 105, 105,
    MOVE G6D,  95,  90, 120, 105, 105,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,


    DELAY 200

    MOVE G6A,  95,  90, 120, 109, 105,
    MOVE G6D,  61,  99,  94, 123, 105,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT


    DELAY 400
    '

    HIGHSPEED SETOFF
    SPEED 10
    MOVE G6A,  95,  90, 120, 105, 105,
    MOVE G6D,  95,  90, 120, 105, 105,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,


    DELAY 200

    MOVE G6A,  95,  76, 145,  93, 105,
    MOVE G6D,  95,  76, 145,  93, 105,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT



    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 100,  30,  80,  ,  ,170
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT



    DELAY 1400
    '    '
    '
    '	
    '
    '    '****************************************
    SPEED 12
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT




    DELAY 800

    MOVE G6A,  91,  90, 100, 130, 110,
    MOVE G6D,  91,  90, 100, 130, 110,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    DELAY 80
    MOVE G6B, 100,  30,  80,  ,  , 100
    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    ' ****************抬右手




    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 141,  48,  68,  ,  ,
    WAIT

    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 156,  26,  45,  ,  ,
    WAIT



    MOVE G6B, 100,  30,  80,  ,  ,  170
    MOVE G6A,  91,  90, 100, 130, 110,
    MOVE G6D,  91,  90, 100, 130, 110,
    MOVE G6C, 156,  26,  45,  ,  ,
    WAIT
    DELAY 80

    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 156,  26,  45,  ,  ,
    WAIT


    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6B, 157,  42,  62,  ,  ,
    MOVE G6C, 183,  19,  10,  ,  ,
    WAIT





    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6B, 181,  10,  35,  ,  ,
    MOVE G6C, 183,  19,  10,  ,  ,
    WAIT






    ' *******************************


    ' 蹲起转头
    MOVE G6A,  91,  90, 100, 130, 110,
    MOVE G6D,  91,  90, 100, 130, 110,
    MOVE G6B, 181,  10,  35,  ,  ,
    MOVE G6C, 183,  19,  10,  ,  ,
    WAIT
    DELAY 80
    MOVE G6B, 181,  10,  35,  ,  ,  100
    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
	MOVE G6C, 183,  19,  10,  ,  ,
    WAIT
    '********上下****



	MOVE G6B, 156,  11,  36,  ,  ,  
	MOVE G6C, 158,  23,  12,  ,  ,  
    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    WAIT
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,
    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    WAIT
    ' *****************************


    MOVE G6B, 181,  10,  35,  ,  ,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6A,  91,  90, 100, 130, 110,
    MOVE G6D,  91,  90, 100, 130, 110,
    WAIT
    DELAY 80

    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,  40
    WAIT
    ' **************张臂1**************
    DELAY 80

    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6B, 181,  52,  47,  ,  ,
    MOVE G6C, 183,  52,  47,  ,  ,
    WAIT


    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,
    WAIT

    MOVE G6A,  91,  90, 100, 130, 110,
    MOVE G6D,  91,  90, 100, 130, 110,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,  100
    WAIT
    DELAY 80

    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,  100
    WAIT
    DELAY 80
    ' ***************问题*******************

    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6B, 181,  52,  47,  ,  ,
    MOVE G6C, 183,  52,  47,  ,  ,
    WAIT


    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,
    WAIT

    MOVE G6A,  91,  90, 100, 130, 110,
    MOVE G6D,  91,  90, 100, 130, 110,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,  100
    WAIT
    DELAY 80

    MOVE G6A,  90,  90, 105, 120, 110,
    MOVE G6D,  90,  90, 105, 120, 110,
    MOVE G6C, 183,  19,  10,  ,  ,
    MOVE G6B, 181,  10,  35,  ,  ,  100
    WAIT

    DELAY 180




    RETURN



    'team1 6.2
front_walk_3_1:
    IF step = 3 THEN
        GOTO standard_pose
        RETURN
    ENDIF
    step = step + 1
    SPEED walk_speed
    MOVE G6A, 85,  44, 163, 113, 114
    MOVE G6D,110,  77, 146,  93,  94
    WAIT

    SPEED left_right_speed
    MOVE G6A,110,  76, 144, 100,  93
    MOVE G6D,85, 93, 155,  71, 112
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF


    SPEED walk_speed
    MOVE G6A,111,  77, 146,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, front_walk_3_2
    IF A <> A_old THEN
        HIGHSPEED SETOFF

        SPEED 5
        MOVE G6A, 106,  76, 146,  93,  96		
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT	


        SPEED 3
        GOSUB standard_pose
        GOSUB Leg_motor_mode1
        GOTO RX_EXIT
    ENDIF
    '**********


front_walk_3_2:
    IF step = 3 THEN
        GOTO standard_pose
        RETURN
    ENDIF
    step = step+1
    SPEED walk_speed
    MOVE G6D,85,  44, 163, 113, 114
    MOVE G6A,110,  77, 146,  93,  94
    WAIT

    SPEED left_right_speed
    MOVE G6D,110,  76, 144, 100,  93
    MOVE G6A, 85, 93, 155,  71, 112
    WAIT

    GOSUB front_back_tilt_check
    IF fall_check = 1 THEN
        fall_check = 0
        GOTO MAIN
    ENDIF

    SPEED walk_speed
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,111,  77, 146,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    ERX 4800,A, front_walk_3_1
    IF A <> A_old THEN
        HIGHSPEED SETOFF
        SPEED 5
        MOVE G6D, 106,  76, 146,  93,  96		
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT

        SPEED 3
        GOSUB standard_pose
        GOSUB Leg_motor_mode1
        GOTO RX_EXIT
    ENDIF


    GOTO front_walk_3_1
    '************************************************
    '************************************************
    '************************************************

begin_for_robot1:
    DELAY 1500
    SPEED 10
    MOVE G6A,100, 155,  28, 124, 100, 100
    MOVE G6D,101, 150,  24, 129, 100, 100
    WAIT

    DELAY 2000
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    DELAY 200

    '第一个动作
    SPEED 15
    MOVE G6B,101, 102, 190, 100, 100, 100
    MOVE G6C,101, 102, 190, 100, 100, 100
    WAIT
    DELAY 600
    '直立
    SPEED 15
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    DELAY 650

    '第二个动作
    SPEED 15
    MOVE G6B,103,  53,  96, 100, 100, 101
    MOVE G6C,103,  53,  96, 100, 100, 100
    WAIT
    DELAY 900

    '直立
    SPEED 15
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    DELAY 800

    '第三个动作
    SPEED 15
    MOVE G6B,101, 102, 190, 100, 100, 100
    MOVE G6C,101, 102, 190, 100, 100, 100
    WAIT
    DELAY 600


    GOSUB queue_change_for_robot1
    '上跳
    SPEED 10
    MOVE G6A,88,  76, 145,  93, 110
    MOVE G6D,88,  76, 145,  93, 110
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    DELAY 600

    '左侧身
    SPEED 8
    MOVE G6A,  91, 120,  67, 119, 124,
    MOVE G6D,  78,  94, 115,  98, 108,
    MOVE G6B, 100,  83,  99,  ,  ,
    MOVE G6C, 102, 106,  98,  ,  ,
    DELAY 900
    'right
    MOVE G6A,  78,  94, 115,  98, 108,
    MOVE G6D,  91, 120,  67, 119, 124,
    MOVE G6B, 102, 106,  98,  ,  ,
    MOVE G6C, 100,  83,  99,  ,  ,
    DELAY 2800
    'left
    MOVE G6A,  91, 120,  67, 119, 124,
    MOVE G6D,  78,  94, 115,  98, 108,
    MOVE G6B, 100,  83,  99,  ,  ,
    MOVE G6C, 102, 106,  98,  ,  ,
    DELAY 2200
    'right
    MOVE G6A,  78,  94, 115,  98, 108,
    MOVE G6D,  91, 120,  67, 119, 124,
    MOVE G6B, 102, 106,  98,  ,  ,
    MOVE G6C, 100,  83,  99,  ,  ,
    DELAY 2200
    GOTO standard_pose

    RETURN


begin_for_robot2:
    DELAY 1500
    SPEED 10
    MOVE G6A,100, 155,  28, 124, 100, 100
    MOVE G6D,101, 150,  24, 129, 100, 100
    WAIT
    DELAY 2000

    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    DELAY 200

    '第一个动作
    SPEED 15
    MOVE G6B,103,  53,  96, 100, 100, 101
    MOVE G6C,103,  53,  96, 100, 100, 100
    WAIT
    DELAY 950

    '直立
    SPEED 15
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    DELAY 850

    '第二个动作
    SPEED 15
    MOVE G6B,101, 102, 190, 100, 100, 100
    MOVE G6C,101, 102, 190, 100, 100, 100
    WAIT
    DELAY 600


    '直立
    SPEED 15
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    DELAY 800

    '第三个动作

    SPEED 15
    MOVE G6B,103,  53,  96, 100, 100, 101
    MOVE G6C,103,  53,  96, 100, 100, 100
    WAIT
    DELAY 850

    GOSUB left_tumbling

    GOSUB back_walk_3
    DELAY 1500
    '上跳
    SPEED 10
    MOVE G6A,88,  76, 145,  93, 110
    MOVE G6D,88,  76, 145,  93, 110
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    DELAY 600

    '左侧身
    SPEED 8
    MOVE G6A,  91, 120,  67, 119, 124,
    MOVE G6D,  78,  94, 115,  98, 108,
    MOVE G6B, 100,  83,  99,  ,  ,
    MOVE G6C, 102, 106,  98,  ,  ,
    DELAY 900
    'right
    MOVE G6A,  78,  94, 115,  98, 108,
    MOVE G6D,  91, 120,  67, 119, 124,
    MOVE G6B, 102, 106,  98,  ,  ,
    MOVE G6C, 100,  83,  99,  ,  ,
    DELAY 2800
    'left
    MOVE G6A,  91, 120,  67, 119, 124,
    MOVE G6D,  78,  94, 115,  98, 108,
    MOVE G6B, 100,  83,  99,  ,  ,
    MOVE G6C, 102, 106,  98,  ,  ,
    DELAY 2200
    'right
    MOVE G6A,  78,  94, 115,  98, 108,
    MOVE G6D,  91, 120,  67, 119, 124,
    MOVE G6B, 102, 106,  98,  ,  ,
    MOVE G6C, 100,  83,  99,  ,  ,
    DELAY 2200
    GOTO standard_pose

    RETURN

begin_for_robot3:
    'GOTO after_tumbling
    DELAY 1500
    SPEED 10
    MOVE G6A,100, 155,  28, 124, 100, 100
    MOVE G6D,101, 150,  24, 129, 100, 100
    WAIT
    DELAY 2000

    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    DELAY 200

    '第一个动作
    SPEED 15
    MOVE G6B,101,  99, 100, 100, 100, 100
    MOVE G6C,102, 100, 100, 100, 100, 100
    WAIT
    DELAY 750

    '直立
    SPEED 15
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    DELAY 700


    '第二个动作
    SPEED 15
    MOVE G6B,102, 151, 100, 100, 100, 100
    MOVE G6C,102, 151, 100, 100, 100, 100
    WAIT
    DELAY 600

    '直立
    SPEED 15
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    DELAY 500


    '第三个动作
    SPEED 15
    MOVE G6B,101,  99, 100, 100, 100, 100
    MOVE G6C,102, 100, 100, 100, 100, 100
    WAIT
    DELAY 900

    '	'直立
    '    SPEED 15
    '    MOVE G6B,100,  30,  80, 100, 100, 100
    '    MOVE G6C,100,  30,  80, 100, 100, 100
    '    WAIT
    '    DELAY 600

    GOSUB right_tumbling
    'after_tumbling:
    GOSUB front_walk_3
    DELAY 400
    '上跳侧身
    SPEED 10
    MOVE G6A,88,  76, 145,  93, 110
    MOVE G6D,88,  76, 145,  93, 110
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    DELAY 900
    '右侧身
    SPEED 8
    MOVE G6A,  78,  94, 115,  98, 108,
    MOVE G6D,  91, 120,  67, 119, 124,
    MOVE G6B, 102, 106,  98,  ,  ,
    MOVE G6C, 100,  83,  99,  ,  ,

    'DELAY 3000
    DELAY 1500
    '左侧身
    MOVE G6A,  91, 120,  67, 119, 124,
    MOVE G6D,  78,  94, 115,  98, 108,
    MOVE G6B, 100,  83,  99,  ,  ,
    MOVE G6C, 102, 106,  98,  ,  ,
    DELAY 2800
    '右侧身
    MOVE G6A,  78,  94, 115,  98, 108,
    MOVE G6D,  91, 120,  67, 119, 124,
    MOVE G6B, 102, 106,  98,  ,  ,
    MOVE G6C, 100,  83,  99,  ,  ,
    DELAY 2200
    '左侧身
    MOVE G6A,  91, 120,  67, 119, 124,
    MOVE G6D,  78,  94, 115,  98, 108,
    MOVE G6B, 100,  83,  99,  ,  ,
    MOVE G6C, 102, 106,  98,  ,  ,
    DELAY 2200
    GOTO standard_pose
    RETURN

begin_for_robot4:
    DELAY 1500
    SPEED 10
    MOVE G6A,100, 155,  28, 124, 100, 100
    MOVE G6D,101, 150,  24, 129, 100, 100
    WAIT
    DELAY 2000

    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    DELAY 200

    '第一个动作

    SPEED 15
    MOVE G6B,102, 151, 100, 100, 100, 100
    MOVE G6C,102, 151, 100, 100, 100, 100
    WAIT
    DELAY 600

    '直立
    SPEED 15
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    DELAY 400

    '第二个动作

    SPEED 15
    MOVE G6B,101,  99, 100, 100, 100, 100
    MOVE G6C,102, 100, 100, 100, 100, 100
    WAIT
    DELAY 850

    '直立
    SPEED 15
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT
    DELAY 600

    '第三个动作

    SPEED 15
    MOVE G6B,102, 151, 100, 100, 100, 100
    MOVE G6C,102, 151, 100, 100, 100, 100
    WAIT
    DELAY 600
    GOSUB queue_change_for_robot4
    DELAY 350
    SPEED 10
    MOVE G6A,88,  76, 145,  93, 110
    MOVE G6D,88,  76, 145,  93, 110
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    DELAY 900
    '右侧身
    SPEED 8
    MOVE G6A,  78,  94, 115,  98, 108,
    MOVE G6D,  91, 120,  67, 119, 124,
    MOVE G6B, 102, 106,  98,  ,  ,
    MOVE G6C, 100,  83,  99,  ,  ,

    'DELAY 3000
    DELAY 1500
    '左侧身
    MOVE G6A,  91, 120,  67, 119, 124,
    MOVE G6D,  78,  94, 115,  98, 108,
    MOVE G6B, 100,  83,  99,  ,  ,
    MOVE G6C, 102, 106,  98,  ,  ,
    DELAY 2800
    '右侧身
    MOVE G6A,  78,  94, 115,  98, 108,
    MOVE G6D,  91, 120,  67, 119, 124,
    MOVE G6B, 102, 106,  98,  ,  ,
    MOVE G6C, 100,  83,  99,  ,  ,
    DELAY 2200
    '左侧身
    MOVE G6A,  91, 120,  67, 119, 124,
    MOVE G6D,  78,  94, 115,  98, 108,
    MOVE G6B, 100,  83,  99,  ,  ,
    MOVE G6C, 102, 106,  98,  ,  ,
    DELAY 2200
    GOTO standard_pose
    RETURN


for_robot1:
    GOSUB begin_for_robot1
    'GOSUB DayByDay
    RETURN

for_robot2:
    GOSUB begin_for_robot2
    'GOSUB DayByDay

    RETURN

for_robot3:
    GOSUB begin_for_robot3

    'GOSUB DayByDay

    RETURN

for_robot4:
    GOSUB begin_for_robot4
    'GOSUB DayByDay

    RETURN

last_test:
    DELAY 200
    HIGHSPEED SETON
    SPEED 8
    '收尾
    '屈腿弯臂
    MOVE G6A,  95,  90, 120, 100, 115,
    MOVE G6D,  92,  76, 145,  93, 100,
    MOVE G6B, 103, 100,  11,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    DELAY 200
    '伸直手臂
    MOVE G6A,  95,  90, 120, 100, 115,
    MOVE G6D,  ,  76, 145,  93, 100,
    MOVE G6B, 103, 100, 102,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT
    DELAY 500
    '换腿继续
    MOVE G6D,  95,  90, 120, 100, 115,
    MOVE G6A,  ,  76, 145,  93, 100,
    MOVE G6B, 103, 100, 102,  ,  ,
    MOVE G6C, 103, 100,  11,  ,  ,
    WAIT

    DELAY 600
    MOVE G6D,  95,  90, 120, 100, 115,
    MOVE G6A,  ,  76, 145,  93, 100,
    MOVE G6C, 103, 100, 102,  ,  ,
    MOVE G6B, 103, 100, 102,  ,  ,
    WAIT

    DELAY 600
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT

    DELAY 400
    MOVE G6B, 188, 101, 103,  ,  ,
    MOVE G6C, 188, 101, 103,  ,  ,
    WAIT

    DELAY 400
    MOVE G6B, 13, 104,  97, 100, 100, 100
    MOVE G6C,188, 101,  98, 100, 100, 100
    WAIT

    DELAY 400
    MOVE G6B,188,  99,    , 100, 100, 100
    MOVE G6C, 13, 104,  97, 100, 100, 100
    WAIT

    DELAY 400
    MOVE G6B,188,  99,  18 ,100, 100, 100
    MOVE G6C, 13, 102,  18, 100, 100, 100
    WAIT

    DELAY 400
    MOVE G6B, 13, 100,  15, 100, 100, 100
    MOVE G6C,190, 100,  14, 100, 100, 100
    WAIT

    DELAY 400
    MOVE G6B,100, 100,  15, 100, 100, 100
    MOVE G6C,100, 100,  21, 100, 100,  28
    WAIT

    HIGHSPEED SETOFF
    DELAY 400
    tilt_measurement_check = 0
    SPEED 8
    MOVE G6A,102,  98, 141,  31,  99, 100
    MOVE G6D,100, 101, 141,  34, 100, 100
    MOVE G6B,101,  96, 103, 100, 100, 100
    MOVE G6C,100, 105,  99, 100, 100, 100
    WAIT
    DELAY 300
    MOVE G6A,102, 148,  83,  12,  99, 100
    MOVE G6D,101, 151,  81,  19,  99, 100
    MOVE G6B,188,  82,  67, 100, 100, 100
    MOVE G6C,188,  82,  67, 100, 100, 100
    WAIT
    RETURN

    'team3 6.3

daybyday:

    '
    GOSUB daybyday1
    GOSUB All_motor_mode3
    '
   
        GOSUB chatui
        DELAY 200
        GOSUB niupigu
        GOSUB chatui1
        DELAY 200
        GOSUB niupigu
  

    GOSUB All_motor_mode3

    GOSUB Recover
    DELAY 500
    GOSUB BeforeLast1

    'GOSUB Zhanghaipengpose

    RETURN


    '恢复动作,避免打手

daybyday1:
    '**********************抖手
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    HIGHSPEED SETON

    FOR i=0 TO 0
        SPEED 6


        MOVE G6A, 100,  76, 138, 102, 100,
        MOVE G6D, 100,  76, 138, 102, 100,
        MOVE G6B,  59,  15,  39,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,

        MOVE G6B,  56,  36,  35,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,
        MOVE G6A, 100,  76, 138, 102, 100,
        MOVE G6D,  95,  76, 137, 102, 107,

        MOVE G6A, 101,  76, 138, 102,  97,
        MOVE G6D,  90,  76, 137, 102, 113,
        MOVE G6B,  68,  58,  35,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,



        MOVE G6A, 105,  76, 138, 102,  93,
        MOVE G6D,  86,  76, 137, 102, 120,


        SPEED 8


        MOVE G6B, 122,  71,  12,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,


        SPEED 6

        MOVE G6B, 101, 142,  57,  ,  ,10
        MOVE G6C,  63,  50,  10,  ,  ,


        MOVE G6B, 101, 134,  88,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,


        MOVE G6B,  94, 114, 125,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,


        MOVE G6B,  95,  99,  90,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,
        '
        '
        ''****
        MOVE G6B, 122,  71,  12,  ,  ,100
        MOVE G6C,  63,  50,  10,  ,  ,
        MOVE G6A, 101,  76, 138, 102,  97,
        MOVE G6D,  90,  76, 137, 102, 113,



        MOVE G6B,  68,  58,  35,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,
        MOVE G6A, 100,  76, 138, 102, 100,
        MOVE G6D,  95,  76, 137, 102, 107,

        MOVE G6B,  56,  36,  35,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,

        MOVE G6B,  59,  15,  39,  ,  ,
        MOVE G6C,  63,  50,  10,  ,  ,
        MOVE G6A, 100,  76, 138, 102, 100,
        MOVE G6D, 100,  76, 138, 102, 100,


        ''***********secend**********
        MOVE G6D, 100,  76, 138, 102, 100,
        MOVE G6A, 100,  76, 138, 102, 100,
        MOVE G6C,  59,  15,  39,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,

        MOVE G6C,  56,  36,  35,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,
        MOVE G6D, 100,  76, 138, 102, 100,
        MOVE G6A,  95,  77, 137, 102, 107,

        MOVE G6D, 101,  76, 138, 102,  97,
        MOVE G6A,  90,  76, 137, 102, 113,
        MOVE G6C,  68,  58,  35,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,



        MOVE G6D, 105,  76, 138, 102,  93,
        MOVE G6A,  86,  76, 137, 102, 120,

        SPEED 8


        MOVE G6C, 122,  71,  12,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,


        ''************************************
        SPEED 6

        MOVE G6C, 101, 142,  57,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,190


        MOVE G6C, 101, 134,  88,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,


        MOVE G6C,  94, 114, 125,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,


        MOVE G6C,  95,  99,  90,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,


        '****
        MOVE G6C, 122,  71,  12,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,100
        MOVE G6D, 101,  76, 138, 102,  97,
        MOVE G6A,  90,  76, 137, 102, 113,



        MOVE G6C,  68,  58,  35,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,
        MOVE G6D, 100,  76, 138, 102, 100,
        MOVE G6A,  95,  76, 137, 102, 107,

        MOVE G6C,  56,  36,  35,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,

        MOVE G6C,  59,  15,  39,  ,  ,
        MOVE G6B,  63,  50,  10,  ,  ,
        MOVE G6D, 100,  76, 138, 102, 100,
        MOVE G6A, 100,  76, 138, 102, 100,

    NEXT i
    HIGHSPEED SETOFF
    DELAY 200
    '    '***********************第二个八怕*****
    MOVE G6C,  59,  15,  39,  ,  ,
    MOVE G6B,  63,  50,  10,  ,  ,
    MOVE G6D, 100,  76, 138, 102, 100,
    MOVE G6A, 100,  76, 138, 102, 100,
    'HIGHSPEED SETOFF
    SPEED 12





    MOVE G6B,  83, 187, 140,  ,  ,
    MOVE G6C,  83, 187, 140,  ,  ,

    DELAY 350
    SPEED 6
    MOVE G6C,  83, 187, 140,  ,  ,
    MOVE G6A,  98, 129,  26, 161, 104,
    MOVE G6D,  47,  49, 183,  86, 151,
    MOVE G6B,  83, 187, 140,  ,  ,  10
    WAIT
    MOVE G6A, 103,  78, 137, 111,  96,
    MOVE G6D,  66,  54, 164, 105, 118,
    WAIT

    MOVE G6A, 100,  76, 145,  98, 100,
    MOVE G6D, 100,  76, 145,  98, 100,
    MOVE G6B,  83, 187, 140,  ,  ,100
    MOVE G6C,  83, 187, 140,  ,  ,
    '
    '    '******************************disangebapai
    '
    MOVE G6A,  93,  96, 111, 107, 109,
    MOVE G6D,  87,  89, 120, 103, 109,
    DELAY 200

    SPEED 8
    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,

    WAIT


    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6D,  99,  96, 111, 107,  82,

    WAIT

    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,

    WAIT

    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6D,  99,  96, 111, 107,  82,

    WAIT



    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B, 100, 122, 133,  ,  ,
    MOVE G6C,  97, 131, 124,  ,  ,
    WAIT

    MOVE G6A,  72,  89, 120, 103, 142,
    MOVE G6D,  99,  96, 111, 107,  82,
    MOVE G6B,  61,  51,  71,  ,  ,
    MOVE G6C,  62,  52,  76,  ,  ,
    WAIT
    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B,  52,  26,  50,  ,  ,
    MOVE G6C,  54,  45,  38,  ,  ,
    WAIT
    MOVE G6A,  93,  96, 111, 107, 109,
    MOVE G6D,  87,  89, 120, 103, 109,


    '**********************************

    SPEED 15

    MOVE G6B, 100,  44, 188,  ,  ,
    MOVE G6C, 101,  55, 186,  ,  ,
    WAIT
    SPEED 5


    MOVE G6A,102,  78, 139,  98, 84
    MOVE G6D,92,  90, 115,  110, 122
    WAIT

    SPEED 5
    MOVE G6D,108,  92, 119,  106, 99
    MOVE G6A,86,  76, 145,  94, 107





    WAIT

    SPEED 5




    MOVE G6D, 108,  92, 127,  94,  99,
    MOVE G6A,  89,  86, 141,  87, 107,







    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100



    DELAY 600
    HIGHSPEED SETON
    SPEED 10



    'GOSUB zhanli
    '********************
    MOVE G6D,  91,  78, 144,  99, 103,
    MOVE G6A, 105,  91, 122, 107, 101,
    MOVE G6C, 102, 102,  10,  ,  ,
    MOVE G6B, 190, 100,  12,  ,  ,
    WAIT
    HIGHSPEED SETOFF
    DELAY 170
    '
    SPEED 15
    MOVE G6A,  91,  78, 144,  99, 103,
    MOVE G6D, 105,  91, 122, 107, 101,
    MOVE G6B, 102, 102,  10,  ,  ,
    MOVE G6C, 190, 100,  12,  ,  ,
    WAIT



    DELAY 170


    MOVE G6D,  90,  78, 144,  99, 103,
    MOVE G6A, 105,  91, 122, 107, 101,
    MOVE G6C, 102, 102,  10,  ,  ,
    MOVE G6B, 190, 100,  12,  ,  ,
    WAIT

    '**************************************
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    RETURN

Recover:
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 144,  59,  80,  ,  ,
    MOVE G6C, 142,  72,  73,  ,  ,
    WAIT
    RETURN


    '蹲下起立,最后动作前
BeforeLast:
    SPEED 4
    MOVE G6A,  98, 129,  26, 156, 104,
    MOVE G6D,  45,  39, 183,  84, 152,
    MOVE G6B, 102,  12,  90,  ,  ,  10
    MOVE G6C,  75,  46,  94,  ,  ,
    WAIT

    SPEED 5
    MOVE G6A, 103, 118,  72, 132,  96,
    MOVE G6D,  46,  49, 166, 103, 143,

    SPEED 8
    MOVE G6B, 105,  18, 187,  ,  ,
    MOVE G6C,  75,  46,  94,  ,  ,
    WAIT

    MOVE G6A, 103,  78, 137, 111,  96,
    MOVE G6D,  46,  49, 166, 103, 128,
    MOVE G6C,  75,  46,  94,  ,  ,
    MOVE G6B, 105,  98, 187,  ,  ,
    WAIT


    MOVE G6B, 105, 143, 187,  ,  ,
    SPEED 5
    MOVE G6D,  61,  49, 166, 103, 118,
    WAIT


    SPEED 8

    MOVE G6B, 105, 188,  92,  ,  ,  60
    MOVE G6D,  76,  54, 166, 103, 118,

    WAIT


    MOVE G6B, 105, 163,  32,  ,  ,
    MOVE G6C,  75,  46,  94,  ,  ,
    WAIT


    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B, 105,  57,  27,  ,  ,  100
    WAIT


    SPEED 8
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT

    RETURN

BeforeLast1:
    SPEED 5


    MOVE G6A,  98, 129,  26, 161, 104,
    MOVE G6D,  46,  61, 164,  89, 156,
    MOVE G6B, 103,  16,  91,  ,  ,
    MOVE G6C,  75,  46,  94,  ,  ,


    SPEED 5

    SPEED 8
    MOVE G6B, 105,  18, 187,  ,  ,
    MOVE G6C,  75,  46,  94,  ,  ,
    WAIT
    MOVE G6A, 103,  78, 137, 111,  96,
    MOVE G6D,  66,  54, 164, 105, 118,
    MOVE G6C,  75,  46,  94,  ,  ,
    MOVE G6B, 105,  98, 187,  ,  ,
    WAIT


    SPEED 8




    MOVE G6A, 103,  78, 137, 111,  96,
    MOVE G6B, 105, 188,  92,  ,  ,  60
    MOVE G6D,  76,  54, 166, 103, 118,

    WAIT

    SPEED 6
    MOVE G6B, 81, 188,  105,  ,  ,  70
    MOVE G6C,  83, 81,  103,  ,  ,

    WAIT

    SPEED 5
    MOVE G6B, 58, 188,  118,  ,  ,  80
    MOVE G6C,  91,  116,  112,  ,  ,

    WAIT

    SPEED 5
    MOVE G6B, 35, 188,  131,  ,  ,  90
    MOVE G6C,  99,  151,  120,  ,  ,

    WAIT

    SPEED 4

MOVE G6B,  12, 188, 151,  ,  , 100 
MOVE G6C, 109, 190, 144,  ,  ,  

    WAIT
    DELAY 1000
    SPEED 8
    MOVE G6A, 100,  60, 176,  75, 102,
    MOVE G6D, 100,  60, 176,  75, 102,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    RETURN

    RETURN

Zhanghaipengpose:
    SPEED 8
    MOVE G6B, 105, 188,  92,  ,  ,  60
    MOVE G6D,  76,  54, 166, 103, 118,

    WAIT

    SPEED 6
    MOVE G6B, 81, 188,  105,  ,  ,  70
    MOVE G6C,  83, 81,  103,  ,  ,

    WAIT

    SPEED 5
    MOVE G6B, 58, 188,  118,  ,  ,  80
    MOVE G6C,  91,  116,  112,  ,  ,

    WAIT

    SPEED 5
    MOVE G6B, 35, 188,  131,  ,  ,  90
    MOVE G6C,  99,  151,  120,  ,  ,

    WAIT

    SPEED 5
    MOVE G6B,  12, 188, 143,  ,  ,100
    MOVE G6C, 107, 186, 128,  ,  ,
    WAIT
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100

    WAIT

    SPEED 4
    ' tall stand
    MOVE G6A, 100,  60, 176,  75, 102,
    MOVE G6D, 100,  60, 176,  75, 102,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT


    SPEED 10

    ' move center of gravity to right leg

    MOVE G6A,  88,  60, 176,  75, 110,
    MOVE G6D, 108,  60, 176,  75,  94,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    ' uplift the left leg
    MOVE G6A,  92,  75,  96, 107, 112,
    MOVE G6D, 113,  60, 176,  75,  96,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    ' feitian pose
    MOVE G6A,  78,  10, 140,  13, 122,
    MOVE G6D, 111,  60, 176,  91,  96,
    MOVE G6B, 148, 188, 150,  ,  , 130
    MOVE G6C, 143, 190, 138,  ,  ,
    WAIT

    DELAY 1000

    ' uplift the left leg
    MOVE G6A,  92,  75,  96, 107, 112,
    MOVE G6D, 113,  60, 176,  75,  96,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT


    ' move center of gravity to right leg

    MOVE G6A,  88,  60, 176,  75, 110,
    MOVE G6D, 108,  60, 176,  75,  94,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    ' tall stand
    MOVE G6A, 100,  60, 176,  75, 102,
    MOVE G6D, 100,  60, 176,  75, 102,
    MOVE G6B, 100,  30,  80,  ,  ,
    MOVE G6C, 100,  30,  80,  ,  ,
    WAIT

    SPEED 4

    ' stand
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100

    WAIT

    RETURN
zhanli:

    SPEED 15
    MOVE G6A,100,  60, 110,  15, 100, 100
    'MOVE G6D,100,  70, 120, 30, 100, 100
    MOVE G6B,165,  40,  70
    MOVE G6C,170,  40,  70
    WAIT

    SPEED 15
    MOVE G6A,100,  60, 110,  15, 100, 100
    MOVE G6D,100,  60, 110,  15, 100, 100
    MOVE G6B,185,  40,  70
    MOVE G6C,190,  40,  70
    WAIT
    DELAY 50

    SPEED 15
    MOVE G6A,100, 110, 70,  65, 100, 100
    MOVE G6D,100, 110, 70,  65, 100, 100
    MOVE G6B,185, 160, 115
    MOVE G6C,190, 160, 115
    WAIT

    SPEED 10
    MOVE G6A,100, 170,  70,  15, 100, 100
    MOVE G6D,100, 170,  70,  15, 100, 100
    MOVE G6B,185, 155, 120
    MOVE G6C,190, 155, 120
    WAIT

    SPEED 10
    MOVE G6A,100, 170,  30,  110, 100, 100
    MOVE G6D,100, 170,  30,  110, 100, 100
    MOVE G6B,185,  40,  60
    MOVE G6C,190,  40,  60
    WAIT

    SPEED 13
    GOSUB sit_pose
    GOSUB ddd
    GOSUB standard_pose2
    DELAY 100


    RETURN

ffront_lie:

    SPEED 15
    MOVE G6A,100, 155,  25, 140, 100,
    MOVE G6D,100, 155,  25, 140, 100,
    MOVE G6B,130,  50,  85
    MOVE G6C,130,  50,  85
    WAIT

    SPEED 10
    MOVE G6A, 100, 165,  50, 160, 100,
    MOVE G6D, 100, 165,  50, 160, 100,
    MOVE G6B,185,  10, 100
    MOVE G6C,185,  10, 100
    WAIT

    SPEED 10
    MOVE G6A,100, 130, 120,  80, 100,
    MOVE G6D,100, 130, 120,  80, 100,
    MOVE G6B,125, 160,  10
    MOVE G6C,125, 160,  10
    WAIT	

    SPEED 12
    GOSUB standard_pose1

    RETURN

chatui:
    GOSUB Leg_motor_mode3

    SPEED 13
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6C, 190,  30,  50,  ,  ,
    MOVE G6B, 190,  50, 120,  ,  ,
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    MOVE G6B, 190,  95, 100,  ,  ,
    MOVE G6C, 185,  60,  15,  ,  ,
    WAIT

    SPEED 13
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B, 190,  95, 100,  ,  ,
    MOVE G6C, 190,  30,  10,  ,  ,
    WAIT

'******************************



    SPEED 13
    MOVE G6B, 190,  30,  50,  ,  ,
    MOVE G6C, 190,  50, 120,  ,  ,
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100

    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    MOVE G6B, 185,  60,  15,  ,  ,
    MOVE G6C, 190,  95, 100,  ,  ,
    WAIT

    SPEED 13
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B, 190,  30,  10,  ,  ,
    MOVE G6C, 190,  95, 100,  ,  ,
    WAIT
   ' ***************
    SPEED 13
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6C, 190,  30,  50,  ,  ,
    MOVE G6B, 190,  50, 120,  ,  ,
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    MOVE G6B, 190,  95, 100,  ,  ,
    MOVE G6C, 185,  60,  15,  ,  ,
    MOVE G6C, 190,  20,  10,  ,  ,
    WAIT

    SPEED 13
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B, 190,  95, 100,  ,  ,
    MOVE G6C, 190,  30,  10,  ,  ,
    WAIT

'***********************************



    SPEED 13
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B, 190,  30,  50,  ,  ,
    MOVE G6C, 190,  50, 120,  ,  ,
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    MOVE G6B, 185,  60,  15,  ,  ,
    MOVE G6B, 190,  20,  10,  ,  ,
    MOVE G6C, 190,  95, 100,  ,  ,
    WAIT

    SPEED 13
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B, 190,  30,  10,  ,  ,
    MOVE G6C, 190,  95, 100,  ,  ,
    WAIT
    GOSUB standard_pose1

    RETURN


chatui1:
GOSUB Leg_motor_mode3
    SPEED 13
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6C, 190,  30,  50,  ,  ,
    MOVE G6B, 190,  50, 120,  ,  ,
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    MOVE G6B, 190,  95, 100,  ,  ,
    MOVE G6C, 185,  60,  15,  ,  ,
    WAIT

    SPEED 13
    MOVE G6A,  97,  76, 146,  93, 102,  
MOVE G6D,  98,  76, 146,  93, 102,  
    MOVE G6B, 190,  95, 100,  ,  ,
    MOVE G6C, 190,  30,  10,  ,  ,
    WAIT
      SPEED 13
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B, 190,  30,  50,  ,  ,
    MOVE G6C, 190,  50, 120,  ,  ,
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    MOVE G6B, 185,  60,  15,  ,  ,
    MOVE G6C, 190,  95, 100,  ,  ,
    WAIT

    SPEED 13
    MOVE G6A,  97,  76, 146,  93, 102,  
MOVE G6D,  98,  76, 146,  93, 102,  
    MOVE G6B, 190,  30,  10,  ,  ,
    MOVE G6C, 190,  95, 100,  ,  ,
    WAIT
   SPEED 13
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6C, 190,  30,  50,  ,  ,
    MOVE G6B, 190,  50, 120,  ,  ,
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    MOVE G6B, 190,  95, 100,  ,  ,
    MOVE G6C, 185,  60,  15,  ,  ,
    MOVE G6C, 190,  20,  10,  ,  ,
    WAIT

    SPEED 13
    MOVE G6A,  97,  76, 146,  93, 102,  
MOVE G6D,  98,  76, 146,  93, 102,  
    MOVE G6B, 190,  95, 100,  ,  ,
    MOVE G6C, 190,  30,  10,  ,  ,
    WAIT
    SPEED 13
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B, 190,  30,  50,  ,  ,
    MOVE G6C, 190,  50, 120,  ,  ,
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    MOVE G6B, 185,  60,  15,  ,  ,
    MOVE G6B, 190,  20,  10,  ,  ,
    MOVE G6C, 190,  95, 100,  ,  ,
    WAIT

    SPEED 13
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B, 190,  30,  10,  ,  ,
    MOVE G6C, 190,  95, 100,  ,  ,
    WAIT

standard_pose1:

    MOVE G6A,  95,  76, 145,  93, 105,
    MOVE G6D,  95,  76, 145,  93, 105,
    MOVE G6B,100,  30,  100, 60, 100, 100
    MOVE G6C,100,  30,  100, 60, 100, 100
    WAIT

    pose = 0

    RETURN

standard_pose2:

    MOVE G6A,  95,  76, 145,  93, 105,
    MOVE G6D,  95,  76, 145,  93, 105,
    MOVE G6C, 190,  30,  50,  ,  ,
    MOVE G6B, 190,  50, 120,  ,  ,
    WAIT

    pose = 0

    RETURN

sit_pose1:

    MOVE G6A,100, 143,  28, 142, 100, 100
    MOVE G6D,100, 143,  28, 142, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    pose = 1

    RETURN

ddd:
    SPEED 10
    MOVE G6A,  98, 135,  54, 126, 102,
    MOVE G6D,  98, 135,  54, 126, 100,
    MOVE G6B, 160,  25,  84,  ,  ,
    MOVE G6C, 165,  24,  93,  ,  ,
    WAIT

    DELAY 200

    SPEED 10
    MOVE G6A,96, 99,  106, 110, 104, 100
    MOVE G6D,96, 99,  106, 110, 104, 100
    MOVE G6B, 186,  25,  84,  ,  ,
    MOVE G6C, 190,  25,  93,  ,  ,
    WAIT

    DELAY 200

    RETURN

niupigu:

    GOSUB Leg_motor_mode3

    SPEED 7
    FOR J = 1 TO 2
        MOVE G6A,  99,  96, 111, 107,  82,
        MOVE G6D,  72,  89, 120, 103, 142,
        MOVE G6B, 187,  18,  29,  ,  ,
        MOVE G6C, 190,  25,  10,  ,  ,
        WAIT

        MOVE G6D,  99,  96, 111, 107,  82,
        MOVE G6A,  72,  89, 120, 103, 142,
        MOVE G6B, 187,  18,  29,  ,  ,
        MOVE G6C, 190,  25,  10,  ,  ,
        WAIT
    NEXT J
    MOVE G6A,  99,  96, 111, 107,  82,
    MOVE G6D,  72,  89, 120, 103, 142,
    MOVE G6B, 187,  18,  29,  ,  ,
    MOVE G6C, 190,  25,  10,  ,  ,
    WAIT

    RETURN

feitian2:
    GOSUB Leg_motor_mode3

    ' stand
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT

    DELAY 100

    SPEED 6
    ' tall stand
    MOVE G6D, 100,  60, 176,  75, 102,
    MOVE G6A, 100,  60, 176,  75, 102,
    WAIT

    SPEED 8

    ' move center of gravity to right leg
    MOVE G6D,  88,  60, 176,  75, 110,
    MOVE G6A, 108,  60, 176,  75,  94,
    WAIT

    ' uplift the left leg
    MOVE G6D,  92,  75,  96, 107, 112,
    MOVE G6A, 113,  60, 176,  75,  96,
    MOVE G6C, 100,  30,  80,  ,  ,
    MOVE G6B, 100,  30,  80,  ,  ,
    WAIT

    ' feitian pose

    MOVE G6A, 110,  60, 176,  98,  96,
    MOVE G6D,  78,  10, 140,  13, 122,
    MOVE G6B, 143, 190, 138,  ,  , 70
    MOVE G6C, 148, 188, 150,  ,  ,
    WAIT

    RETURN





    '***************WJM*********************************
MAIN: 'label


    'GOSUB LOW_Voltage
    '    GOSUB front_back_tilt_check
    '    GOSUB left_right_tilt_check


    GOSUB motor_ONOFF_LED

    ERX 4800,A,MAIN
    A_old = A

    ON A GOTO MAIN,KEY1,KEY2, KEY3

    GOTO MAIN	
    '*******************************************
    '		MAIN label
    '*******************************************
    '*******************************************
KEY3:
	GOSUB nobody_onestep_right
	GOSUB nobody_onestep_left
	GOSUB standard_pose
	GOSUB RX_EXIT
KEY1:
    Action_mode  = 0

    IF Action_mode  = 0 THEN 'dance_mode
        IF pose = 0 THEN
            'GOSUB last_test'cheer
            GOSUB sorry_sorry
        ENDIF
    ELSEIF Action_mode  = 1 THEN 'fight_mode
        IF pose = 0 THEN
            GOSUB bow1
        ENDIF
        IF pose = 0 THEN
            GOSUB scissors
        ENDIF

    ELSEIF  Action_mode  = 3 THEN ' soccer_mode

        IF pose = 0 THEN
            GOSUB leeper_left
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' hurdle_mode
        IF thing_catch_state = 0 AND pose = 0 THEN
            GOSUB stairs_left_up_3cm
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' camera_mode
        IF pose = 0 THEN
            GOSUB soar_pose
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MF_public
        IF pose = 0 THEN

            GOSUB SOUND_public1
            GOSUB RND_MOTION
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************
KEY2:
    IF Action_mode  = 0 THEN 'dance_mode
        IF pose = 0 THEN
            
             GOSUB dangerous_all
'      GOSUB dangerous_all2
            DELAY 1100
            GOSUB nobody
            GOSUB daybyday
        ENDIF	
    ELSEIF Action_mode  = 1 THEN 'fight_mode
        IF pose = 0 THEN
            GOSUB bow2
        ENDIF
    ELSEIF Action_mode  = 2 THEN 'game_mode
        IF pose = 0 THEN	
            GOSUB rock
        ENDIF
    ELSEIF  Action_mode  = 3 THEN ' soccer_mode
        IF pose = 0 THEN	
            GOSUB leeper_front
        ENDIF
    ELSEIF  Action_mode  = 4 THEN ' hurdle_mode
        IF pose = 0 THEN
            IF thing_catch_state = 0 THEN
                GOTO front_short_steps
            ELSE
                GOTO chack_run
            ENDIF
        ENDIF
    ELSEIF  Action_mode  = 5 THEN ' camera_mode
        IF pose = 0 THEN
            GOSUB fighter_pose
        ENDIF
    ELSEIF  Action_mode  = 6 THEN ' MF_public
        IF thing_catch_state = 0 AND pose = 0 THEN

            GOSUB SOUND_public2
            GOSUB RND_MOTION
        ENDIF

    ENDIF

    GOTO RX_EXIT
    '*******************************************

sorry_sorry:
    GOSUB action1
    GOSUB action2	
    GOSUB action3	'first climax
    GOSUB action4
    GOSUB action5
    GOSUB action3	'second climax
    
    HIGHSPEED SETON
    SPEED 8
    MOVE G6A,  99,  89, 116, 109, 102,
    MOVE G6D,  98,  89, 116, 110, 102,
    MOVE G6B, 187,  13,  21,  ,  ,
    MOVE G6C, 151,  28,  19,  ,  ,
    WAIT
    HIGHSPEED SETOFF
    
    DELAY 180
    
    GOSUB action6
    GOSUB action7
    GOSUB action8
    GOSUB action3	'third climax	
    GOSUB action6
    GOSUB action9
	GOSUB action10


    RETURN

    '********************************************************************
    '***************************** Action 1 *****************************
action1:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    SPEED 12
    'initial motion
    MOVE G6A, 100,  89, 113, 112,  99,
    MOVE G6D, 100,  89, 113, 112,  99,
    MOVE G6B, 101,  37, 165,  ,  ,
    MOVE G6C, 101,  37, 165,  ,  ,
    WAIT
    DELAY 1000
    MOVE G6A, 100,  76, 145,  93, 100,
    MOVE G6D, 100,  76, 145,  93, 100,
    MOVE G6B, 101,  19, 138,  ,  ,
    MOVE G6C, 101,  19, 138,  ,  ,
    WAIT
    MOVE G6A, 100,  89, 113, 112,  99,
    MOVE G6D, 100,  89, 113, 112,  99,
    MOVE G6B, 102,  25,  99,  ,  ,
    MOVE G6C, 102,  25,  99,  ,  ,
    WAIT
    '左右挥手各种挥
    FOR I = 1 TO 4
        MOVE G6A, 100,  94,  98, 126, 102,
        MOVE G6D,  94,  92, 103, 124, 103,
        MOVE G6B, 178,  18,  69,  ,  ,
        MOVE G6C, 178,  18,  69,  ,  ,
        WAIT
        'PROCESS
        ''''''''''''''''''

        'PROCESS
        MOVE G6A, 104,  99, 104, 117,  95,
        MOVE G6D,  90,  98, 107, 117, 109,
        MOVE G6B, 190,  98,  52,  ,  , 140
        MOVE G6C,  90,  56, 101,  ,  ,
        WAIT



        'PROCESS

        'PROCESS
        MOVE G6A, 100,  94,  98, 126, 102,
        MOVE G6D,  94,  92, 103, 124, 103,
        MOVE G6B, 178,  18,  69,  ,  ,
        MOVE G6C, 178,  18,  69,  ,  ,
        WAIT
        'PROCESS
        '''''''''''''''''''''

        'PROCESS
        MOVE G6A,  93,  86, 114, 119, 103,
        MOVE G6D, 103,  90, 106, 124, 101,
        MOVE G6B,  90,  56, 101,  ,  , 60
        MOVE G6C, 190,  98,  52,  ,  ,
        WAIT
    NEXT I

    RETURN

    '********************************************************************
    '***************************** Action 2 *****************************
action2:
	GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    
    SPEED 12
    HIGHSPEED SETON
    '左右摇摆~~~
    FOR I = 1 TO 4
		
		'left
		MOVE G6A,  92,  90, 107, 117, 107,  
		MOVE G6D, 105,  94, 100, 121,  96,  
		MOVE G6B,  99,  37, 153,  ,  ,  
		MOVE G6C,  99,  37, 153,  ,  ,  
		WAIT

        HIGHSPEED SETOFF
        
        'MIDDLE
        MOVE G6A,  98,  98,  75, 144, 102,
        MOVE G6D,  98,  97,  76, 146, 101,
        MOVE G6B, 100,  77, 126,  ,  ,
        MOVE G6C, 100,  77, 126,  ,  ,
        WAIT
        
        'right
        MOVE G6A, 105,  87, 100, 128,  98,  
		MOVE G6D,  92,  82, 105, 130, 105,  
		MOVE G6B,  99,  37, 153,  ,  ,  
		MOVE G6C,  99,  37, 153,  ,  ,  
		WAIT
		
        'MIDDLE
        MOVE G6A,  98,  98,  75, 144, 102,
        MOVE G6D,  98,  97,  76, 146, 101,
        MOVE G6B, 100,  77, 126,  ,  ,
        MOVE G6C, 100,  77, 126,  ,  ,
        WAIT
        
    NEXT I

    '大鹏展翅~~~

    SPEED 12

    FOR I = 1 TO 2
	    MOVE G6A,  96,  98,  77, 142, 102,  
		MOVE G6D,  98, 100,  75, 145, 102,  
		MOVE G6B, 100, 175,  10,  ,  ,  
		MOVE G6C, 100, 175,  10,  ,  ,  
		WAIT

        DELAY 100
        
        HIGHSPEED SETON
        
        MOVE G6A,  98,  97,  89, 128, 102,  
		MOVE G6D,  98,  99,  87, 130, 102,  
		MOVE G6B, 100,  90, 100,  ,  ,  
		MOVE G6C, 100,  90, 100,  ,  ,  
		WAIT

        HIGHSPEED SETOFF
    NEXT I
    HIGHSPEED SETON
    SPEED 7
    '  颤抖吧少年
    FOR I = 1 TO 4
	    MOVE G6A,  98,  88, 102, 129, 102,  
		MOVE G6D,  97,  88, 102, 131, 102,  
		MOVE G6B, 100, 100,  70,  ,  ,  
		MOVE G6C, 100, 100,  70,  ,  ,  
		WAIT

        DELAY 80
        MOVE G6A,  97,  99,  81, 136, 102,  
		MOVE G6D,  98, 101,  78, 140, 102,  
		MOVE G6B, 100,  79, 109,  ,  ,  
		MOVE G6C, 100,  79, 109,  ,  ,  
		WAIT

    NEXT I
    HIGHSPEED SETOFF

    RETURN

    '********************************************************************
    '***************************** Action 3 *****************************

action3:

    GOSUB action3_1
    GOSUB action3_2

    GOSUB action3_1
    GOSUB action3_2

    RETURN

action3_1:
	GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3

    '作揖（完全不像的说
    SPEED 13
    HIGHSPEED SETON
    FOR I = 1 TO 1
        'middle
        MOVE G6A,  98, 112,  66, 134, 103,  
		MOVE G6D,  97, 116,  62, 136, 103,  
		MOVE G6B, 150,  36,  19,  ,  , 100 
		MOVE G6C, 150,  36,  19,  ,  ,  
        WAIT
        DELAY 4
        HIGHSPEED SETOFF
        'right
        MOVE G6A,  90, 102,  80, 134, 109,  
		MOVE G6D, 101, 105,  78, 135,  96,  
		MOVE G6B, 190,  36,  19,  ,  ,130  
		MOVE G6C, 190,  51,  14,  ,  ,  
        WAIT
        DELAY 4

        MOVE G6A,  81,  93,  97, 129, 116,  
		MOVE G6D, 107,  93,  95, 133,  89,  
		MOVE G6B, 151,  19,  19,  ,  ,120
		MOVE G6C, 155,  51,  12,  ,  ,  
        WAIT
        DELAY 4

        MOVE G6A,92,105,77,134,109,
        MOVE G6D,101,106,78,135,96,
        MOVE G6B, 190,  18,  30,  ,  ,110
        MOVE G6C, 190,  51,  ,  ,  ,
        WAIT
        DELAY 4
        'middle
        MOVE G6A,  98, 112,  66, 134, 103,  
		MOVE G6D,  97, 116,  62, 136, 103,  
		MOVE G6B, 150,  36,  19,  ,  ,100 
		MOVE G6C, 150,  36,  19,  ,  ,  
        WAIT
        DELAY 4
        'left
        MOVE G6A, 102, 108,  80, 129,  95,  
		MOVE G6D,  94, 109,  77, 134, 109,  
		MOVE G6B, 190,  51,  19,  ,  ,90
		MOVE G6C, 190,  18,  30,  ,  ,  
        WAIT
        DELAY 4
        
        MOVE G6A, 105,  93,  95, 133,  89,  
		MOVE G6D,  89,  91,  91, 141, 117,  
		MOVE G6B, 155,  51,  12,  ,  ,80 
		MOVE G6C, 151,  19,  30,  ,  ,  
        WAIT
        DELAY 4
        
        MOVE G6A, 101, 105,  78, 135,  96,  
		MOVE G6D,  93, 105,  76, 141, 108,  
		MOVE G6B, 190,  51,  14,  ,  ,90  
		MOVE G6C, 190,  19,  30,  ,  ,  
        WAIT
        DELAY 4
        'middle
        MOVE G6A,  98, 112,  66, 134, 103,  
		MOVE G6D,  97, 116,  62, 136, 103,  
		MOVE G6B, 150,  36,  19,  ,  , 100 
		MOVE G6C, 150,  36,  19,  ,  ,  
        WAIT
        DELAY 4
    NEXT I

    SPEED 12

    '左右抬手那啥
    FOR I = 1 TO 2

        '        MOVE G6A,  89,  94,  93, 132, 116,
        '        MOVE G6D, 105,  93,  95, 133,  89,
        '        MOVE G6B, 169,  33,  14,  ,  ,
        '        MOVE G6C, 190,  55,  54,  ,  ,
        '        WAIT
        '
        '        MOVE G6A, 102, 118,  61, 135,  99,
        '		MOVE G6D,  96, 121,  59, 135, 105,
        '		MOVE G6B, 181,  36,  19,  ,  ,
        '		MOVE G6C, 181,  36,  19,  ,  ,
        '		WAIT
        '
        '		MOVE G6A, 105,  97,  85, 135,  86,
        '		MOVE G6D,  92, 101,  74, 144, 119,
        '		MOVE G6B, 190,  55,  54,  ,  ,
        '		MOVE G6C, 169,  33,  14,  ,  ,
        '        WAIT
        '
        '        MOVE G6A, 102, 118,  61, 135,  99,
        '		MOVE G6D,  96, 121,  59, 135, 105,
        '		MOVE G6B, 181,  36,  19,  ,  ,
        '		MOVE G6C, 181,  36,  19,  ,  ,
        '		WAIT

        MOVE G6A,  84, 112,  77, 124, 111,
        MOVE G6D, 106, 116,  73, 128,  93,
        MOVE G6B, 169,  33,  14,  ,  , 135
        MOVE G6C, 190,  55,  54,  ,  ,
        WAIT

        MOVE G6D,  99, 119,  49, 147,  99,
        MOVE G6A,  95, 119,  50, 147, 105,
        MOVE G6B, 181,  36,  19,  ,  , 100
        MOVE G6C, 181,  36,  19,  ,  ,
        WAIT

        MOVE G6D,  83, 112,  76, 130, 111,
        MOVE G6A, 106, 116,  73, 128,  93,
        MOVE G6C, 169,  33,  14,  ,  , 65
        MOVE G6B, 190,  55,  54,  ,  ,
        WAIT


'		MOVE G6A,  99, 126,  50, 141,  99,  
'		MOVE G6D,  92, 120,  56, 141, 104,  
        MOVE G6A, 100, 127,  55, 129, 100,  
		MOVE G6D,  92, 125,  59, 128, 106,  
		MOVE G6B, 181,  36,  19,  ,  , 100 
		MOVE G6C, 181,  36,  19,  ,  ,  
		WAIT


   '     MOVE G6A,  99, 126,  50, 141,  99,
'        MOVE G6D,  95, 126,  49, 144, 105,
'        MOVE G6B, 181,  36,  19,  ,  , 100
'        MOVE G6C, 181,  36,  19,  ,  ,
'        WAIT

    NEXT I

    RETURN

action3_2: '抬脚
	GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3

    HIGHSPEED SETON

    SPEED 6

    'MOVE G6A,  98, 106,  77, 136, 102,
    '	MOVE G6D,  98, 106,  77, 136, 102,
    '	MOVE G6B, 170,  50,  80,  ,  ,
    '	MOVE G6C, 170,  50,  80,  ,  ,
    'for unnumbered yellow one
    
    MOVE G6A,  99, 116,  63, 143, 102,  
	MOVE G6D,  98, 117,  60, 145, 103,  
	MOVE G6B, 170,  50,  80,  ,  ,  
	MOVE G6C, 170,  50,  80,  ,  ,  
    WAIT

    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	FOR I = 1 TO 2
	    'middle 
		SPEED 10
		MOVE G6A,  98, 116,  66, 139, 101,  
		MOVE G6D,  99, 119,  61, 143, 102,  
		MOVE G6B, 170,  50,  80,  ,  ,  
		MOVE G6C, 170,  50,  80,  ,  ,  
	    WAIT 
	    

	    ' right  
		
		MOVE G6A,  87,  91, 111, 118, 107, 
		MOVE G6D, 112,  98, 100, 125, 105,   
		MOVE G6B, 143, 121, 103,  ,  ,  
		MOVE G6C, 138, 107, 122,  ,  ,  
	    WAIT
	    
	    SPEED 10 
		
		MOVE G6A,  91,  95,  96, 125, 107,  
		MOVE G6D, 112,  98, 100, 125, 105,  
		MOVE G6B, 143, 121, 103,  ,  ,  
		MOVE G6C, 142,  60,  85,  ,  ,  
		
	    WAIT 
		
		MOVE G6A,  87, 126,  38, 154, 111,  
		MOVE G6D, 112,  98, 100, 125, 105,  
		MOVE G6B, 143, 121, 103,  ,  ,  
		MOVE G6C, 142,  15,  51,  ,  ,  
	    WAIT
	
		MOVE G6A,  91,  95,  96, 125, 107,  
		MOVE G6D, 112,  98, 100, 125, 105,  
		MOVE G6B, 143, 121, 103,  ,  ,  
		MOVE G6C, 142,  60,  85,  ,  , 
	    WAIT
	     
	    'middle
	    MOVE G6A,  98, 116,  66, 139, 101,  
		MOVE G6D,  99, 119,  61, 143, 102,  
		MOVE G6B, 170,  50,  80,  ,  ,  
		MOVE G6C, 170,  50,  80,  ,  , 
	    WAIT 
	    
	    SPEED 10
		
	    ' left 
		MOVE G6A, 112,  98, 100, 122, 105, 
		MOVE G6D,  82,  90, 108, 121, 107,  
		MOVE G6B, 138, 107, 122,  ,  ,   
		MOVE G6C, 143, 121, 103,  ,  ,  
	    WAIT
	    
	    SPEED 10 
		
		MOVE G6A, 112,  98, 100, 122, 105, 
		MOVE G6D,  85,  91, 101, 124, 107,  
		MOVE G6B, 142,  60,  85,  ,  ,  
		MOVE G6C, 143, 121, 103,  ,  , 
	    WAIT 
		 
		MOVE G6A, 112,  98, 100, 122, 105, 
		MOVE G6D,  79, 126,  42, 151, 111,  
		MOVE G6B, 142,  15,  51,  ,  ,  
		MOVE G6C, 143, 121, 103,  ,  ,  
	    WAIT
	
	    MOVE G6A, 112,  98, 100, 122, 105, 
		MOVE G6D,  85,  91, 101, 124, 107,  
		MOVE G6B, 142,  60,  85,  ,  ,  
		MOVE G6C, 143, 121, 103,  ,  , 
	    WAIT
	    
	NEXT I
    
    
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


    HIGHSPEED SETOFF

    RETURN

    '********************************************************************
    '***************************** Action 4 *****************************

action4:
    GOSUB action4_1_motion1
    GOSUB action4_1_motion2
    GOSUB action4_1_motion3
    GOSUB action4_2_motion1	
    GOSUB action4_2_motion2
    GOSUB action4_2_motion3


    RETURN

action4_1_motion1:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode2	

    HIGHSPEED SETON

    SPEED 8
    MOVE G6A,  96, 112,  60, 147, 109,
    MOVE G6D,  95, 112,  63, 144, 102,
    MOVE G6B, 170, 111,  81,  ,  ,
    MOVE G6C,  65,  93, 104,  ,  ,
    WAIT

    MOVE G6A,  96, 112,  83, 121, 106,
    MOVE G6D,  96, 114,  80, 121, 104,
    MOVE G6B, 169, 124, 188,  ,  ,
    MOVE G6C,  84,  53,  47,  ,  ,
    WAIT

    HIGHSPEED SETOFF

    SPEED 10

    FOR i=1 TO 2
        MOVE G6A,  88,  85, 122, 113, 112,
        MOVE G6D, 106,  93, 111, 115,  95,
        MOVE G6B, 147, 136, 159,  ,  ,
        MOVE G6C,  65,  42,  40,  ,  ,

        WAIT

        MOVE G6A,  96, 112,  83, 121, 106,
        MOVE G6D,  96, 114,  80, 121, 104,
        MOVE G6B, 169, 124, 188,  ,  ,
        MOVE G6C,  84,  53,  47,  ,  ,


        WAIT

        MOVE G6A, 103,  93, 113, 111,  96,
        MOVE G6D,  88,  92, 118, 107, 113,
        MOVE G6B, 147, 136, 159,  ,  ,
        MOVE G6C,  65,  42,  40,  ,  ,
,
        WAIT

        MOVE G6A,  96, 112,  83, 121, 106,
        MOVE G6D,  96, 114,  80, 121, 104,
        MOVE G6B, 169, 124, 188,  ,  ,
        MOVE G6C,  84,  53,  47,  ,  ,

        WAIT


    NEXT i


    RETURN

action4_1_motion2:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode2

    HIGHSPEED SETON

    SPEED 10

    FOR i=1 TO 2
        MOVE G6A,  88,  85, 122, 113, 112,
        MOVE G6D, 106,  93, 111, 115,  95,
        MOVE G6B,  52, 132, 190,  ,  ,
        MOVE G6C, 102,  37, 111,  ,  ,
        WAIT

        HIGHSPEED SETOFF

        SPEED 11

        MOVE G6A,  96, 112,  83, 121, 106,
        MOVE G6D,  96, 114,  80, 121, 104,
        MOVE G6B,  14, 145, 188,  ,  ,
        MOVE G6C,  ,  ,  ,  ,  ,



        WAIT

        MOVE G6A, 103,  93, 113, 111,  96,
        MOVE G6D,  88,  92, 118, 107, 113,
        MOVE G6B,  14, 190, 171,  ,  ,
        MOVE G6C, 101,  35, 111,  ,  ,



        WAIT

        MOVE G6A,  96, 112,  83, 121, 106,
        MOVE G6D,  96, 114,  80, 121, 104,
        MOVE G6B,  57, 182, 173,  ,  ,
        MOVE G6C, 101,  36, 111,  ,  ,

        WAIT


    NEXT i

    HIGHSPEED SETOFF

    RETURN

action4_1_motion3:


    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode2

    HIGHSPEED SETON

    SPEED 10

    FOR i=1 TO 2
        MOVE G6A,  88,  85, 122, 113, 112,
        MOVE G6D, 106,  93, 111, 115,  95,
        MOVE G6C,  52, 132, 190,  ,  ,
        MOVE G6B, 102,  37, 111,  ,  ,

        WAIT

        HIGHSPEED SETOFF

        SPEED 11

        MOVE G6A,  96, 112,  83, 121, 106,
        MOVE G6D,  96, 114,  80, 121, 104,
        MOVE G6C,  14, 145, 188,  ,  ,
        MOVE G6B,  ,  ,  ,  ,  ,



        WAIT

        MOVE G6A, 103,  93, 113, 111,  96,
        MOVE G6D,  88,  92, 118, 107, 113,
        MOVE G6C,  14, 190, 171,  ,  ,
        MOVE G6B, 101,  35, 111,  ,  ,



        WAIT

        MOVE G6A,  96, 112,  83, 121, 106,
        MOVE G6D,  96, 114,  80, 121, 104,
        MOVE G6C,  57, 182, 173,  ,  ,
        MOVE G6B, 101,  36, 111,  ,  ,

        WAIT


    NEXT i

    HIGHSPEED SETOFF

    RETURN

action4_2_motion1:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    HIGHSPEED SETON

    SPEED 8

    MOVE G6A,  97,  82, 127, 109, 101,
    MOVE G6D,  99,  86, 123, 107, 103,
    MOVE G6B, 100,  34, 107,  ,  ,
    MOVE G6C, 100,  36, 107,  ,  ,
    WAIT

    HIGHSPEED SETOFF

    DELAY 200

    SPEED 7

    FOR i = 1 TO 3

        MOVE G6A, 103, 105,  80, 140,  93,
        MOVE G6D,  88, 104,  81, 140, 114,
        MOVE G6B,  84,  18, 111,  ,  ,
        MOVE G6C, 117,  25, 108,  ,  ,
        WAIT

        MOVE G6A,  90, 115, 101,  98, 114,
        MOVE G6D, 102, 115, 101,  97,  93,
        MOVE G6B, 117,  25, 108,  ,  ,
        MOVE G6C,  84,  18, 111,  ,  ,
        WAIT

        DELAY 50

    NEXT i

    RETURN

action4_2_motion2:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    HIGHSPEED SETON

    SPEED 7

    FOR i = 1 TO 2

        MOVE G6A, 103, 105,  80, 140,  93,
        MOVE G6D,  88, 104,  81, 140, 114,
        MOVE G6B, 117,  25, 108,  ,  ,
        MOVE G6C, 189,  20,  87,  ,  ,
        WAIT

        HIGHSPEED SETOFF


        MOVE G6A,  90, 115, 101,  98, 114,
        MOVE G6D, 102, 115, 101,  97,  93,
        MOVE G6B,  84,  18, 111,  ,  ,
        WAIT

        DELAY 50

    NEXT i

    RETURN


action4_2_motion3:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    HIGHSPEED SETON

    SPEED 7

    FOR i = 1 TO 2

        MOVE G6A, 103, 105,  80, 140,  93,
        MOVE G6D,  88, 104,  81, 140, 114,
        MOVE G6B, 174,  29,  26,  ,  ,
        MOVE G6C, 176,  29,  21,  ,  ,
        WAIT

        HIGHSPEED SETOFF


        MOVE G6A,  90, 115, 101,  98, 114,
        MOVE G6D, 102, 115, 101,  97,  93,
        WAIT

        DELAY 50

    NEXT i

    MOVE G6A,  97,  82, 127, 109, 101,
    MOVE G6D,  99,  86, 123, 107, 103,
    MOVE G6B, 100,  34, 107,  ,  ,
    MOVE G6C, 100,  36, 107,  ,  ,
    WAIT

    RETURN

    '******************************************************************
    '***************************** Action 5 ***************************

action5:
    GOSUB action5_1_left
    GOSUB action5_1_right
    GOSUB action5_2

    'GOSUB action5_1_left
'    GOSUB action5_1_right
'    GOSUB action5_2
	GOSUB apple
	GOSUB action5_2

    RETURN
    
apple:
    'init
    MOVE G6A, 100, 108,  69, 150, 103,  
    MOVE G6D,  100, 108,  69, 150, 103,  
    MOVE G6B,  100, 105, 190,  ,  , 100 
	MOVE G6C,  100, 105, 190 ,  ,  ,  
    WAIT
    'MOVE G6A,  84,  55,  98, 139, 124,  
'    MOVE G6D, 113,  84, 127, 111,  81,  
'    MOVE G6B, 187,  25,  14,  ,  ,  50
'    MOVE G6C,  47, 112, 111,  ,  ,  50
    
    ''''''''''''''''''''''
    HIGHSPEED SETON
    SPEED 6
    FOR I=1 TO 3
	    MOVE G6A,  80,  55,  98, 139, 124,  
	    MOVE G6D, 113,  84, 127, 111,  81,  
	    MOVE G6B,  10, 160, 190,  ,  , 100 
		MOVE G6C,  49, 160, 190,  ,  ,  
	    WAIT
	    
	    MOVE G6A,  83,  81, 124, 114, 124,  
	    MOVE G6D, 113,  84, 127, 111,  81,  
		MOVE G6B,  10, 105, 190,  ,  , 60 
		MOVE G6C,  50, 105, 190 ,  ,  ,  
	    WAIT
    NEXT I
    HIGHSPEED SETOFF
    'Recovery
    SPEED 12
    MOVE G6A, 100, 108,  69, 150, 103,  
    MOVE G6D,  100, 108,  69, 150, 103,  
    MOVE G6B,  100, 105, 190,  ,  , 100 
	MOVE G6C,  100, 105, 190 ,  ,  ,  
    WAIT
    
      ''''''''''''''''''''''
    HIGHSPEED SETON
    SPEED 6
    FOR I=1 TO 3
    
    	MOVE G6D,  84,  55,  98, 139, 124,  
	    MOVE G6A, 113,  84, 127, 111,  81,  
	    MOVE G6B,  10, 160, 190,  ,  , 100 
		MOVE G6C,  49, 160, 190,  ,  ,  
	    WAIT
	    
    	'MOVE G6D,  87,  81, 124, 114, 124,  
'	    MOVE G6A, 113,  84, 127, 111,  81,  
'	    MOVE G6B,  10, 105, 190,  ,  , 60 
'		MOVE G6C,  50, 105, 190 ,  ,  , 
		
		MOVE G6A, 113,  84, 127, 111,  90,  
		MOVE G6D,  87,  89, 116, 114, 120,  
		MOVE G6B,  10, 105, 188,  ,  ,  
		MOVE G6C,  50, 105, 188,  ,  ,  
	    WAIT
    NEXT I
    HIGHSPEED SETOFF
    
    'SPEED 14
'    MOVE G6A,  98, 116,  62, 136, 103,
'    MOVE G6D,  98, 116,  62, 136, 103,
'    MOVE G6B, 150,  36,  19,  ,  ,100
'    MOVE G6C, 150,  36,  19,  ,  ,
'    WAIT
    
	RETURN

action5_1_left:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    HIGHSPEED SETON

    SPEED 8

    MOVE G6A,  94,  77, 116, 132, 110,
    MOVE G6D, 102,  78, 116, 129,  95,
    MOVE G6B, 102, 106, 103,  ,  ,
    MOVE G6C, 103,  30,  95,  ,  ,
    WAIT

    HIGHSPEED SETOFF

    SPEED 11

    FOR i = 1 TO 4

        'MOVE G6A, 100,  79, 127, 115, 102,
        '        MOVE G6D,  98,  81, 127, 113, 101,
        '        MOVE G6B,  10, 184, 158,  ,  ,
        '        MOVE G6C, 103,  30,  95,  ,  ,
        MOVE G6A,  97,  84, 120, 115, 103,
        MOVE G6D, 100,  83, 121, 115, 100,
        MOVE G6B,  10, 184, 158,  ,  ,
        MOVE G6C, 103,  30,  95,  ,  ,
        WAIT

        'MOVE G6A,  96,  76, 119, 123, 106,
        '        MOVE G6D, 101,  77, 121, 123, 100,
        '        MOVE G6B,  35, 184, 158,  ,  ,
        '        MOVE G6C,  82,  29, 100,  ,  ,

        MOVE G6A,  96, 110,  83, 118, 107,
        MOVE G6D, 101, 109,  85, 120,  97,
        MOVE G6B,  35, 184, 158,  ,  ,
        MOVE G6C,  82,  29, 100,  ,  ,

        WAIT



        DELAY 50


    NEXT i

    RETURN



action5_1_right:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    HIGHSPEED SETON

    SPEED 8

    MOVE G6A, 102,  78, 116, 129,  95,
    MOVE G6D,  95,  79, 111, 133, 109,
    MOVE G6B, 103,  30,  95,  ,  ,
    MOVE G6C, 102, 106, 103,  ,  ,

    WAIT

    HIGHSPEED SETOFF

    SPEED 11

    FOR i = 1 TO 3	

        'MOVE G6A, 100,  79, 127, 115, 102,
        '        MOVE G6D,  98,  81, 127, 113, 101,
        '        MOVE G6B,  10, 184, 158,  ,  ,
        '        MOVE G6C, 103,  30,  95,  ,  ,
        MOVE G6A, 100,  83, 121, 115, 100,
        MOVE G6D,  97,  84, 120, 115, 103,
        MOVE G6B, 103,  30,  95,  ,  ,
        MOVE G6C,  10, 184, 158,  ,  ,
        WAIT

        'MOVE G6A,  96,  76, 119, 123, 106,
        '        MOVE G6D, 101,  77, 121, 123, 100,
        '        MOVE G6B,  35, 184, 158,  ,  ,
        '        MOVE G6C,  82,  29, 100,  ,  ,

        MOVE G6A, 101, 109,  85, 120,  97,
        MOVE G6D,  95, 111,  84, 123, 105,
        MOVE G6B,  82,  29, 100,  ,  ,
        MOVE G6C,  35, 184, 158,  ,  ,
        WAIT



        DELAY 50


    NEXT i

    RETURN

action5_2:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 12

    FOR j = 1 TO 2

        ' high front
        MOVE G6A,  97,  88, 130,  96, 104,
        MOVE G6D,  97,  88, 130,  96, 104,
        MOVE G6B,  98, 109, 102,  ,  ,
        MOVE G6C,  98, 109, 102,  ,  ,
        WAIT

        FOR i = 1 TO 2

            ' low
            MOVE G6A,  95, 103, 101, 109, 105,
            MOVE G6D, 101, 106,  98, 112, 100,
            MOVE G6B, 102,  20, 188,  ,  ,
            MOVE G6C, 102,  20, 188,  ,  ,
            WAIT

            DELAY 50

            ' high back
            'MOVE G6A,  96,  80, 127, 106, 101,
            '            MOVE G6D, 102,  87, 114, 109, 102,
            '            MOVE G6B, 103,  43, 165,  ,  ,
            '            MOVE G6C, 103,  43, 165,  ,  ,
            MOVE G6A,  97,  79, 125, 115, 101,
            MOVE G6D, 102,  82, 114, 123, 102,
            MOVE G6B, 103,  43, 165,  ,  ,
            MOVE G6C, 103,  43, 165,  ,  ,
            WAIT

            DELAY 50

        NEXT i	

        '		' arm front roll
        '		MOVE G6A,  97,  88, 130,  96, 104,
        '		MOVE G6D,  97,  88, 130,  96, 104,
        '		MOVE G6B, 189,  54,  78,  ,  ,
        '		MOVE G6C, 189,  54,  78,  ,  ,
        '		WAIT

    NEXT j


    RETURN

    '******************************************************************
    '***************************** Action 6 ***************************


action6:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    'MOVE G6A, 100,  76, 145,  93, 100,
    '    MOVE G6D, 100,  76, 145,  93, 100,
    '    MOVE G6B, 164,  65,  67,  ,  ,
    '    MOVE G6C, 157,  62,  63,  ,  ,
    '    WAIT
    HIGHSPEED SETON
    SPEED 8
    MOVE G6A,  99,  89, 116, 109, 102,
    MOVE G6D,  98,  89, 116, 110, 102,
    MOVE G6B, 187,  13,  21,  ,  ,
    MOVE G6C, 151,  28,  19,  ,  ,
    WAIT
    HIGHSPEED SETOFF
    SPEED 6
    FOR i = 1 TO 2
        'MOVE G6A,  97, 101, 115,  87, 103,
        '        MOVE G6D,  97, 101, 115,  87, 103,
        '        MOVE G6B, 187,  13,  21,  ,  ,
        '        MOVE G6C, 151,  28,  19,  ,  ,
        MOVE G6A, 100, 123,  80, 109, 100,
        MOVE G6D,  98, 122,  80, 111, 101,
        WAIT
        DELAY 250
        'MOVE G6A, 103, 103,  91, 116, 104,
        '        MOVE G6D,  91,  92, 106, 112, 101,
        MOVE G6A, 104, 106,  89, 122,  94,
        MOVE G6D,  92, 108,  87, 125, 109,
        WAIT
        DELAY 250
        MOVE G6A, 101,  88,  88, 149,  99,
        MOVE G6D,  95,  87,  91, 149, 103,

        WAIT
        DELAY 150
        MOVE G6A,  93, 106,  87, 121, 110,
        MOVE G6D, 102, 107,  89, 121,  94,
        WAIT



        ''NEXT ROUND
        MOVE G6A, 100, 123,  80, 109, 100,
        MOVE G6D,  98, 122,  80, 111, 101,

        WAIT
        DELAY 250
        'MOVE G6A, 103, 103,  91, 116, 104,
        '        MOVE G6D,  91,  92, 106, 112, 101,
        MOVE G6A, 104, 106,  89, 122,  94,
        MOVE G6D,  92, 108,  87, 125, 109,
        WAIT
        DELAY 200
        MOVE G6A, 101,  88,  88, 149,  99,
        MOVE G6D,  95,  87,  91, 149, 103,
        WAIT
        DELAY 50
        MOVE G6A,  93, 106,  87, 121, 110,
        MOVE G6D, 102, 107,  89, 121,  94,
        WAIT
        DELAY 150






        ''NEXT ROUND
        MOVE G6A, 100, 123,  80, 109, 100,
        MOVE G6D,  98, 122,  80, 111, 101,

        WAIT
        DELAY 250
        'MOVE G6A, 103, 103,  91, 116, 104,
        '        MOVE G6D,  91,  92, 106, 112, 101,
        MOVE G6A, 104, 106,  89, 122,  94,
        MOVE G6D,  92, 108,  87, 125, 109,
        WAIT
        DELAY 250
        MOVE G6A, 101,  88,  88, 149,  99,
        MOVE G6D,  95,  87,  91, 149, 103,

        WAIT
        DELAY 250
        MOVE G6A,  93, 106,  87, 121, 110,
        MOVE G6D, 102, 107,  89, 121,  94,
        WAIT
        DELAY 150





        ''NEXT ROUND
        MOVE G6A, 100, 123,  80, 109, 100,
        MOVE G6D,  98, 122,  80, 111, 101,
        WAIT
        DELAY 100
        'MOVE G6A, 103, 103,  91, 116, 104,
        '        MOVE G6D,  91,  92, 106, 112, 101,
        MOVE G6A, 104, 106,  89, 122,  94,
        MOVE G6D,  92, 108,  87, 125, 109,
        WAIT
        DELAY 200
        MOVE G6A, 101,  88,  88, 149,  99,
        MOVE G6D,  95,  87,  91, 149, 103,

        WAIT
        'CHANGE HAND
        DELAY 230
        SPEED 6
        MOVE G6A,  99,  89, 116, 109, 102,
        MOVE G6D,  98,  89, 116, 110, 102,
        MOVE G6B, 100,  77,  23,  ,  ,
        MOVE G6C, 114,  77,  23,  ,  ,
    NEXT i

    SPEED 8

    '************手臂下垂3次
    'FOR i = 1 TO 4
    '
    '        MOVE G6A,  97, 101, 115,  87, 103,
    '        MOVE G6D,  97, 101, 115,  87, 103,
    '        MOVE G6B, 100,  77,  23,  ,  ,
    '        MOVE G6C, 114,  77,  23,  ,  ,
    '        WAIT
    '
    '        SPEED 5
    '
    '        DELAY 100
    '
    '        MOVE G6A, 103, 103,  91, 116, 104,
    '        MOVE G6D,  91,  92, 106, 112, 101,
    '        WAIT
    '
    '        DELAY 100
    '
    '        MOVE G6A,  97,  83, 107, 122, 103,
    '        MOVE G6D,  97,  83, 107, 122, 103,
    '        WAIT
    '
    '        DELAY 100
    '
    '        MOVE G6D, 103, 103,  91, 116, 104,
    '        MOVE G6A,  91,  92, 106, 112, 101,
    '        WAIT
    '
    '        DELAY 100
    '
    '    NEXT i

    DELAY 100

    RETURN


    '******************************************************************
    '***************************** Action 7 ***************************

action7:

    GOSUB action7_1_motion1
    GOSUB action7_1_motion2

    GOSUB action7_2


    GOSUB action7_3_motion1
    GOSUB action7_3_motion2


    RETURN

action7_1_motion1:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 6

    MOVE G6A,  98, 120,  86, 108, 102,
    MOVE G6D,  98, 120,  86, 108, 102,
    MOVE G6B, 119,  38,  77,  ,  ,
    MOVE G6C, 119,  38,  77,  ,  ,
    WAIT	

    MOVE G6A,  98,  91, 116, 113, 104,
    MOVE G6D,  98,  91, 116, 113, 104,
    MOVE G6B, 108, 145, 128,  ,  ,
    MOVE G6C, 108, 145, 128,  ,  ,
    WAIT

    MOVE G6A,  98,  91, 116, 113, 104,
    MOVE G6D,  98,  91, 116, 113, 104,
    MOVE G6B, 110, 166, 139,  ,  ,
    MOVE G6C, 110, 166, 139,  ,  ,
    WAIT

    RETURN

action7_1_motion2:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 12

    FOR i = 1 TO 4

        MOVE G6A,  96,  85, 117, 114, 112,
        MOVE G6D, 102,  79, 128, 108,  91,
        MOVE G6B, 107, 185,  96,  ,  ,
        MOVE G6C, 107, 179, 134,  ,  ,
        WAIT

        MOVE G6D,  96,  85, 117, 114, 112,
        MOVE G6A, 102,  79, 128, 108,  91,
        MOVE G6C, 107, 185,  96,  ,  ,
        MOVE G6B, 107, 179, 134,  ,  ,
        WAIT


    NEXT i

    RETURN

action7_2:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3	

    SPEED 12

    MOVE G6A,  95, 100,  99, 114, 105,
    MOVE G6D,  95, 100,  99, 114, 105,
    MOVE G6B, 107, 107,  96,  ,  ,
    MOVE G6C, 107, 107,  96,  ,  ,
    WAIT

    HIGHSPEED SETON

    SPEED 7

    FOR i=1 TO 4
        MOVE G6A,  82,  71, 130, 119, 123,
        MOVE G6D, 109,  80, 122, 118,  90,
        MOVE G6B, 107,  32, 164,  ,  ,
        MOVE G6C, 108, 176,  35,  ,  ,
        WAIT

        MOVE G6A,  95, 100,  99, 114, 105,
        MOVE G6D,  95, 100,  99, 114, 105,
        MOVE G6B, 107, 107,  96,  ,  ,
        MOVE G6C, 107, 107,  96,  ,  ,
        WAIT

        MOVE G6D,  82,  71, 130, 119, 123,
        MOVE G6A, 109,  80, 122, 118,  90,
        MOVE G6C, 107,  32, 164,  ,  ,
        MOVE G6B, 108, 176,  35,  ,
        WAIT

        MOVE G6A,  95, 100,  99, 114, 105,
        MOVE G6D,  95, 100,  99, 114, 105,
        MOVE G6B, 107, 107,  96,  ,  ,
        MOVE G6C, 107, 107,  96,  ,  ,
        WAIT
    NEXT i

    HIGHSPEED SETOFF

    RETURN

action7_3_motion1:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode2

    HIGHSPEED SETON 	

    SPEED 4

    MOVE G6A,  82,  71, 130, 119, 123,
    MOVE G6D, 109,  80, 122, 118,  90,
    MOVE G6B,  88,  40, 114,  ,  ,
    MOVE G6C, 190,  16,  93,  ,  ,
    WAIT

    DELAY 700

    MOVE G6D,  82,  71, 130, 119, 123,
    MOVE G6A, 109,  80, 122, 118,  90,
    MOVE G6C,  88,  40, 114,  ,  ,
    MOVE G6B, 190,  16,  93,  ,  ,
    WAIT

    DELAY 700

    HIGHSPEED SETOFF

    RETURN

action7_3_motion2:

    GOSUB Leg_motor_mode2
    GOSUB Arm_motor_mode3

    SPEED 6

    MOVE G6A,  89,  98,  85, 112, 111,
    MOVE G6D,  89,  98,  85, 112, 111,
    MOVE G6B, 104, 108, 168,  ,  ,
    MOVE G6C, 104, 108, 168,  ,  ,
    WAIT

    SPEED 4

    '	MOVE G6A,  95,  98,  85, 112, 103,
    '	MOVE G6D,  95,  98,  85, 112, 103,
    '	MOVE G6B, 105, 167, 113,  ,  ,
    '	MOVE G6C, 105, 167, 113,  ,  ,
    '	WAIT

    MOVE G6A,  95, 102,  85, 112, 103,
    MOVE G6D,  95, 102,  85, 112, 103,
    MOVE G6B, 105, 167, 113,  ,  ,
    MOVE G6C, 105, 167, 113,  ,  ,
    WAIT


    MOVE G6A,  97,  98,  85, 124, 103,
    MOVE G6D,  97,  98,  85, 124, 103,
    MOVE G6B, 114, 102, 100,  ,  ,
    MOVE G6C, 114, 102, 100,  ,  ,
    WAIT

    SPEED 6

    MOVE G6A,  98, 102, 110,  99, 102,
    MOVE G6D,  98, 102, 110,  99, 102,
    MOVE G6B, 126,  34,  80,  ,  ,
    MOVE G6C, 126,  34,  80,  ,  ,
    WAIT

    RETURN

    '******************************************************************
    '***************************** Action 8 ***************************

action8:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    
    HIGHSPEED SETON
    
   	SPEED 10
   	
   	MOVE G6A,  96, 102,  97, 117, 105,  
	MOVE G6D,  98,  98,  99, 119, 103,  
	MOVE G6B, 106,  61, 169,  ,  ,  
	MOVE G6C,  10, 167, 188,  ,  ,  
	WAIT
    
    HIGHSPEED SETOFF

    SPEED 12
    
    'left
    FOR i = 1 TO 2
    
    MOVE G6A,  99,  94, 113, 104,  94,  
	MOVE G6D,  94, 100, 101, 110, 115,  
	MOVE G6B, 106, 108, 134,  ,  ,  
	MOVE G6C,  33, 167, 188,  ,  ,  
	WAIT

	
   	MOVE G6A,  96, 102,  97, 117, 105,  
	MOVE G6D,  98,  98,  99, 119, 103,  
	MOVE G6B, 106,  61, 169,  ,  ,  
	MOVE G6C,  10, 167, 188,  ,  ,  
	WAIT
	
	NEXT i
	
    MOVE G6A,  99,  94, 113, 104,  94,  
	MOVE G6D,  94, 100, 101, 110, 115,  
	MOVE G6B, 106, 108, 134,  ,  ,  
	MOVE G6C,  33, 167, 188,  ,  ,  
	WAIT
	
    HIGHSPEED SETON
    
   	SPEED 10

	MOVE G6A,  98, 104,  97, 115, 103,  
	MOVE G6D,  96, 102,  97, 117, 105,  
	MOVE G6B,  10, 167, 188,  ,  ,  
	MOVE G6C, 106,  61, 169,  ,  ,  
	WAIT
    
    HIGHSPEED SETOFF
    
    SPEED 12
	
	'right
	
	FOR i = 1 TO 2
    MOVE G6A,  94, 103, 101, 107, 115,  
	MOVE G6D,  99,  94, 113, 104,  94,  
	MOVE G6B,  33, 167, 188,  ,  ,  
	MOVE G6C, 106, 108, 134,  ,  ,  
	WAIT
	
	MOVE G6A,  98, 104,  97, 115, 103,  
	MOVE G6D,  96, 102,  97, 117, 105,  
	MOVE G6B,  10, 167, 188,  ,  ,  
	MOVE G6C, 106,  61, 169,  ,  ,  
	WAIT
	
	NEXT i
	
    MOVE G6A,  94, 103, 101, 107, 115,  
	MOVE G6D,  99,  94, 113, 104,  94,  
	MOVE G6B,  33, 167, 188,  ,  ,  
	MOVE G6C, 106, 108, 134,  ,  ,  
	WAIT
   
   SPEED 10
    FOR J = 1 TO 2
        FOR I = 1 TO 2
        	
        	MOVE G6A,  91, 111,  99, 103, 101,  
			MOVE G6D, 102, 118,  83, 110, 106,  
			MOVE G6B, 105,  75, 124,  ,  ,  
			MOVE G6C, 105,  75, 124,  ,  ,  
			WAIT

            SPEED 10
            MOVE G6A,  89, 106, 102, 104, 109,  
			MOVE G6D, 104, 109,  96, 107,  98,  
			MOVE G6B, 107,  51, 151,  ,  ,  
			MOVE G6C, 107,  53, 151,  ,  ,  
			WAIT


        NEXT I

        SPEED 8
        
        MOVE G6A,  99, 100, 100, 117, 104,  
		MOVE G6D,  95,  94, 106, 117, 104,  
		MOVE G6B, 106,  50, 150,  ,  ,  
		MOVE G6C, 106,  50, 150,  ,  ,  
		WAIT

        FOR I = 1 TO 2
			MOVE G6A, 102, 118,  83, 110, 106,  
			MOVE G6D,  90, 105, 100, 105, 103,  
			MOVE G6B, 105,  75, 124,  ,  ,  
			MOVE G6C, 105,  75, 124,  ,  ,  
			WAIT

            SPEED 10
            MOVE G6A, 105, 110,  97, 106,  98,  
			MOVE G6D,  88, 101, 109, 102, 110,  
			MOVE G6B, 107,  53, 151,  ,  ,  
			MOVE G6C, 107,  51, 151,  ,  ,  
			WAIT


        NEXT I

        SPEED 8

        MOVE G6A,  99, 100, 100, 117, 104,  
		MOVE G6D,  95,  94, 106, 117, 104,  
		MOVE G6B, 106,  50, 150,  ,  ,  
		MOVE G6C, 106,  50, 150,  ,  ,  
		WAIT

    NEXT J
    
    '上晃手
    FOR i = 1 TO 3
        MOVE G6A,  96,  75, 134, 115, 104,
        MOVE G6D, 100,  75, 133, 112, 101,
        MOVE G6B, 106,  52,  58,  ,  ,
        MOVE G6C, 106, 127, 163,  ,  ,
        WAIT

        MOVE G6A, 102,  92, 114, 110, 107,
        MOVE G6D,  96,  79, 133, 104,  97,
        MOVE G6B, 106,  52,  58,  ,  ,
        MOVE G6C, 103, 179, 148,  ,  ,
        WAIT
    NEXT i
    '过渡
    MOVE G6A,  96,  75, 134, 115, 104,
    MOVE G6D, 100,  75, 133, 112, 101,
    MOVE G6B, 106,  52,  58,  ,  ,
    MOVE G6C, 106, 127, 163,  ,  ,
    WAIT
    MOVE G6A, 100,  88, 110, 116, 104,
    MOVE G6D,  98,  94, 111, 111, 101,
    MOVE G6B, 106,  52,  58,  ,  ,
    MOVE G6C, 185,  58,  30,  ,  ,
    WAIT
    '右晃手
    SPEED 10
    FOR i = 1 TO 5
        MOVE G6A, 100,  98,  94, 127, 104,
        MOVE G6D,  98, 103,  93, 127, 102,
        MOVE G6B, 106,  52,  58,  ,  ,
        MOVE G6C, 189,  58,  25,  ,  ,
        WAIT

        SPEED 4
        MOVE G6A, 100,  88, 110, 116, 104,
        MOVE G6D,  98,  94, 111, 111, 101,
        MOVE G6B, 106,  52,  58,  ,  ,
        MOVE G6C, 185,  58,  30,  ,  ,
        WAIT
    NEXT i
    
    SPEED 12
    
    MOVE G6A,  98, 116,  62, 136, 103,
    MOVE G6D,  98, 116,  62, 136, 103,
    MOVE G6B, 150,  36,  19,  ,  ,100
    MOVE G6C, 150,  36,  19,  ,  ,
    WAIT
    
    RETURN


    '******************************************************************
    '***************************** Action 9 ***************************

action9:

    GOSUB Leg_motor_mode3
    GOSUB Arm_motor_mode3

    SPEED 10

    MOVE G6A,  97, 101, 115,  87, 103,
    MOVE G6D,  97, 101, 115,  87, 103,
    MOVE G6B, 100,  81,  50,  ,  ,
    MOVE G6C, 114,  81,  50,  ,  ,
    WAIT

    DELAY 200

    MOVE G6A,  97, 101, 115,  97, 103,
    MOVE G6D,  97, 101, 115,  97, 103,
    MOVE G6B, 100,  36, 142,  ,  ,
    MOVE G6C, 100,  36, 142,  ,  ,
    WAIT

    DELAY 200

    MOVE G6A,  97, 101, 115,  97, 103,
    MOVE G6D,  97, 101, 115,  97, 103,
    MOVE G6B, 100, 104,  98,  ,  ,
    MOVE G6C, 114, 104,  98,  ,  ,
    WAIT

    DELAY 200

    MOVE G6A,  97, 101, 115,  97, 103,
    MOVE G6D,  97, 101, 115,  97, 103,
    MOVE G6B,  12, 120, 174,  ,  ,
    MOVE G6C,  12, 120, 174,  ,  ,
    WAIT

    DELAY 200

    MOVE G6A,  97, 101, 115,  97, 103,
    MOVE G6D,  97, 101, 115,  97, 103,
    MOVE G6B, 102, 110, 182,  ,  ,
    MOVE G6C, 102, 110, 182,  ,  ,
    WAIT

    DELAY 200

    HIGHSPEED SETON

    SPEED 4

    FOR i = 1 TO 2

        MOVE G6A, 106, 101,  93, 115, 102,
        MOVE G6D,  87,  91, 109, 109, 103,
        MOVE G6B, 188,  30,  25,  ,  ,
        MOVE G6C, 188,  31,  26,  ,  ,
        WAIT

        HIGHSPEED SETOFF

        SPEED 4

        DELAY 200

        MOVE G6A,  96, 103,  97, 111, 104,
        MOVE G6D, 101, 106,  92, 115, 100,
        MOVE G6B, 188,  30,  25,  ,  ,
        MOVE G6C, 188,  32,  27,  ,  ,
        WAIT

        DELAY 200

    NEXT i


    RETURN
    
    
action10:

    GOSUB All_motor_mode3

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  35,  80
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    'bow
    SPEED 8
    MOVE G6A,100,  55, 145,  145, 100, 100
    MOVE G6D,100,  55, 145,  145, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    DELAY 1000

    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  40,  80
    WAIT

    SPEED 10
    GOSUB standard_pose
    GOSUB All_motor_Reset


    RETURN


test:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode3
    MOVE G6A,  95, 102,  98, 117, 100,
    MOVE G6D, 103, 108,  90, 121, 101,
    MOVE G6B, 143, 121, 103,  ,  ,
    MOVE G6C, 138, 107, 122,  ,  ,
    WAIT
    HIGHSPEED SETON
    SPEED 10
    MOVE G6A,  99,  89, 116, 109, 102,
    MOVE G6D,  98,  89, 116, 110, 102,
    MOVE G6B, 187,  13,  21,  ,  ,
    MOVE G6C, 151,  28,  19,  ,  ,

    WAIT
    HIGHSPEED SETOFF
    DELAY 300
    SPEED 14
    MOVE G6A,  91,  85, 123, 108,  97,
    MOVE G6D, 108,  98, 100, 120, 105,
    MOVE G6B, 143, 121, 103,  ,  ,
    MOVE G6C, 138, 107, 122,  ,  ,
    WAIT
    MOVE G6A, 100,  80, 136,  98, 100,
    MOVE G6D,  98,  84, 132,  96, 103,
    MOVE G6B, 187,  13,  21,  ,  ,
    MOVE G6C, 151,  28,  19,  ,  ,
    WAIT
    RETURN