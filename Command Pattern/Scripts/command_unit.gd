class_name CommandUnit extends Node2D

signal commands_changed

var command_queue : Array [ Command ] = []
var undo_queue : Array [ Command ] = []
var awaiting_execution : bool = false

# This is where we will invoke commands from within the unit script
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("spin"):
		var c = CommandSpin.new()
		add_command( c )
	elif event.is_action_pressed("click"):
		var c = CommandMove.new()
		c.target_position = get_global_mouse_position()
		add_command( c )
	pass
	
	
# ------------------------------------------
# This unit handles it's own command management.
# This is ideal for a large project, but for demo purposes it works great!
# Code like this could be added to a global script, and used to dispatch commands to any associated targets.
# ------------------------------------------

# Add a command to the Unit's queue
func add_command ( c : Command ) -> void:
	command_queue.append( c )
	add_child( c )
	c.unit = self
	execute_next_command()
	pass
	
# Execute the next command in the Unit's queue
# Recursive function
func execute_next_command ( ) -> void:
	commands_changed.emit()
	
	if awaiting_execution or command_queue.size() == 0:
		return
	
	awaiting_execution = true
	
	var c : Command = command_queue.front()
	
	c.command_completed.connect(command_compelted)
	c.execute()
	
	undo_queue.push_front( command_queue.pop_front() )
	

	
	pass
	
# Undo the last command (first in the undo queue)
func undo_last_command ( ) -> void:
	if awaiting_execution or undo_queue.size() == 0:
		return
	
	awaiting_execution=true
	
	var c : Command = undo_queue.pop_front()
	
	commands_changed.emit()
	
	c.undo()
	
	pass

func command_compelted()->void:
	awaiting_execution = false
	execute_next_command()
