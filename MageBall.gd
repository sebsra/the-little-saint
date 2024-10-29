extends CharacterBody2D

@export var SPEED = 50
var hud
var direction = 0
var spawnPos : Vector2
var spawnRot : float

func _ready():
	hud = get_node("../HUD")
	global_position = spawnPos
	global_rotation = spawnRot
	projectile_decay()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = direction.x * SPEED
	get_node("Ball").play("flying")
	move_and_slide()


func _on_hit_zone_body_entered(body):
	if body.name == "Player":
		hud.change_life(-1)
		self.queue_free()

func projectile_decay():
	await get_tree().create_timer(5.0).timeout
	self.queue_free()