extends Spatial

var current_area


func _ready():
	var VR = ARVRServer.find_interface("OpenVR");
	if VR and VR.initialize():
		get_viewport().arvr = true
		get_viewport().hdr = false
		OS.vsync_enabled = false
		Engine.iterations_per_second = 90
	
	current_area = $Terrain


func load_area(which):
	var new_area = load(which)
	add_child(new_area)
	$ARVROrigin.translation = new_area.get_node("PlayerSpawn").translation
	current_area = new_area
	remove_child(current_area)
