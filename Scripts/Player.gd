extends KinematicBody2D


export var maxHealth = 3.0
var health

var jumpMode = false

var offWall = true
var facingRight = true
var inAir = true

var Gravity = Vector2(0,800)
var vel = Vector2()
var speed = 200
var jumpSpeed = -400
var offWallSpeed = -400

#Modifiers
var wallMod = 1
var fallMod = 1.5

var WallSlideBox
var SlideBoxXCoor = 33


var SpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth
	WallSlideBox = get_node("WallSlideBox/CollisionShape2D")
	SpawnPoint = position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	
	
	if vel.y > 0:
		vel.y += Gravity.y * delta * fallMod * wallMod;
	else:
		vel.y += Gravity.y * delta * wallMod;
	
	
	vel = move_and_slide(vel, Gravity);
	
func get_input():
	vel.x = 0
	if Input.is_action_pressed("key_left"):
		vel.x -= speed;
		setFacing(false)
	if Input.is_action_pressed("key_right"):
		vel.x += speed;
		setFacing(true)
		
	if Input.is_action_just_pressed("key_jump"):
		if !inAir or !offWall:
			vel.y = jumpSpeed
		
	
	
	if Input.is_action_just_pressed("test_switch_jump"):
		jumpMode = !jumpMode
		
	if Input.is_action_just_pressed("restart"):
		respawn()
	
	
func heal():
	health += 1
	if health > maxHealth:
			health = maxHealth

func takeDamage():
	health -= 1
	if health < 1:
		respawn()
		print("Game Over")
			
func respawn():
	vel = Vector2()
	health = maxHealth
	position = SpawnPoint
	
func resetSpawn(newPos):
	SpawnPoint = newPos

func setFacing(right):
	if right:
		WallSlideBox.get_shape().a.x = SlideBoxXCoor
		WallSlideBox.get_shape().b.x = SlideBoxXCoor
	else:
		WallSlideBox.get_shape().a.x = -SlideBoxXCoor
		WallSlideBox.get_shape().b.x = -SlideBoxXCoor


func _on_WallSlideBox_body_entered(body):
	if body.name != "Player":
		wallMod = 0.1
		offWall = false


func _on_WallSlideBox_body_exited(body):
	offWall = true
	wallMod = 1.0


func _on_FloorDetector_body_entered(body):
	if body.name != "Player":
		inAir = false


func _on_FloorDetector_body_exited(body):
	inAir = true
