extends "Entity.gd"


func _ready():
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

    move_and_slide()
