extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum OPEN_PATHS {
	RIGHT 	= 1 << 0, #0001
	DOWN 	= 1 << 1, #0010
	LEFT	= 1 << 2, #0100
	UP		= 1 << 3  #1000
}

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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
