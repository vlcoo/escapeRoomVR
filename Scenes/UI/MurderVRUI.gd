extends VRGUI


func _ready():
	set_transparent(true)
	need_billboard = true


func _on_Area_area_entered(area):
	is_activated = true
	Global.active_control_node = self
	print("got in UI area")
	$AudioStreamPlayer.pitch_scale = 1.1
	$AudioStreamPlayer.play()
	$GUI/MurderUI/GridContainer/Heidi.grab_focus()
