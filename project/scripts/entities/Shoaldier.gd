extends "RiggedEntity.gd"


var Bullet = preload("res://scenes/items/GDFSERBullet.tscn")
var cooldown = 1

var desired_player_distane = randf_range(80, 100)

var gun_hand

var is_gun_in_right_hand

func _ready():
    gun_hand = rig.get_node('Gun Hand')

    HP = 10
    head_height = 20 * scale.y
    rig.remove_child(gun_hand)
    rig.near_arm.get_node(rig.near_arm.remote_path).add_child(gun_hand)
    rig.near_hand.hide()
    rig.near_hand_remote.remote_path = gun_hand.get_path()
    gun_hand.show()
    is_gun_in_right_hand = true


func _physics_process(delta):
    
    if cooldown > 0:
        cooldown = max(cooldown - delta, 0)

    super._physics_process(delta)

    if %LineOfSight.is_player_in_sight():
        if rig.animation_player.is_playing():
            rig.animation_player.stop()
        handle_gun(delta)
        var diff = player.global_position - global_position
        pathfinder.override_target(player.global_position + -(diff.normalized() * desired_player_distane))
        #if diff.length() < 75 or diff.length() > 105:
    else:
        pathfinder.clear_override()
        if not rig.animation_player.is_playing():
            rig.animation_player.play("Idle")
    
    
func shoot(vec):
    if cooldown == 0:
        cooldown = 0.75
        var bullet = Bullet.instantiate()
        bullet.apply_impulse(vec * 750)
        bullet.modulate = Color(2, 0.5, 0)
        bullet.position = gun_hand.global_position + (vec*30)
        bullet.rotation = gun_hand.global_rotation
        get_node('/root/Main/World').add_child(bullet)
    

func handle_gun(delta):
    rig.update_direction(player.global_position - global_position)
    if rig.facing_right:
        if !is_gun_in_right_hand:
            rig.far_arm.get_node(rig.far_arm.remote_path).remove_child(gun_hand)
            rig.near_arm.get_node(rig.near_arm.remote_path).add_child(gun_hand)
            rig.far_hand_remote.remote_path = rig.far_hand.get_path()
            rig.far_hand.show()
            rig.near_hand.hide()
            rig.near_hand_remote.remote_path = gun_hand.get_path()
            is_gun_in_right_hand = true
    else:
        if is_gun_in_right_hand:
            rig.near_arm.get_node(rig.near_arm.remote_path).remove_child(gun_hand)
            rig.far_arm.get_node(rig.far_arm.remote_path).add_child(gun_hand)
            rig.near_hand_remote.remote_path = rig.near_hand.get_path()
            rig.near_hand.show()
            rig.far_hand.hide()
            rig.far_hand_remote.remote_path = gun_hand.get_path()
            is_gun_in_right_hand = false
           
    var aim_vec = rig.aim_at(delta, player.global_position)
    #if aim_vec:
        #shoot(aim_vec)
