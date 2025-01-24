class_name CommandMove extends Command

var initial_position : Vector2 = Vector2.ZERO
var target_position : Vector2 = Vector2.ZERO

func _ready() -> void:
	command_name = "Move"
	
func execute () -> bool:
	initial_position = unit.global_position
	var tween = create_tween()
	tween.tween_property( unit, "position", target_position, get_duration())
	await tween.finished
	command_completed.emit()
	return true
	
func undo () -> bool:
	var tween = create_tween()
	tween.tween_property( unit, "position", initial_position, get_duration())
	await tween.finished
	command_completed.emit()
	return true

func get_duration()->float:
	return initial_position.distance_to(target_position) / 500
