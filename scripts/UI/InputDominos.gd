extends RichTextLabel

#export (int) var input = 0
func _process(delta):
	if(text.length()>=4):
		text = text.substr(0,4)
		
	

func _on_But_1_pressed():
	
	#set_text(str("1"))
	text+= str("1")


func _on_But_2_pressed():

	text+= str("2")

func _on_But_3_pressed():

	text+= str("3")

func _on_But_4_pressed():

	text+= str("4")

func _on_But_5_pressed():

	text+= str("5")

func _on_But_6_pressed():

	text+= str("6")

func _on_But_7_pressed():

	text+= str("7")

func _on_But_8_pressed():

	text+= str("8")

func _on_But_9_pressed():

	text+= str("9")
	

func _on_Eliminate_pressed():
	text = text.left(text.length() - 1)
	$"../Warning".text = str("")


func _on_Enter_pressed():
	if(text == str(4651)):
		Global.open_door("Bathroom")
		
	if(text.length()==4):
		if(text != str(4651)):
			$"../Warning".text = str("Incorrect!")
