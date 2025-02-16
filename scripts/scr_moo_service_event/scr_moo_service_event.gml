enum LAUNCHER_EVENT {
	SETTINGS_SCALING_CHANGED,
	SETTINGS_MODE_CHANGED,
	SETTINGS_MUSIC_VOLUME_CHANGED,
	SETTINGS_SOUNDS_VOLUME_CHANGED,
	LAUNCHER_GAME_SELECTION_CHANGED,
	LAUNCHER_WILL_QUIT,
}

function moo_service_event() constructor {
	subscription_map = ds_map_create();
	
	function subscribe(_event, _subscriber, _callback) {
		var _subscription = {subscriber: _subscriber, callback: _callback};
		
		if(!ds_map_exists(subscription_map, _event)) {
			subscription_map[? _event] = ds_list_create();
		}
		
		var _subscriptions = subscription_map[? _event];
		ds_list_add(_subscriptions, _subscription);
	}
	
	function unsubscribe(_event, _subscriber) {
		if(!ds_map_exists(subscription_map, _event)) {
			return;
		}
		
		var _subscriptions = subscription_map[? _event];
		
		for(var _i = 0; _i < ds_list_size(_subscriptions); _i++) {
			var _subscription = _subscriptions[| _i];
			
			if(_subscription == undefined) {
				continue;
			}
			
			if(_subscription.subscriber == _subscriber) {
				_subscriptions[| _i] = undefined;
			}
		}
	}
	
	function fire(_event, _payload = undefined) {
		if(!ds_map_exists(subscription_map, _event)) {
			return;
		}
		
		var _subscriptions = subscription_map[? _event];
		
		if(ds_list_empty(_subscriptions)) {
			return;
		}
		
		for(var _i = 0; _i < ds_list_size(_subscriptions); _i++) {
			var _subscription = _subscriptions[| _i];
			
			if(_subscription == undefined) {
				continue;
			}
			
			_subscription.callback(_payload);
		}
		
		if(_event == LAUNCHER_EVENT.LAUNCHER_GAME_SELECTION_CHANGED) {
					show_debug_message(_payload);
		}
	}
}