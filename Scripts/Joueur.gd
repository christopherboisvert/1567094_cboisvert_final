extends KinematicBody2D

onready var joueurAnimation = $JoueurAnimation;
var velocity = Vector2();
var vitesse = 250;

func _ready():
	joueurAnimation.play("default");

func _process(delta):
	pass

func _physics_process(delta):
	var avancer = Input.is_action_pressed("ui_avancer");
	var dir = get_global_mouse_position() - global_position;
	
	if avancer:
		velocity = Vector2(vitesse, 0).rotated(rotation);
	else:
		velocity = Vector2(0,0).rotated(rotation);
	velocity = move_and_slide(velocity);
	
	if dir.length() > 5:
		rotation = dir.angle();
