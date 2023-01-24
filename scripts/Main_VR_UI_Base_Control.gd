extends Control


func _ready():
	$"../../..".diag_ui = Dialogic.start('Default')
	add_child($"../../..".diag_ui)

	# get_tree().root.get_node("World")...
