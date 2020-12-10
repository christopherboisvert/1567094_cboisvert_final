extends Node

onready var boutonJouerImage = $boutonJouer/boutonJouerImage;
onready var boutonAideImage = $boutonAide/boutonAideImage;
onready var boutonCreditsImage = $boutonCredits/boutonCreditsImage;
onready var boutonQuitterImage = $boutonQuitter/boutonQuitterImage;
onready var sonBackground = $SonBackground;
onready var highScore = $Score;

func _ready():
	global.high_score = global.score;
	global.score = 0;
	highScore.bbcode_text = "[center]" + str(global.high_score) + "[/center]";
	sonBackground.play();

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

func _on_boutonJouer_mouse_entered():
	boutonJouerImage.modulate = Color(1,1,1,0.7);

func _on_boutonJouer_mouse_exited():
	boutonJouerImage.modulate = Color(1,1,1,1);

func _on_boutonAide_mouse_entered():
	boutonAideImage.modulate = Color(1,1,1,0.7);

func _on_boutonAide_mouse_exited():
	boutonAideImage.modulate = Color(1,1,1,1);

func _on_boutonCredits_mouse_entered():
	boutonCreditsImage.modulate = Color(1,1,1,0.7);

func _on_boutonCredits_mouse_exited():
	boutonCreditsImage.modulate = Color(1,1,1,1);

func _on_boutonQuitter_mouse_entered():
	boutonQuitterImage.modulate = Color(1,1,1,0.7);

func _on_boutonQuitter_mouse_exited():
	boutonQuitterImage.modulate = Color(1,1,1,1);
