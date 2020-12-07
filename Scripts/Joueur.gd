extends KinematicBody2D

onready var joueurAnimation = $JoueurAnimation;
onready var joueurCanon = $JoueurCanon;
var laser = preload("res://Scenes/Laser.tscn");
var velocity = Vector2();
var vitesse = 300;

func _ready():
	joueurAnimation.play("default");

func _process(delta):
	pass

func _physics_process(delta):
	mouvements();
	actions();
	
	
func actions():
	var joueur_tire = Input.is_action_just_pressed("ui_shoot");
	
	if joueur_tire:
		var nouveau_laser = laser.instance();
		nouveau_laser.global_position = joueurCanon.global_position;
		nouveau_laser.global_rotation = global_rotation;
		get_parent().add_child(nouveau_laser);

func mouvements():
	var avancer = Input.is_action_pressed("ui_avancer");
	var dir = get_global_mouse_position() - global_position;
	
	if avancer:
		velocity = Vector2(vitesse, 0).rotated(rotation);
	else:
		velocity = Vector2(0,0).rotated(rotation);
	velocity = move_and_slide(velocity);
	
	if dir.length() > 5:
		rotation = dir.angle();
