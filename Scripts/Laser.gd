extends KinematicBody2D

export var vitesse = 10;

func _ready():
	pass

func _process(delta):
	var velocity = Vector2(vitesse, 0).rotated(rotation);
	var collision = move_and_collide(velocity);
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

func _on_LaserVisible_screen_exited():
	queue_free();
