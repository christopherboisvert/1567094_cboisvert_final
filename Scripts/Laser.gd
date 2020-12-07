extends KinematicBody2D

var vitesse = 10;

func _ready():
	pass

func _process(delta):
	var velocity = Vector2(vitesse, 0).rotated(rotation);
	var collision = move_and_collide(velocity);
