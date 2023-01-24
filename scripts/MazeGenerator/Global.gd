extends Node


enum INPUT_BUTTONS {
	MENU = 1,
	SIDE = 2,
	TOUCHPAD = 14,
	TRIGGER = 15,
}
enum INPUT_AXIS {
	TOUCHPAD_X = 0,
	TOUCHPAD_Y = 1
}

enum OPEN_PATHS {
	RIGHT 	= 1 << 0, #0001
	DOWN 	= 1 << 1, #0010
	LEFT	= 1 << 2, #0100
	UP		= 1 << 3  #1000
}


var clues_solved = 0


func solve_mystery(correct: bool):
	if clues_solved < 3:
		return
	
	print("did you win? " + str(correct))


func load_world_area(which):
	$"../World".load_area(which)

var AVAILABLE_NORMAL_ROOMS: Array = []
var AVAILABLE_ESSENTIAL_ROOMS: Array = []

func push_normal_room(pck_scn: PackedScene):
	AVAILABLE_NORMAL_ROOMS.append(pck_scn);
	pass
	
func push_normal_room_array(pck_scn_arr: Array):
	AVAILABLE_NORMAL_ROOMS.append_array(pck_scn_arr);
	pass
	
func push_essential_room(pck_scn: PackedScene):
	AVAILABLE_ESSENTIAL_ROOMS.append(pck_scn);
	
func push_essential_room_array(pck_scn_arr: Array):
	AVAILABLE_ESSENTIAL_ROOMS.append_array(pck_scn_arr);
	
	
func pop_essential_room_rnd() -> Spatial:
	return AVAILABLE_ESSENTIAL_ROOMS.pop_at(randi()%AVAILABLE_ESSENTIAL_ROOMS.size()).instance()
	
func pop_normal_room_rnd() -> Spatial:
	return AVAILABLE_NORMAL_ROOMS.pop_at(randi()%AVAILABLE_NORMAL_ROOMS.size()).instance()

