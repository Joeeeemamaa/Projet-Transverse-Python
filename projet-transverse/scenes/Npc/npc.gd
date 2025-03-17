extends CharacterBody3D

@export var speed: float = 2.0
@export var detection_radius: float = 5.0
@export var player: Node3D = null  # Assign the player manually in the Inspector

var is_chasing = false

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var interact_area: Area3D = $Area3D  # Reference the interaction area

func _ready():
	interact_area.connect("body_entered", _on_body_entered)

func _physics_process(delta):
	if is_chasing and player:
		nav_agent.target_position = player.global_position
		move_towards_target(delta)

func move_towards_target(delta):
	var direction = (nav_agent.get_next_path_position() - global_position).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()

func _on_body_entered(body):
	if body.is_in_group("player"):
		is_chasing = true  # Start following the player
