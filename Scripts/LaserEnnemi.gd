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
		if collision.collider.is_in_group("joueur"):
			collision.collider.blesser_joueur(5);
			queue_free();

func _on_LaserEnnemiVisible_screen_exited():
	queue_free();
