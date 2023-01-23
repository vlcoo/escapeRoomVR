extends RichTextLabel


var CluesUnlocked = 0


func _process(delta):
	text+= str(CluesUnlocked)

