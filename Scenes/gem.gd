extends Area2D

class_name Gem

@onready var element_red_diamond: Sprite2D = $ElementRedDiamond  # onready has to be edited after
																 # being ready (in _ready function)

signal gem_off_screen

var diamond_height: float
var diamond_width: float
var viewport_height: float
var speed: float = 100.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diamond_height = element_red_diamond.get_rect().size.y
	diamond_width = element_red_diamond.get_rect().size.x
	viewport_height = get_viewport_rect().size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += delta * speed
	if position.y > viewport_height + diamond_height / 2:
		gem_off_screen.emit()
		die()


func _on_area_entered(area: Area2D) -> void:
	die()


func die() -> void:
	set_process(false)  # disables unwanted movement
	queue_free()  # deletes scene from the game
