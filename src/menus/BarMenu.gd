# Custom menu for the app menu bar.
extends MenuButton

# Emitted when an item is pressed.
signal item_pressed(name)
# Emitted when a checkable item changes.
signal checkable_item_pressed(name, value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_popup().connect("id_pressed", self, "_on_popup_id_pressed")


# Set up the menu items.
func setup_menu_items(items: Array) -> void:
	for item in items:
		match item[0]:
			"":
				get_popup().add_separator()
			"CHECK":
				get_popup().add_check_item(item[1])
			_:
				get_popup().add_item(item[0], -1, item[1])


# Turn the popup's signal into a signal we can actually work with.
func _on_popup_id_pressed(idx: int) -> void:
	if get_popup().is_item_checkable(idx):
		get_popup().set_item_checked(idx, !get_popup().is_item_checked(idx))
		emit_signal("checkable_item_pressed", get_popup().get_item_text(idx), get_popup().is_item_checked(idx))
	else:
		emit_signal("item_pressed", get_popup().get_item_text(idx))
