extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var open_paths: int = 0
var room_degrees: int = 0
var room_degrees_offset: int
var room: Spatial;
var unlocked: bool = false;

export(Array) var corridor_walls;

func unlock():
	$PathsNew/Unlocked.set_visible(true)

func add_bin_path(path):
	open_paths |= path
	update_visuals()

func update_visuals() -> void:
	if(open_paths & Global.OPEN_PATHS.RIGHT):
		$PathsNew/RightPath.visible = true
		room_degrees = 0
		
	if(open_paths & Global.OPEN_PATHS.LEFT):
		$PathsNew/LeftPath.visible = true
		room_degrees = 180
		
	if(open_paths & Global.OPEN_PATHS.UP):
		$PathsNew/UpPath.visible = true
		room_degrees = 90
		
	if(open_paths & Global.OPEN_PATHS.DOWN):
		$PathsNew/DownPath.visible = true
		room_degrees = 270
		

func dead_cell():
	pass;
#	$PathsNew/Unlocked.material.albedo_color = Color.red

func essential_cell():
	$PathsNew.visible = false
	$PathsOld.visible = false
	room = Global.pop_essential_room_rnd()
	room.set_scale(Vector3(0.20,0.20,0.20))
	add_child(room)
	room_degrees_offset = room.rotation_degrees.y-90;
	update_visuals()
	room.rotation_degrees.y = room_degrees_offset + room_degrees
	pass;
func room_cell():
	$PathsNew.visible = false
	$PathsOld.visible = false
	room = Global.pop_normal_room_rnd()
	room.set_scale(Vector3(0.20,0.20,0.20))
	add_child(room)
	room_degrees_offset = room.rotation_degrees.y-90;
	update_visuals()
	room.rotation_degrees.y = room_degrees_offset + room_degrees
	pass;
#	$PathsNew/Unlocked.material.albedo_color = Color.green

func _ready():
#	$PathsNew/Unlocked.material = SpatialMaterial.new()
	$RenderBody.connect('rendering', self, "set_visible")
	update_visuals()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
