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

var clues_solved = {}


func solve_mystery(correct: bool):
	if clues_solved.size() < 3:
		return
	
	print("did you win? " + str(correct))


func open_door(which: String):
	if clues_solved.keys().has(which) and clues_solved[which]:
		return
	
	clues_solved[which] = true
	for door in get_tree().get_nodes_in_group("doors"):
		if door.get_parent().name == which:
			door.get_node("AnimationPlayer").play("open door")
			return

func setup_doors():
	yield(get_tree().create_timer(5), "timeout")
	open_door("Dormitory")
	open_door("Dining room")
	open_door("Kitchen")
	open_door("Library")
	open_door("Lounge")


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

