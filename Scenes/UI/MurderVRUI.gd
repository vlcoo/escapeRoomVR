extends VRGUI


func _on_Area_area_entered(area):
	is_activated = true
	print("got in UI area")
	$GUI/MurderUI/GridContainer/Heidi.grab_focus()
