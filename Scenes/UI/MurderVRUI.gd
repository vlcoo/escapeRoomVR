extends VRGUI


func _on_Area_area_entered(area):
	is_activated = true
	print("got in UI area")
	$MurderUI/Mask.visible = Global.clues_solved.size() >= 3
