extends Control

@onready var bean_counter = $TextArea/BeanCounter
@onready var beans_per_second_counter = $TextArea/BeansPerSecondCounter

func _ready():
	change_counters()
	User.connect("beans_stats_changed", change_counters)


func change_counters():
	beans_per_second_counter.text = str("PER SECOND: ", User.beans_per_second)
	
	if User.beans != 1:
		bean_counter.text = str(User.beans, " BEANS")
	else:
		bean_counter.text = str(User.beans, " BEAN")
