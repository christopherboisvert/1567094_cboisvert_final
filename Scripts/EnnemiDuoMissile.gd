extends KinematicBody2D

var velocity = Vector2();
var enAttaque = false;
var enCoolDown = false;
var ennemi;
var missileEnnemi = preload("res://Scenes/Missile.tscn");
export var vitesse = 100;
onready var ennemiDuoMissilePosition1 = $EnnemiDuoMissilePosition1;
onready var ennemiDuoMissilePosition2 = $EnnemiDuoMissilePosition2;
onready var ennemiDuoMissileTimer = $EnnemiDuoMissileTimer;
onready var ennemiDuoMissileSon = $EnnemiDuoMissileSon;

func _ready():
	ennemiDuoMissileTimer.start();

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
			var nouveauMissileEnnemi1 = missileEnnemi.instance();
			var nouveauMissileEnnemi2 = missileEnnemi.instance();
			
			nouveauMissileEnnemi1.global_position = ennemiDuoMissilePosition1.global_position;
			nouveauMissileEnnemi2.global_position = ennemiDuoMissilePosition2.global_position;
			
			nouveauMissileEnnemi1.global_rotation = rotation;
			nouveauMissileEnnemi2.global_rotation = rotation;
			
			get_parent().add_child(nouveauMissileEnnemi1);
			get_parent().add_child(nouveauMissileEnnemi2);
			
			ennemiDuoMissileSon.play();
		else:
			ennemi = null;
			enAttaque = false;
	
func tuer():
	ennemi.augmenter_score_joueur(750);
	queue_free();

func _on_EnnemiDuoMissileDetection_body_entered(body):
	if body.is_in_group("joueur"):
		ennemi = body;
		enAttaque = true;

func _on_EnnemiDuoMissileDetection_body_exited(body):
	if body.is_in_group("joueur"):
		ennemi = null;
		enAttaque = false;


func _on_EnnemiDuoMissileTimer_timeout():
	enCoolDown = false;
