class_name Bullet extends Node2D

var move_direction : Vector2 = Vector2.UP
var distance_moved : float = 0.0
var rotation_angle : float = 0.0

@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	var new_pos : Vector2 = position + move_direction * delta * 900
	distance_moved += position.distance_to( new_pos )
	position = new_pos
	sprite_2d.rotation=rotation_angle
	
	if distance_moved > 2500:
		#queue_free()
		reset_bullet()
		
func reset_bullet () -> void:
	distance_moved = 0.0
	visible = false
	set_physics_process(false)
