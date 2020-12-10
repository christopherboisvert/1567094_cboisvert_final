extends KinematicBody2D

onready var joueurAnimation = $JoueurAnimation;
onready var joueurCanon = $JoueurCanon;
onready var joueurSonTir = $JoueurSonTir;
onready var joueurSonMort = $JoueurSonMort;
onready var joueurSonPouvoirVie = $JoueurSonPouvoirVie;
onready var joueurSonBlessure = $JoueurSonBlessure;
var laser = preload("res://Scenes/Laser.tscn");
var velocity = Vector2();
export var vitesse = 400;
export var vie = 100;
var sonMortJoue = false;

func _ready():
	joueurAnimation.play("default");

func _process(delta):
	if vie > 100:
		vie = 100;
	if vie < 0:
		vie = 0;

func _physics_process(delta):
	if vie != 0:
		mouvements();
		actions();
		detectionCollision();
	else:
		if !sonMortJoue:
			sonMortJoue = true;
			joueurSonMort.play();
	
func actions():
	var joueur_tire = Input.is_action_just_pressed("ui_click_left");
	
	if joueur_tire:
		var nouveau_laser = laser.instance();
		nouveau_laser.global_position = joueurCanon.global_position;
		nouveau_laser.global_rotation = global_rotation;
		get_parent().add_child(nouveau_laser);
		joueurSonTir.play();

func mouvements():
	var avancer = Input.is_action_pressed("ui_avancer");
	var reculer = Input.is_action_pressed("ui_reculer");
	var gauche = Input.is_action_pressed("ui_gauche");
	var droite = Input.is_action_pressed("ui_droite");
	var dir = get_global_mouse_position() - global_position;
	
	#Avancer
	if avancer && !reculer && !gauche && !droite:
		velocity = Vector2(vitesse, 0).rotated(rotation);
	#Reculer
	elif !avancer && reculer && !gauche && !droite:
		velocity = Vector2(-vitesse, 0).rotated(rotation);
	#À gauche
	elif !avancer && !reculer && gauche && !droite:
		velocity = Vector2(0, -vitesse).rotated(rotation);
	#À droite
	elif !avancer && !reculer && !gauche && droite:
		velocity = Vector2(0, vitesse).rotated(rotation);
	#En avant et à gauche
	elif avancer && !reculer && gauche && !droite:
		velocity = Vector2(vitesse, -vitesse).rotated(rotation);
	#En avant et à droite
	elif avancer && !reculer && !gauche && droite:
		velocity = Vector2(vitesse, vitesse).rotated(rotation);
	#En arrière et à gauche
	elif !avancer && reculer && gauche && !droite:
		velocity = Vector2(-vitesse, -vitesse).rotated(rotation);
	elif !avancer && reculer && !gauche && droite:
		velocity = Vector2(-vitesse, vitesse).rotated(rotation);
	else:
		velocity = Vector2(0, 0).rotated(rotation);
	
	velocity = move_and_slide(velocity);
	
	if dir.length() > 5:
		rotation = dir.angle();

func blesser_joueur(vieEnlever):
	vie -= vieEnlever;
	joueurSonBlessure.play();
	
func augmentation_vie_joueur(vieAugmenter):
	joueurSonPouvoirVie.play();
	vie += vieAugmenter;

func detectionCollision():
	var slide_count = get_slide_count()
	if slide_count:
		var collision = get_slide_collision(slide_count - 1)
		if collision.collider.is_in_group("asteroides"):
			blesser_joueur(1);
		if collision.collider.is_in_group("ennemis"):
			blesser_joueur(5);
