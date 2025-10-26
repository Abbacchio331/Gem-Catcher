extends Node2D

const GEM = preload("res://Scenes/Gem.tscn")
const EXPLODE = preload("res://assets/explode.wav")
@onready var spawn_timer: Timer = $SpawnTimer
@onready var paddle: Area2D = $Paddle
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var score_label: Label = $ScoreLabel

var gem_width: float
var viewport_width: float
var current_score: int = 0

func spawn_gem() -> void:
	var new_gem: Gem = GEM.instantiate()
	if not gem_width:
		gem_width = new_gem.diamond_width
	var x_pos: float = randf_range(gem_width, viewport_width - gem_width)
	new_gem.position = Vector2(x_pos, -50.0)
	new_gem.gem_off_screen.connect(_on_gem_off_screen)  # signal connected to function
	add_child(new_gem)

func stop_all() -> void:
	sound.stop()
	sound.stream = EXPLODE
	sound.play()
	spawn_timer.stop()
	paddle.set_process(false)
	for child in get_children():
		if child is Gem:
			child.set_process(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_width = get_viewport_rect().size.x
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_gem_off_screen() -> void:
	stop_all()


func _on_timer_timeout() -> void:
	spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:
	current_score += 1
	score_label.text = "%03d" % current_score
	score_sound.position = area.position
	if not score_sound.playing:
		score_sound.play()
