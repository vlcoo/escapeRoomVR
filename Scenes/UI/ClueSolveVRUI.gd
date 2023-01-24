extends VRGUI


func _on_Area_area_entered(area):
	is_activated = true
	print("got in UI area")
	Global.active_control_node = self
	$GUI/Control/Button.grab_focus()
