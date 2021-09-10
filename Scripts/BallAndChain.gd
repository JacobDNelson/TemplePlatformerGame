extends Node2D

var pendulumLength
export var startingAngle = 45.0
var currentAngle
var maxAngle = PI - deg2rad(startingAngle) - PI/2.0

var angularVelocity = deg2rad(50)
var chainLength

# Called when the node enters the scene tree for the first time.
func _ready():
	chainLength = get_node("Chain").texture.get_height() * get_node("Chain").scale.y
	pendulumLength = chainLength + get_node("Ball/Area2D/CollisionShape2D").shape.radius
	currentAngle = deg2rad(startingAngle) - PI/2.0
	print(chainLength)

func _physics_process(delta):
	swing(delta)
	
	
	
func swing(delta):
	# Rotate entity around the empty end of the chain to simulate swinging
	# Ball and chain are kept as seperate sprites/subentities so that each element can be adjusted independently
	currentAngle = currentAngle + delta * angularVelocity
	if currentAngle > maxAngle:
		currentAngle = maxAngle
		angularVelocity = -angularVelocity
	elif currentAngle < deg2rad(startingAngle) - PI/2.0:
		currentAngle = deg2rad(startingAngle) - PI/2.0
		angularVelocity = -angularVelocity
	
	get_node("Chain").rotation = -currentAngle
	
	get_node("Chain").position.x = (chainLength/2) * sin(currentAngle)
	get_node("Chain").position.y = (chainLength/2) * cos(currentAngle)
	
	get_node("Ball").position.x = pendulumLength * sin(currentAngle)
	get_node("Ball").position.y = pendulumLength * cos(currentAngle)
	


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.takeDamage()
