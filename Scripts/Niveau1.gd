extends Node2D

onready var vieChiffre = $Interface/VieChiffre;
onready var joueur = $Joueur;
onready var score = $Interface/ScoreChiffre;
onready var sonBackground = $SonBackground;
onready var boutonRetourMenu = $Interface/boutonRetourMenu;
onready var tableauEnnemis = $Ennemis;

func _ready():
	sonBackground.play();

func _process(delta):
	interface();
	finJeu();

func interface():
	vieChiffre.value = joueur.vie;
	score.text = str(joueur.score);

func _on_boutonRetourMenu2_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("ui_click_left"):
		get_tree().change_scene("res://Scenes/Main.tscn");

func _on_boutonRetourMenu_mouse_entered():
	boutonRetourMenu.modulate = Color(1,1,1,0.7);

func _on_boutonRetourMenu_mouse_exited():
	boutonRetourMenu.modulate = Color(1,1,1,1);

func finJeu():
	if joueur.vie <= 0:
		joueur.visible = false;
		boutonRetourMenu.visible = true;
	if tableauEnnemis.get_child_count() > 0:
		pass
