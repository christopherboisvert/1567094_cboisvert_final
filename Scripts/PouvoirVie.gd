extends KinematicBody2D

onready var velocity = Vector2(0,0);

func _ready():
	pass # Replace with function body.

func _process(delta):
	var collision = move_and_collide(velocity);
	if collision:
		if collision.collider.has_method("augmentation_vie_joueur"):
			collision.collider.augmentation_vie_joueur(10);
			queue_free();
