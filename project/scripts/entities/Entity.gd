extends CharacterBody2D


var pathfinder = preload("res://scripts/entities/Pathfinder.gd").new()

@onready var entities = get_node('/root/Main/World/Level/Entities')
@onready var player = get_node('/root/Main/Player')

@export var HP = 1
@export var speed = 40
@export var flying = false
    

func hurt(dmg):
    HP -= dmg
    if HP <= 0:
        die()


func die():
    entities.remove_child(self)
    call_deferred("queue_free")
    
    
func can_walk_towards(diff):
    %PathRay.position = diff.normalized() * speed
    %PathRay.force_raycast_update()
    return %PathRay.is_colliding()
    
    
func handle_movement(delta):
    var target = pathfinder.get_target(global_position)
    if target:
        var diff = target - global_position
        var angle = fmod(diff.angle() + PI*1.5, PI*2) - PI
        if abs(angle) < 0.7:
            pass #jump
        elif can_walk_towards(diff):
            velocity.x += speed * sign(diff.x)
        velocity *= 0.6
    else:
        velocity *= 0.9


func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity += Global.gravity * delta
        
    handle_movement(delta)
    move_and_slide()
