extends "Entity.gd"


var evade_target = null
var attack_cooldown = 1
var BASE_SPEED = randf_range(20, 30)


func _ready():
    speed = BASE_SPEED
    $Sprite.play("default")
    
    
func distance_to_ground():
    $PathRay.target_position = Vector2(0, 500)
    if $PathRay.is_colliding():
        return (global_position - $PathRay.get_collision_point()).length()
    else:
        return 501


func _physics_process(delta):
    # Does NOT use super._physics_process, it handles its own movement.
    
    if attack_cooldown > 0:
        attack_cooldown = max(attack_cooldown - delta, 0)
    
    var altitude = distance_to_ground()
    if (altitude - (velocity.y * delta)) < 100:
        if not is_on_ceiling():
            velocity += Vector2(0, -400) * delta
    elif (altitude - (velocity.y * delta)) > 150:
        if not is_on_floor():
            velocity += Global.gravity * delta
            
    var diff = (global_position - player.global_position).rotated(randf_range(-0.1, 0.1))
    var is_aimed_at = player.aim_angle != null and abs(player.aim_angle - diff.angle()) < 0.1745
    if is_aimed_at or attack_cooldown > 0:
        if is_aimed_at:
            attack_cooldown = max(attack_cooldown, 1)
            speed = BASE_SPEED * 1.5
        if diff.length() < (300 if is_aimed_at else 100):
            velocity.x += speed * sign(diff.x)
            velocity.y += (speed * sign(diff.y)) - (speed * 0.2)
    elif diff.length() > 10:
        speed = BASE_SPEED
        velocity.x -= speed * sign(diff.x)
        velocity.y -= speed * sign(diff.y)
    elif attack_cooldown == 0 and diff.length() < 10:
        attack_cooldown = 3
        player.hurt(2)
                
    velocity *= 0.9
        

    move_and_slide()
