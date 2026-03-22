extends Node

signal ArduinoRead(response: int)

var serial: GdSerial

@export var port: String = "/dev/ttyACM0"
#For Linux: "/dev/ttyACM0"
#For PC: "COM3"

func _ready():
	# Create serial instance
	serial = GdSerial.new()
	
	# List available ports
	print("Available ports:")
	var ports = serial.list_ports()
	for i in range(ports.size()):
		var port_info = ports[i]
		print("- ", port_info["port_name"], " (", port_info["port_type"], ")")
	
	# Configure and open port
	serial.set_port(port)  # Adjust for your system
	serial.set_baud_rate(115200)
	
	if serial.open():
		print("Port opened successfully!")
	else:
		print("Failed to open port")

func _process(_delta):
	# Continuously check for available bytes
	# Draining all available lines in the buffer
	while serial.bytes_available() > 0:
		var line: String = serial.readline().strip_edges()
		
		if line == "PRESS":
			_simulate_keypress()
			print("PRESSED")
		
		#ignore empty or partial lines
		if line == "":
			continue
		
		var angle := int(line)
		emit_signal("ArduinoRead", angle)

func _simulate_keypress():
	var a = InputEventAction.new()
	a.action = "Enter" 
	a.pressed = true
	Input.parse_input_event(a)
	
	# Release it immediately so it's a single click
	a.pressed = false
	Input.parse_input_event(a)
