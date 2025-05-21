class_name EnemyWaves
extends Resource

var enemy_wave_1: Dictionary[int,Variant] = {
	1 : BlueGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : YellowGoblin
	,6 : BlueGoblin
	,7 : BlueGoblin
	,8 : YellowGoblin
	,9 : YellowGoblin
	,10 : RedGoblin
	,11 : YellowGoblin
	,12 : YellowGoblin
	,13 : BlueGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : BlueGoblin
	,17 : RedGoblin
	,18 : YellowGoblin
	,19 : YellowGoblin
	,20 : RedGoblin
}
var enemy_wave_2: Dictionary[int,Variant] = {
	1 : YellowGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : RedGoblin
	,6 : BlueGoblin
	,7 : YellowGoblin
	,8 : RedGoblin
	,9 : YellowGoblin
	,10 : RedGoblin
	,11 : RedGoblin
	,12 : YellowGoblin
	,13 : BlueGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : YellowGoblin
	,17 : RedGoblin
	,18 : RedGoblin
	,19 : YellowGoblin
	,20 : RedGoblin
}
var enemy_waves: Array[Dictionary] = [enemy_wave_1, enemy_wave_2]
