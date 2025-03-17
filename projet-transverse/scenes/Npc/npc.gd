extends CharacterBody3D

@export var speed: float = 2.0
@export var detection_radius: float = 5.0
@export var player: Node3D = null  # Assign the player manually in the Inspector
@export var timeline_path: String = "res://npc_dialogue.dtl"



var is_chasing = false

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var interact_area: Area3D = $Area3D  # Reference the interaction area



func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
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
		

func _input(event):
	if event.is_action_pressed("interact"):
		Dialogic.start(timeline_path)


func _on_area_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
