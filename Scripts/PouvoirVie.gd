extends KinematicBody2D

onready var velocity = Vector2(0,0);
onready var pouvoirVieSon = $PouvoirVieSon;

func _ready():
	pass # Replace with function body.

func _process(delta):
	var collision = move_and_collide(velocity);
	if collision:
		if collision.collider.is_in_group("joueur"):
			collision.collider.augmentation_vie_joueur(5);
			global.score += 100;
			queue_free();
