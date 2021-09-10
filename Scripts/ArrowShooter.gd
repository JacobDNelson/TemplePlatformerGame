extends Node2D

# Spawn rate of arrows in seconds
export var spawnRate = 3.0
var timeCounter = 0

export var facingLeft = true
var arrows = {}

# TODO
# Platforms (falling), Player Movement (wall jump?)

onready var ArrowScene = preload("res://Scenes/Arrow.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sprite").set_flip_h(!facingLeft)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	timeCounter += delta
	if timeCounter >= spawnRate:
		timeCounter = 0
		if facingLeft:
			var spawnPos = Vector2(position.x - get_node("StaticBody2D/CollisionShape2D").shape.extents.x/2, position.y)
			spawnArrow(spawnPos, facingLeft)
		else:
			var spawnPos = Vector2(position.x + get_node("StaticBody2D/CollisionShape2D").shape.extents.x/2, position.y)
			spawnArrow(spawnPos, facingLeft)


func spawnArrow(pos, facing):
	#var Arrow = load("res://Scenes/Arrow.tscn")
	var newArrow = ArrowScene.instance()
	newArrow.setStartingPosition(pos)
	newArrow.facingLeft = facing
	add_child(newArrow)
