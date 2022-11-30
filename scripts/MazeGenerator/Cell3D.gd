extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var open_paths: int = 0

func unlock():
	$Unlocked.set_visible(true)

func add_bin_path(path):
	open_paths |= path
	update_visuals()

func update_visuals() -> void:
	if(open_paths & Global.OPEN_PATHS.RIGHT):
		$RightPath.visible = true
	if(open_paths & Global.OPEN_PATHS.LEFT):
		$LeftPath.visible = true
	if(open_paths & Global.OPEN_PATHS.UP):
		$UpPath.visible = true
	if(open_paths & Global.OPEN_PATHS.DOWN):
		$DownPath.visible = true

func dead_cell():
	$Unlocked.material.albedo_color = Color.red

func essential_cell():
	$Unlocked.material.albedo_color = Color.green

func _ready():
	$Unlocked.material = SpatialMaterial.new()
	update_visuals()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
