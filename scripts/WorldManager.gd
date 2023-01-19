extends Spatial

onready var viewport = $ViewportContainer/Viewport

var current_area


func _ready():
	var VR = ARVRServer.find_interface("OpenVR");
	if VR and VR.initialize():
		viewport.arvr = true
		viewport.hdr = false
		VisualServer.viewport_attach_camera(
			viewport.get_viewport_rid(),
			viewport.get_node("ARVROrigin/PlayerCamera").get_camera_rid()
		)
		OS.vsync_enabled = false
		Engine.iterations_per_second = 90
	
	load_area("res://Scenes/Areas/MainMenu.tscn")


func load_area(which, also_remove_current: bool = true):
	var scene_trs = load(which)
	var scene = scene_trs.instance()
	add_child(scene)
	$ViewportContainer/Viewport/ARVROrigin.translation = scene.get_node("PlayerSpawn").translation
	if also_remove_current:
		remove_child(current_area)
	current_area = scene
