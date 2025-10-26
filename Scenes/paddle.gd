extends Area2D

@onready var paddle_blu: Sprite2D = $PaddleBlu

var viewport_width: float
var paddle_width: float
var paddle_speed: float = 500
var movement: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	paddle_width = paddle_blu.get_rect().size.x
	viewport_width = get_viewport_rect().size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_paddle(delta)

# Responsible for moving the paddle to left and right
func move_paddle(delta: float) -> void:
	movement = Input.get_axis("move_left", "move_right")
	position.x = clampf(
		position.x + movement * paddle_speed * delta, 
		paddle_width / 2, 
		viewport_width - paddle_width / 2
	)
