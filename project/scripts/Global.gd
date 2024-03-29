extends Node

var DEBUG = false

## Settings
@export var play_music = false
@export var play_fades = false

var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = gravity_vector * gravity_magnitude

var can_wall_jump = true


var config = ConfigFile.new()


func save_config():
    config.set_value("Settings", "play_music", play_music)
    config.set_value("Settings", "play_fades", play_fades)
    
    for action in InputMap.get_actions():
        if action.substr(0, 3) != "ui_":
            config.set_value("Controls", action, InputMap.action_get_events(action))
    
    config.save("user://settings.cfg")  


func load_config():
    for section in config.get_sections():
        if section == "Settings":
            play_music = config.get_value(section, "play_music")
            play_fades = config.get_value(section, "play_fades")
        elif section == "Controls":
            for action in InputMap.get_actions():
                if not config.has_section_key(section, action):
                    continue
                InputMap.action_erase_events(action)
                for input_event in config.get_value(section, action):
                    InputMap.action_add_event(action, input_event)


func _ready():
    var err = config.load("user://settings.cfg")
    if err == OK:
        load_config()
    elif err == ERR_FILE_NOT_FOUND:
        save_config()
