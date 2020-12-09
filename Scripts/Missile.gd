extends KinematicBody2D

export var vitesse = 5;
var ennemi = null;

func _ready():
	pass

func _process(delta):
	mouvements();
	
func mouvements():
	var collision;
	if ennemi != null:
		look_at(ennemi.position);
		var velocity = Vector2(vitesse, 0).rotated(rotation);
		collision = move_and_collide(velocity);
	else:
		var velocity = Vector2(vitesse, 0).rotated(rotation);
		collision = move_and_collide(velocity);
	if collision:
		if collision.collider.is_in_group("limiteJeu"):
			queue_free();
		if collision.collider.is_in_group("asteroides"):
			queue_free();
		if collision.collider.is_in_group("laser"):
			queue_free();
		if collision.collider.is_in_group("missile"):
			queue_free();
		if collision.collider.is_in_group("ennemis"):
			collision.collider.tuer();
			queue_free();
		if collision.collider.is_in_group("joueur"):
			collision.collider.blesser_joueur(10);
			queue_free();

func _on_MissileVisible_screen_exited():
	queue_free();


func _on_MissileDetection_body_entered(body):
	if body.is_in_group("joueur"):
		ennemi = body;

func _on_MissileDetection_body_exited(body):
	if body.is_in_group("joueur"):
		ennemi = null;
