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

var savedPosition: Vector3
var distanceToRender: float = 13.0
var clues_solved = {}
var active_control_node = null
signal playerPosChanged

func _onPlayerTeleport(newPos: Vector3):
	savedPosition = newPos
	emit_signal("playerPosChanged", newPos)

func _input(event):
	var i = 0
	
	if event.is_action_pressed("debug_up"):
		i = 2
	elif event.is_action_pressed("debug_down"):
		i = -2
	elif event.is_action_pressed("debug_act"):
		pass
	
	for fog in get_tree().get_nodes_in_group("fog"):
		fog.amount += i


func solve_mystery(correct: bool):
	if clues_solved.size() < 8:
		return
	
	print("did you win? " + str(correct))


func open_door(which: String):
	print("opening " + which + "!!")
	if clues_solved.keys().has(which) and clues_solved[which]:
		return
	
	clues_solved[which] = true
	for door in get_tree().get_nodes_in_group("doors"):
		if door.get_parent().name == which:
			door.get_node("RootNode/AnimationPlayer").play("open")
			if door.get_children().size() > 1:
				door.get_node("clue").queue_free()
			break;
	for lock in get_tree().get_nodes_in_group("locks"):
		if lock.get_parent().name == which:
			lock.unlock();
			return

func setup_doors():
	yield(get_tree().create_timer(3), "timeout")
	open_door("Dormitory")
	open_door("Dining room")
	open_door("Kitchen")
	open_door("Library")
	open_door("Lounge")


func ui_input_dir(dir: int):	# up, right, down, left = 0, 1, 2, 3 ; accept = -1
	print("input " + str(dir) + " on " + str(active_control_node))
	if active_control_node == null:
		return
	
	active_control_node.request_input_dir(dir)


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

