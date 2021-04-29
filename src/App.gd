# This comment was added with the custom editor!
extends Control

const APP_NAME = "Text Editor"

var current_file: String = "Untitled"
var saved: bool = true
# The text of the current file the last time it was saved.
var saved_state: String = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set the minimum window size.
	OS.min_window_size = get_viewport().size
	# Set the window title.
	update_window_title()
	# Prevent the window controls from bypassing the quit-without-save prompt.
	get_tree().set_auto_accept_quit(false)


# Handle quitting from the window controls.
func _notification(what: int) -> void:
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		quit()


# Creates a new, unsaved file.
func new_file() -> void:
	current_file = "Untitled"


# Opens the file browser to open an existing file.
func open_file() -> void:
	$FileDialog.window_title = "Open File"
	$FileDialog.mode = FileDialog.MODE_OPEN_FILE
	$FileDialog.popup_centered_ratio()


# Saves the current file.
func save_file() -> void:
	if current_file == "Untitled":
		save_as()
	else:
		var f: File = File.new()
		f.open(current_file, File.WRITE)
		f.store_string($VBoxContainer/TextEdit.text)
		f.close()
		saved = true
		saved_state = $VBoxContainer/TextEdit.text

	update_window_title()


# Opens the file browser to save the current file.
func save_as() -> void:
	$FileDialog.window_title = "Save File"
	$FileDialog.mode = FileDialog.MODE_SAVE_FILE
	$FileDialog.popup_centered_ratio()


# Quits the app.
func quit() -> void:
	if saved:
		get_tree().quit()
	else:
		$QuitDialog.popup()


# Shows the about dialog.
func about() -> void:
	$DialogAbout.popup()


# Updates the window title.
func update_window_title() -> void:
	var title: String = "%s - %s" if saved else "*%s - %s"
	OS.set_window_title(title % [current_file, APP_NAME])


func _on_MenuFile_item_pressed(name: String) -> void:
	match name:
		"New":
			new_file()
		"Open...":
			open_file()
		"Save":
			save_file()
		"Save As...":
			save_as()
		"Quit":
			quit()


func _on_MenuHelp_item_pressed(name: String) -> void:
	match name:
		"About":
			about()


func _on_FileDialog_file_selected(path: String) -> void:
	current_file = path
	match $FileDialog.mode:
		FileDialog.MODE_SAVE_FILE:
			save_file()
		FileDialog.MODE_OPEN_FILE:
			var f: File = File.new()
			f.open(current_file, File.READ)
			var text: String = f.get_as_text()
			f.close()
			$VBoxContainer/TextEdit.text = text
			saved = true
			saved_state = text

	update_window_title()


func _on_QuitDialog_confirmed() -> void:
	get_tree().quit()


func _on_TextEdit_text_changed() -> void:
	if $VBoxContainer/TextEdit.text == saved_state:
		saved = true
	else:
		saved = false

	update_window_title()


func _on_MenuView_checkable_item_pressed(name: String, value: bool) -> void:
	match name:
		"Show Line Numbers":
			$VBoxContainer/TextEdit.show_line_numbers = value
		"Wrap Text":
			$VBoxContainer/TextEdit.wrap_enabled = value
		"Show Minimap":
			$VBoxContainer/TextEdit.minimap_draw = value


# Saves the application state.  TODO: Figure out what type the state should be.
func save_state(state: Dictionary) -> void:
	pass


# Loads and returns the saved application state.
func load_state() -> Dictionary:
	pass


# Gets the current application state.
func get_app_state() -> Dictionary:
	pass


# Sets the application state.
func set_app_state(state: Dictionary) -> void:
	pass
