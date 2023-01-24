extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var _mazeGeneratorPoint_tscn = preload('res://Escape_Room_Scenes/MazeGeneratorPoint.tscn')
var _mazeGeneratorPoint
var _cell_tscn = preload('res://Escape_Room_Scenes/Cell3D.tscn')


var cells: Dictionary = {}

export(Array) var essential_rooms: Array = []
export(Array) var normal_rooms: Array = []



export var cell_texture: Texture
onready var cell_size: Vector2 = Vector2(2.3,3.2)

var board_size: Vector2 = Vector2(5, 5)
var starting_cell: Vector2 = Vector2(2, 2)
var first_time_dead_cells: Array = []
var essential_cells: Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.setup_doors()
	setup_cells()
	setup_rooms()
	
	
	print(first_time_dead_cells)
	_mazeGeneratorPoint = _mazeGeneratorPoint_tscn.instance()
	_mazeGeneratorPoint.setup(self, cell_size, board_size, starting_cell, first_time_dead_cells)
	_mazeGeneratorPoint.connect("visit_cell", self, "_on_mazeGen_visit_cell")
	_mazeGeneratorPoint.connect("open_path_between_cells", self, "_on_mazeGen_open_path_between_cells")
	_mazeGeneratorPoint.connect("found_dead_cell",self,"_on_mazeGen_found_dead_cell")
	add_child(_mazeGeneratorPoint)
	_mazeGeneratorPoint.make_maze()
	pass # Replace with function body.

func setup_rooms():
	Global.push_essential_room_array(essential_rooms)
	Global.push_normal_room_array(normal_rooms)
	
	randomize_essential_cells()
	
func randomize_essential_cells() :
	var dead_cells_poppable: Array = first_time_dead_cells.duplicate()
	for iterations in range(essential_rooms.size()):
		essential_cells.append(dead_cells_poppable.pop_at(randi()%dead_cells_poppable.size()))


func calculate_cell_center(cell_pos: Vector2) -> Vector3:
	var center: Vector2 = cell_size * cell_pos + cell_size/2
	return Vector3(center.x, 0, center.y)

func _on_mazeGen_visit_cell(cell_pos: Vector2):
	cells[cell_pos].unlock()
	pass

func _on_mazeGen_found_dead_cell(cell_pos: Vector2):
	if(essential_cells.find(cell_pos) != -1):
		cells[cell_pos].essential_cell()
		return
	elif(first_time_dead_cells.find(cell_pos) != -1): 
		cells[cell_pos].room_cell()
		return
	cells[cell_pos].dead_cell()

func _on_mazeGen_open_path_between_cells(cell_a_pos: Vector2, cell_b_pos: Vector2):
	var unitary_distance_a_to_b = cell_a_pos-cell_b_pos
	print("Cell " + str(cell_a_pos) + " to Cell " + str(cell_b_pos))
	print(str(unitary_distance_a_to_b))
	var bin_result_a = 0
	var bin_result_b = 0
	match unitary_distance_a_to_b:
		Vector2(0,1):
			bin_result_a |= Global.OPEN_PATHS.UP
			bin_result_b |= Global.OPEN_PATHS.DOWN
			print('up')
		Vector2(0,-1):
			bin_result_a |= Global.OPEN_PATHS.DOWN
			bin_result_b |= Global.OPEN_PATHS.UP
			print('down')
		Vector2(1,0):
			bin_result_a |= Global.OPEN_PATHS.LEFT
			bin_result_b |= Global.OPEN_PATHS.RIGHT
			print('left')
		Vector2(-1,0):
			bin_result_a |= Global.OPEN_PATHS.RIGHT
			bin_result_b |= Global.OPEN_PATHS.LEFT
			print('right')
	cells[cell_a_pos].add_bin_path(bin_result_a)
	print_bin(cells[cell_a_pos].open_paths)
	cells[cell_b_pos].add_bin_path(bin_result_b)
	print_bin(cells[cell_b_pos].open_paths)
	print("")

func print_bin(bin: int):
	var result: String
	for x in range(4):
		result += str((bin >> 3-x)%2)
	print(result)

func setup_cells():
	for x in range(board_size.x):
		for y in range(board_size.y):
			var cell_pos = Vector2(x,y)
			var newCell: Spatial = _cell_tscn.instance()
			add_child(newCell)
			newCell.translation = calculate_cell_center(cell_pos)
			cells[cell_pos] = newCell
			
	for x in range(3):
		for y in range(3):
			first_time_dead_cells.append(Vector2(2*x,2*y))
	first_time_dead_cells.erase(Vector2(2,2))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
