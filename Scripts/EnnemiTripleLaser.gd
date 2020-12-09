extends KinematicBody2D

var velocity = Vector2();
var enAttaque = false;
var enCoolDown = false;
var ennemi;
var laserEnnemi = preload("res://Scenes/LaserEnnemi.tscn");
export var vitesse = 100;
onready var ennemiTripleLaserPosition1 = $EnnemiTripleLaserPosition1;
onready var ennemiTripleLaserPosition2 = $EnnemiTripleLaserPosition2;
onready var ennemiTripleLaserPosition3 = $EnnemiTripleLaserPosition3;
onready var ennemiTripleLaserTimer = $EnnemiTripleLaserTimer;
onready var ennemiTripleLaserSon = $EnnemiTripleLaserSon;

func _ready():
	ennemiTripleLaserTimer.start();

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
			var nouveauLaserEnnemi1 = laserEnnemi.instance();
			var nouveauLaserEnnemi2 = laserEnnemi.instance();
			var nouveauLaserEnnemi3 = laserEnnemi.instance();
			nouveauLaserEnnemi1.global_position = ennemiTripleLaserPosition1.global_position;
			nouveauLaserEnnemi2.global_position = ennemiTripleLaserPosition2.global_position;
			nouveauLaserEnnemi3.global_position = ennemiTripleLaserPosition3.global_position;
			nouveauLaserEnnemi1.global_rotation = rotation;
			nouveauLaserEnnemi2.global_rotation = rotation - 45;
			nouveauLaserEnnemi3.global_rotation = rotation + 45;
			get_parent().add_child(nouveauLaserEnnemi1);
			get_parent().add_child(nouveauLaserEnnemi2);
			get_parent().add_child(nouveauLaserEnnemi3);
			ennemiTripleLaserSon.play();
		else:
			ennemi = null;
			enAttaque = false;

func _on_EnnemiTripleLaserTimer_timeout():
	enCoolDown = false;
	
func tuer():
	ennemi.augmenter_score_joueur(500);
	queue_free();

func _on_EnnemiTripleLaserDetection_body_entered(body):
	if body.is_in_group("joueur"):
		ennemi = body;
		enAttaque = true;


func _on_EnnemiTripleLaserDetection_body_exited(body):
	if body.is_in_group("joueur"):
		ennemi = null;
		enAttaque = false;
