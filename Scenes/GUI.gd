class_name VRGUI
extends Spatial

# An exported NodePath to the Viewport node to use for the VR GUI.
# (NOTE: because this NodePath is exported, you will need to set it in the Godot editor!)
onready var gui_viewport = $GUI
export (PackedScene) var control_scene = null
var control_node
var is_activated = false


func _ready():
	if (control_scene != null):
		control_node = control_scene.instance()
		$GUI.add_child(control_node)
	render_viewport()


func _process(delta):
	pass


func render_viewport():
	# Wait two frames so the Viewport node has time to initialize and render to a texture
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	# Create a new SpatialMaterial
	var material = SpatialMaterial.new()
	# Tell the material to render unshaded
	material.flags_unshaded = true
	# Get the Viewport texture from the Viewport node and assign as as the albedo texture
	# in the SpatialMaterial
	material.albedo_texture = gui_viewport.get_texture()
	# Tell the material to use transparency
	material.flags_transparent = true
	material.flags_unshaded = true
	# Finally, set the material of the MeshInstance to the newly created SpatialMaterial so the
	# contents of the Viewport are visible
	$GUI_Board.set_surface_material(0, material)


func set_transparent(how: bool):
	$GUI_Board.visible = !how;


func _on_Area_area_entered(area):
	is_activated = true


func _on_Area_area_exited(area):
	is_activated = false
