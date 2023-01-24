extends Spatial

var diag_ui
export var diag_timeline_name = "Test"
var diag_active = false


func _ready():
	$VRGUI.set_transparent(true)


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Dialogic.next_event()


func start_diag():
	diag_ui = Dialogic.start(diag_timeline_name)
	$VRGUI/GUI.add_child(diag_ui, true)
	$VRGUI.render_viewport()


func _on_AreaDialog_area_entered(area: Area):
	if diag_active:
		return
	$GhostCastSpell/AnimationPlayer.play("Appear")
	start_diag()
	diag_active = true

func _on_AnimationPlayer_animation_finished(anim_name: String):
	if(anim_name == "Appear"):
		$GhostCastSpell/AnimationPlayer.play("Idle")
	pass


func _on_AreaDialog_area_exited(area: Area):
	if !diag_active:
		return
	
	$GhostCastSpell/AnimationPlayer.play_backwards("Appear")
	for dialog in $VRGUI/GUI.get_children():
		dialog.queue_free();
	diag_active = false
