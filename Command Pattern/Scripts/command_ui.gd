class_name CommandUI extends CanvasLayer

@onready var unit: CommandUnit = $"../Unit"
@onready var command_list: VBoxContainer = $VBoxContainer/CommandList
@onready var undo_button: Button = $VBoxContainer/UndoButton
@onready var undo_list: VBoxContainer = $VBoxContainer/UndoList

func _ready() -> void:
	unit.commands_changed.connect ( _on_command_added )
	undo_button.pressed.connect ( _on_undo_clicked )
	pass
	
func _on_command_added() -> void:
	for c in command_list.get_children():
		c.free()
	
	for c in undo_list.get_children():
		c.free()
		
	for c in unit.command_queue:
		command_list.add_child( create_label( c ) )

	for c in unit.undo_queue:
		undo_list.add_child( create_label( c ) )
	
	pass
	
func _on_undo_clicked() -> void:
	unit.undo_last_command()
	pass
	
# Create, configure and return a new label control instance
func create_label ( c : Command ) -> Label:
	var new_label : Label = Label.new()
	new_label.text = c.command_name
	#if c is CommandMove:
		#new_label.text += " | " + str ( c.targer_position )
	new_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	return new_label
