extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var open_paths: int = 0
var nono: Spatial


func unlock():
	$PathsNew/Unlocked.set_visible(true)

func add_bin_path(path):
	open_paths |= path
	update_visuals()

func update_visuals() -> void:
	if(open_paths & Global.OPEN_PATHS.RIGHT):
		$PathsNew/RightPath.visible = true
	if(open_paths & Global.OPEN_PATHS.LEFT):
		$PathsNew/LeftPath.visible = true
	if(open_paths & Global.OPEN_PATHS.UP):
		$PathsNew/UpPath.visible = true
	if(open_paths & Global.OPEN_PATHS.DOWN):
		$PathsNew/DownPath.visible = true

func dead_cell():
	pass;
#	$PathsNew/Unlocked.material.albedo_color = Color.red

func essential_cell():
	$PathsNew.visible = false
	$PathsOld.visible = false
	var newRoom: Spatial = Global.pop_essential_room_rnd()
	newRoom.set_scale(Vector3(0.20,0.20,0.20))
	add_child(newRoom)
	pass;
func room_cell():
	$PathsNew.visible = false
	$PathsOld.visible = false
	var newRoom: Spatial = Global.pop_normal_room_rnd()
	newRoom.set_scale(Vector3(0.20,0.20,0.20))
	add_child(newRoom)
	pass;
#	$PathsNew/Unlocked.material.albedo_color = Color.green

func _ready():
#	$PathsNew/Unlocked.material = SpatialMaterial.new()
	update_visuals()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
