class_name opaque_block

class PlayerSuffocator:
	var playerOverlapsBlock = false
	var prevPlayerOverlapsBlock = playerOverlapsBlock
	
	# Run this in the process of your block
	func _process(area: Area2D):
		if (area.get_overlapping_bodies().any(is_player_body)):
			playerOverlapsBlock = true
		else:
			playerOverlapsBlock = false
			
		if (playerOverlapsBlock != prevPlayerOverlapsBlock):
			# i.e. send out the signal _only_ when it's changed whether the player is overlapping a block
			SignalBus.player_overlaps_block.emit(playerOverlapsBlock)
		prevPlayerOverlapsBlock = playerOverlapsBlock
		
	func is_player_body(body: PhysicsBody2D):
		return body.name == "Player"
