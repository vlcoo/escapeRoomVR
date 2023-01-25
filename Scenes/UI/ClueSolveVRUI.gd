extends VRGUI

export(String) var password;
export(String) var door_to_open;

func _ready():
	control_node.password = password
	control_node.door_to_open = door_to_open
	
func _on_Area_area_entered(area):
	is_activated = true
	print("got in UI area")
	Global.active_control_node = self
	$AudioStreamPlayer.pitch_scale = 1.1
	$AudioStreamPlayer.play()
	$GUI/Control/GridContainer/Button.grab_focus()
