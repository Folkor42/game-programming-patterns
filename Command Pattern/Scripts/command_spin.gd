class_name CommandSpin extends Command

func _ready() -> void:
	command_name = "Spin"
	
func execute() -> bool:
	var tween = create_tween()
	tween.tween_property( unit, "rotation_degrees", 360, 0.5 )
	await tween.finished
	unit.rotation_degrees = 0
	command_completed.emit()
	return true

func undo() -> bool:
	unit.rotation_degrees = 360
	var tween = create_tween()
	tween.tween_property( unit, "rotation_degrees", 0, 0.5 )
	await tween.finished
	command_completed.emit()
	return true
