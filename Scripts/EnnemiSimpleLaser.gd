extends KinematicBody2D

var velocity = Vector2();
var enAttaque = false;
var enCoolDown = false;
var ennemi;
var laserEnnemi = preload("res://Scenes/LaserEnnemi.tscn");
export var vitesse = 150;
onready var ennemiSimpleLaserPosition = $EnnemiSimpleLaserPosition;
onready var ennemiTimer = $EnnemiTimer;
onready var ennemiTir = $EnnemiTir;

func _ready():
	ennemiTimer.start();

func _process(delta):
	if enAttaque:
		mouvements(delta);
		shoot();

func mouvements(delta):
	look_at(ennemi.position);
	var dir = (ennemi.global_position - global_position).normalized();
	move_and_collide(dir * vitesse * delta);
	
func shoot():
	if enCoolDown == false:
		enCoolDown = true;
		if ennemi.vie > 0:
			var nouveauLaserEnnemi = laserEnnemi.instance();
			nouveauLaserEnnemi.global_position = ennemiSimpleLaserPosition.global_position;
			nouveauLaserEnnemi.global_rotation = rotation;
			get_parent().add_child(nouveauLaserEnnemi);
			ennemiTir.play();
		else:
			ennemi = null;
			enAttaque = false;
	

func _on_EnnemiZoneDetection_body_entered(body):
	if body.is_in_group("joueur"):
		ennemi = body;
		enAttaque = true;

func _on_EnnemiZoneDetection_body_exited(body):
	if body.is_in_group("joueur"):
		ennemi = null;
		enAttaque = false;

func tuer():
	ennemi.augmenter_score_joueur(250);
	queue_free();

func _on_EnnemiTimer_timeout():
	enCoolDown = false;
