extends Node2D


var facing_right = true
var facing_angle


@onready var entity = get_parent()
@onready var animation_player = get_node("AnimationPlayer")
var near_arm
var near_hand
var near_hand_remote
var far_arm
var far_hand
var far_hand_remote


@export var aim_speed = 3


func _ready():
    near_arm = get_node("Torso/RemoteNearArm")
    near_hand_remote = get_node("Torso/RemoteNearArm/RemoteNearHand")
    near_hand = get_node("Near Hand")
    far_arm = get_node("Torso/RemoteFarArm")
    far_hand_remote = get_node("Torso/RemoteFarArm/RemoteFarHand")
    far_hand = get_node("Far Hand")


func update_direction(vec):
    facing_angle = vec.angle()
    var new_facing_right = rad_to_deg(abs(facing_angle)) <= 90
        
    if new_facing_right != facing_right:
        var swap = near_arm.rotation
        near_arm.rotation = far_arm.rotation
        far_arm.rotation = swap
  
    facing_right = new_facing_right
    if facing_right:
        scale.x = 1
    else:
        scale.x = -1


func aim_at(delta, pos):
    var look_vec = pos - entity.global_position
    var aim_angle = facing_angle
    var aim_vec = look_vec.normalized()
    var return_vec
    
    if facing_right:
        if look_vec.length() > 22:
            aim_vec = (pos - near_hand.global_position).normalized()
            aim_angle = aim_vec.angle()
        var diff = (aim_angle - PI/2) - near_arm.rotation
        diff = fmod(diff + PI, PI*2) - PI
        if abs(diff) > aim_speed * delta:
            near_arm.rotation += aim_speed * delta * sign(diff)
            return_vec = Vector2(0, 1).rotated(near_arm.rotation)
        else:
            near_arm.rotation += diff
            return_vec = aim_vec
        far_arm.rotation = 0
        near_hand.rotation = 0.1
    else:
        if look_vec.length() > 22:
            aim_vec = (pos - far_hand.global_position).normalized()
            aim_angle = aim_vec.angle()
        var diff = (-aim_angle + PI/2) - far_arm.rotation
        diff = fmod(diff + PI, PI*2) - PI
        if abs(diff) > aim_speed * delta:
            far_arm.rotation += aim_speed * delta * sign(diff)
            return_vec = Vector2(0, 1).rotated(far_arm.rotation)
        else:
            far_arm.rotation += diff
            return_vec = aim_vec
        near_arm.rotation = 0
        far_hand.rotation = 0.1
        
    if return_vec != aim_vec:
        return null
    return return_vec
