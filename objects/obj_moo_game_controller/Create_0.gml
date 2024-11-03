global.launcher = {};
global.launcher.games = new game_metadata();
global.launcher.achievements = new achievements_handler();

selected_index = 0;
games = global.launcher.games;

show_debug_message(games.count);

global.launcher.achievements.on_unlock(function(_achievement) {
	show_debug_message(_achievement.id);
});

global.launcher.achievements.unlock("aa_success");

var foo = global.launcher.achievements.find_all_by_game("Pixel Art Top Down - Basic");
var bar = 123;