extends Node2D

onready var vie3 = $Interface/Vie3;
onready var vie2 = $Interface/Vie2;
onready var vie1 = $Interface/Vie1;
onready var joueur = $Joueur;
onready var score = $Interface/ScoreChiffre;

func _ready():
	pass

func _process(delta):
	interface();

func interface():
	if joueur.vie == 2:
		vie3.visible = false;
		vie2.visible = true;
		vie1.visible = false;
	if joueur.vie == 1:
		vie3.visible = false;
		vie2.visible = false;
		vie1.visible = true;
	if joueur.vie == 0:
		print("Mort...")
