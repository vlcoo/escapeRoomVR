extends Node
class_name MazeGeneratorPoint

var cell_size: Vector2
var cell_board: Vector2
var starting_pos: Vector2
var current_pos: Vector2
var board

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var backtrack_stack: Array
var visited_pos: Array
var dead_cells: Dictionary

var debug_freq: float = 0.2 #Place cell every X secs, 0 for no wait

signal visit_cell
signal found_dead_cell
signal open_path_between_cells

func setup(board_new, cell_size_new: Vector2, cell_board_new: Vector2, starting_pos_new: Vector2, first_time_dead_cells: Array):
	board = board_new
	cell_size = cell_size_new
	cell_board = cell_board_new
	starting_pos = starting_pos_new
	
	rng.randomize()
	for dead_cell in first_time_dead_cells:
		dead_cells[dead_cell] = true
	
func _add_to_visited(cell_pos: Vector2):
	visited_pos.append(cell_pos)
	emit_signal("visit_cell", cell_pos)
	pass

func _move_to_cell(cell_pos: Vector2):
	_add_to_visited(cell_pos)
	current_pos = cell_pos
	pass

func _get_available_cells_around() -> Array:
	var cells_around = _get_cells_around()
	var available_cells: Array = []
	for cell in cells_around:
		if visited_pos.find(cell) == -1:
			available_cells.append(cell)
	return available_cells

func _cell_exists(cell: Vector2) -> bool:
	return (cell.x >= 0 && cell.y >= 0) && (cell.x < cell_board.x && cell.y < cell_board.y)
	
func _is_dead_cell(cell: Vector2) -> bool:
	return dead_cells.has(cell)

func _get_cells_around() -> Array:
	var cells_around: Array = []
	var checked_cell: Vector2
	for pos in [-1, 1]:
		checked_cell = current_pos+Vector2(pos, 0)
		if(_cell_exists(checked_cell)): 
			cells_around.append(checked_cell)
			
		checked_cell = current_pos+Vector2(0, pos)
		if(_cell_exists(checked_cell)): 
			cells_around.append(checked_cell)
	return cells_around

func _get_next_cell() -> Vector2:
	var choosable_cells: Array = _get_available_cells_around()
	save_log(str(choosable_cells) + "\n")
	if(choosable_cells.size() == 0): return Errors.NOT_FOUND_VECTOR
	var chosen_cell: int = rng.randi() % choosable_cells.size()
	return choosable_cells[chosen_cell]  

func _backtrack() -> bool:
	var checked_cells = []
	save_log('Backtracking from: ' + str(current_pos) + "\n")
	while(checked_cells.empty()):
		current_pos = backtrack_stack.pop_back()
		checked_cells = _get_available_cells_around()
		save_log("Backtracked to: " + str(current_pos)+"\n")
		save_log("Stack: " + str(backtrack_stack) + "\n\n")
		if(backtrack_stack.empty()): return false
	return true

func make_maze():
	var cell_count = visited_pos.size()
	var cell_total = cell_board.x * cell_board.y
	
	clear_log()
	
	_move_to_cell(starting_pos)
	while(cell_count != cell_total):
#		if(debug_freq > 0): yield(get_tree().create_timer(debug_freq), 'timeout')
		save_log('cell count: ' + str(cell_count) + "\n")
		if(_is_dead_cell(current_pos)):
			emit_signal('found_dead_cell', current_pos)
			save_log('BACKTRACKING!\n')
			if(!_backtrack()): break
			
		var next_cell = _get_next_cell()
		
		if(next_cell != Errors.NOT_FOUND_VECTOR):
			emit_signal("open_path_between_cells", current_pos, next_cell)
			backtrack_stack.append(current_pos)
			_move_to_cell(next_cell)
			cell_count += 1
			save_log('Moving to next cell found:' + str(next_cell) + '\n')
		else:
			dead_cells[current_pos] = true
			save_log('Dead cell found\n')
		_debug_print()
		yield(get_tree(),"idle_frame")
		
func _debug_print():
	return
	var s_current_cell = ">C<"
	var s_visited_cell = " O "
	var s_blank_cell = "   "
	var s_debug_dead_cell = " X "
	var s_debug_horizontal_path = "<->"
	var s_debug_vertical_path = " | "
	var s_debug_vertical_wall = " / "
	var s_debug_horizontal_wall = "---"
	
	var checked_cell: Vector2
	var output: String = ""
	for c_x in range(cell_board.x*2):
		for c_y in range(cell_board.y*2):
			if(c_x%2 == 1):
				output += s_debug_horizontal_wall
			else:
				if(c_y%2==1):
					output += s_debug_vertical_wall
				else:
					checked_cell = Vector2(c_x/2,c_y/2)
					if(checked_cell == current_pos):
						output += s_current_cell
					elif(_is_dead_cell(checked_cell)):
						output += s_debug_dead_cell
					elif(visited_pos.find(checked_cell) != -1):
						output += s_visited_cell
					else:
						output += s_blank_cell
		output += '\n'
		save_log(output)
		output = ''
	save_log('\n\n')
		
func save_log(content):
	return
	var file = File.new()
	if(file.file_exists("res://log.txt")):
		file.open("res://log.txt", File.READ_WRITE)
	else:
		file.open("res://log.txt", File.WRITE)
	file.seek_end()
	file.store_string(content)
	file.close()
	
func clear_log():
	return
	var file = File.new()
	if(file.file_exists("res://log.txt")):
		var dir = Directory.new()
		dir.remove("res://log.txt")
