class_name Command extends Node

signal command_completed

var command_name : String = "Command"
var unit : CommandUnit

## What will this command do when executed?
func execute() -> bool:
	command_completed.emit()
	return true
	
## What will this command do when "undone"?
func undo() -> bool:
	command_completed.emit()
	return true
