extends HBoxContainer

const SEPARATOR = ["", 0]

const FILE_MENU_ITEMS = [
	["New", KEY_N | KEY_MASK_CTRL],
	["Open...", KEY_O | KEY_MASK_CTRL],
	SEPARATOR,
	["Save", KEY_S | KEY_MASK_CTRL],
	["Save As...", KEY_S | KEY_MASK_CTRL | KEY_MASK_SHIFT],
	SEPARATOR,
	["Quit", KEY_Q | KEY_MASK_CTRL],
]

const VIEW_MENU_ITEMS = [
	["CHECK", "Show Line Numbers"],
	["CHECK", "Wrap Text"],
	["CHECK", "Show Minimap"],
]

const HELP_MENU_ITEMS = [
	["About", 0],
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuFile.setup_menu_items(FILE_MENU_ITEMS)
	$MenuView.setup_menu_items(VIEW_MENU_ITEMS)
	$MenuHelp.setup_menu_items(HELP_MENU_ITEMS)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
