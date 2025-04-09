extends Node2D

const BULLET = preload("res://Object Pooling Pattern/bullet.tscn")

@onready var bullet_spawn: Marker2D = $Ship/BulletSpawn
@onready var shot_delay: Timer = $Ship/ShotDelay

var is_firing : bool = false
var bullet_count : int = 60
var max_bullet_count : int = 30000
var bullet_spread_angle : float = 5.0
var bullet_pool : Array [ Bullet ]
var bullet_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in max_bullet_count:
		var b : Bullet = BULLET.instantiate()
		add_child(b)
		bullet_pool.append(b)
		b.reset_bullet()
	shot_delay.timeout.connect(spawn_bullets_pooled)
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		is_firing = true
	elif event.is_action_released("click"):
		is_firing = false
		
func spawn_bullets () -> void:
	if is_firing:
		var count : int = 60
		var dir : Vector2 = Vector2.UP
		var rad_angle : float = deg_to_rad( 5 )
		var angle : float = -rad_angle * count * 0.5
		for i in count:
			var bullet : Bullet = BULLET.instantiate()
			add_child( bullet )
			bullet.move_direction=dir.rotated( angle )
			bullet.global_position = bullet_spawn.global_position
			bullet.rotation_angle = angle
			angle += rad_angle
	pass
	
func spawn_bullets_pooled() -> void:
	if is_firing:
		var dir : Vector2 = Vector2.UP
		var rad_angle : float = deg_to_rad( bullet_spread_angle )
		var angle : float = -rad_angle * bullet_count * 0.5
		
		for i in bullet_count:
			var b : Bullet = get_bullet_from_pool()
			b.move_direction=dir.rotated( angle )
			b.global_position = bullet_spawn.global_position
			b.rotation_angle = angle
			b.visible = true
			b.set_physics_process(true)
			angle += rad_angle
	
func get_bullet_from_pool () -> Bullet:
	var bullet : Bullet = bullet_pool[bullet_index]
	bullet_index = wrapi( bullet_index + 1, 0, max_bullet_count )
	return bullet
