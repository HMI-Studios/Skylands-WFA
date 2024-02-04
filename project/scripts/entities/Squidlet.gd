extends "Entity.gd"


var evade_target = null


func _ready():
    speed = randf_range(20, 30)
    print(speed)
    $Sprite.play("default")
    
    
func distance_to_ground():
    $PathRay.target_position = Vector2(0, 500)
    if $PathRay.is_colliding():
        return (global_position - $PathRay.get_collision_point()).length()
    else:
        return 501


func _physics_process(delta):
    # Does NOT use super._physics_process, it handles its own movement.
    
    var altitude = distance_to_ground()
    if (altitude - (velocity.y * delta)) < 100:
        if not is_on_ceiling():
            velocity += Vector2(0, -400) * delta
    elif (altitude - (velocity.y * delta)) > 150:
        if not is_on_floor():
            velocity += Global.gravity * delta
            
    if player.aim_angle != null:
        var diff = (global_position - player.global_position).rotated(randf_range(-0.1, 0.1))
        
        var is_aimed_at = abs(player.aim_angle - diff.angle()) < 0.1745
        if is_aimed_at:
            if diff.length() < 300:
                velocity.x += speed * sign(diff.x)
                velocity.y += speed * sign(diff.y)
                
    velocity *= 0.9
        

    move_and_slide()
