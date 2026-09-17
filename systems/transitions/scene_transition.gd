extends Node

var pending_arrival_id: StringName = &""

func take_arrival_id() -> StringName:
	var arrival_id: StringName = pending_arrival_id
	pending_arrival_id = &""
	return arrival_id
