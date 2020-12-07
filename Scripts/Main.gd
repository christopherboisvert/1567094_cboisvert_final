extends Node

func _ready():
	pass

#func _on_boutonAide_mouse_entered():
#	if Input.is_action_just_pressed("ui_click_left"):
#		pass

#func _on_boutonCredits_mouse_entered():
#	if Input.is_action_just_pressed("ui_click_left"):
#		pass

#func _on_boutonQuitter_mouse_entered():
#	if Input.is_action_just_pressed("ui_click_left"):
#		get_tree().quit();


func _on_boutonJouer_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("ui_click_left"):
		get_tree().change_scene("res://Scenes/Niveau1.tscn");


func _on_boutonAide_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func _on_boutonCredits_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func _on_boutonQuitter_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("ui_click_left"):
		get_tree().quit();
