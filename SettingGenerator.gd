extends VBoxContainer

@export var generator : Control

func _ready():
	var exportNames = []
	var script : Script = generator.get_script()
	
	var exportflags = PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE
	
	for property in script.get_script_property_list():
		if (property.usage & exportflags) == exportflags:
			print(property)
			makeRow(property.name,property.type,property.hint,property.hint_string)

func makeRow(propertyName : String, propertyType : int,propertyHint : int, propertyHintString : String):
	var row = HBoxContainer.new()
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_child(row)
	
	var label := Label.new()
	label.text = propertyName.capitalize()
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(label)
	
	var currentValue = generator.get(propertyName)
	match propertyHint:
		PROPERTY_HINT_RANGE:
			var newSlider = HSlider.new()
			
			newSlider.min_value = float(propertyHintString.split(",")[0])
			newSlider.max_value = float(propertyHintString.split(",")[1])
			newSlider.step = float(propertyHintString.split(",")[2])
			newSlider.value = currentValue
			newSlider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			row.add_child(newSlider)
			
			newSlider.value_changed.connect( func(val):
				generator.set(propertyName,val)
				generator._generate_full()
				print(propertyName," -> ",val)
				)
