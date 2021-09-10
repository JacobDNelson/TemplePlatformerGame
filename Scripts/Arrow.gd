extends Node2D


export var speed = 20.0
export var persistRange = 100.0
export var facingLeft = true
var startingPosition = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	#startingPosition = position.x
	get_node("Sprite").set_flip_h(!facingLeft)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if facingLeft:
		position.x -= speed * delta
		if startingPosition.x - position.x > persistRange:
			self.queue_free()
	else:
		position.x += speed * delta
		if position.x - startingPosition.x > persistRange:
			self.queue_free()
	
	
func setStartingPosition(startPos):
	startingPosition = startPos

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.takeDamage()
		self.queue_free()
