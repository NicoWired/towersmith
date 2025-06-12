class_name EnemyWaves
extends Resource

var enemy_wave_1: Dictionary[int,Variant] = {
	1 : BlueGoblin
	,2 : BlueGoblin
	,3 : BlueTNTGoblin
	,4 : BlueGoblin
	,5 : YellowGoblin
	,6 : BlueGoblin
	,7 : BlueTNTGoblin
	,8 : BlueGoblin
	,9 : YellowGoblin
	,10 : BlueGoblin
	,11 : BlueTNTGoblin
	,12 : YellowGoblin
	,13 : BlueGoblin
	,14 : BlueTNTGoblin
	,15 : YellowGoblin
	,16 : BlueGoblin
	,17 : BlueTNTGoblin
	,18 : YellowGoblin
	,19 : YellowGoblin
	,20 : RedGoblin
}
var enemy_wave_2: Dictionary[int,Variant] = {
	1 : YellowGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : BlueGoblin
	,6 : BlueGoblin
	,7 : YellowGoblin
	,8 : RedGoblin
	,9 : YellowGoblin
	,10 : BlueGoblin
	,11 : YellowGoblin
	,12 : YellowGoblin
	,13 : BlueGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : YellowGoblin
	,17 : YellowGoblin
	,18 : RedGoblin
	,19 : YellowGoblin
	,20 : RedGoblin
}
var enemy_wave_3: Dictionary[int,Variant] = {
	1 : YellowGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : RedGoblin
	,6 : YellowGoblin
	,7 : YellowGoblin
	,8 : RedGoblin
	,9 : YellowGoblin
	,10 : BlueGoblin
	,11 : YellowGoblin
	,12 : RedGoblin
	,13 : BlueGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : RedGoblin
	,17 : YellowGoblin
	,18 : RedGoblin
	,19 : YellowGoblin
	,20 : PurpleGoblin
}
var enemy_wave_4: Dictionary[int,Variant] = {
	1 : RedGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : RedGoblin
	,6 : YellowGoblin
	,7 : YellowGoblin
	,8 : RedGoblin
	,9 : YellowGoblin
	,10 : BlueGoblin
	,11 : YellowGoblin
	,12 : RedGoblin
	,13 : PurpleGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : RedGoblin
	,17 : PurpleGoblin
	,18 : RedGoblin
	,19 : YellowGoblin
	,20 : PurpleGoblin
}
var enemy_wave_5: Dictionary[int,Variant] = {
	1 : RedGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : BlueGoblin
	,5 : RedGoblin
	,6 : PurpleGoblin
	,7 : YellowGoblin
	,8 : RedGoblin
	,9 : YellowGoblin
	,10 : RedGoblin
	,11 : YellowGoblin
	,12 : RedGoblin
	,13 : PurpleGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : RedGoblin
	,17 : PurpleGoblin
	,18 : RedGoblin
	,19 : RedGoblin
	,20 : PurpleGoblin
}
var enemy_wave_6: Dictionary[int,Variant] = {
	1 : RedGoblin
	,2 : BlueGoblin
	,3 : YellowGoblin
	,4 : RedGoblin
	,5 : RedGoblin
	,6 : PurpleGoblin
	,7 : YellowGoblin
	,8 : RedGoblin
	,9 : PurpleGoblin
	,10 : RedGoblin
	,11 : YellowGoblin
	,12 : RedGoblin
	,13 : PurpleGoblin
	,14 : RedGoblin
	,15 : YellowGoblin
	,16 : RedGoblin
	,17 : PurpleGoblin
	,18 : PurpleGoblin
	,19 : RedGoblin
	,20 : PurpleGoblin
}
var enemy_wave_7: Dictionary[int,Variant] = {
	1 : RedGoblin
	,2 : PurpleGoblin
	,3 : YellowGoblin
	,4 : RedGoblin
	,5 : RedGoblin
	,6 : PurpleGoblin
	,7 : YellowGoblin
	,8 : RedGoblin
	,9 : PurpleGoblin
	,10 : PurpleGoblin
	,11 : YellowGoblin
	,12 : RedGoblin
	,13 : PurpleGoblin
	,14 : RedGoblin
	,15 : PurpleGoblin
	,16 : RedGoblin
	,17 : OrangeGoblin
	,18 : PurpleGoblin
	,19 : RedGoblin
	,20 : OrangeGoblin
}
var enemy_wave_8: Dictionary[int,Variant] = {
	1 : PurpleGoblin
	,2 : PurpleGoblin
	,3 : YellowGoblin
	,4 : RedGoblin
	,5 : RedGoblin
	,6 : PurpleGoblin
	,7 : OrangeGoblin
	,8 : RedGoblin
	,9 : PurpleGoblin
	,10 : PurpleGoblin
	,11 : OrangeGoblin
	,12 : RedGoblin
	,13 : PurpleGoblin
	,14 : RedGoblin
	,15 : PurpleGoblin
	,16 : RedGoblin
	,17 : OrangeGoblin
	,18 : PurpleGoblin
	,19 : RedGoblin
	,20 : OrangeGoblin
}
var enemy_wave_9: Dictionary[int,Variant] = {
	1 : PurpleGoblin
	,2 : PurpleGoblin
	,3 : PurpleGoblin
	,4 : RedGoblin
	,5 : RedGoblin
	,6 : PurpleGoblin
	,7 : OrangeGoblin
	,8 : OrangeGoblin
	,9 : PurpleGoblin
	,10 : PurpleGoblin
	,11 : OrangeGoblin
	,12 : RedGoblin
	,13 : PurpleGoblin
	,14 : RedGoblin
	,15 : PurpleGoblin
	,16 : OrangeGoblin
	,17 : OrangeGoblin
	,18 : PurpleGoblin
	,19 : PurpleGoblin
	,20 : BrownGoblin
}
var enemy_wave_10: Dictionary[int,Variant] = {
	1 : PurpleGoblin
	,2 : PurpleGoblin
	,3 : PurpleGoblin
	,4 : RedGoblin
	,5 : RedGoblin
	,6 : PurpleGoblin
	,7 : BrownGoblin
	,8 : OrangeGoblin
	,9 : PurpleGoblin
	,10 : PurpleGoblin
	,11 : BrownGoblin
	,12 : RedGoblin
	,13 : PurpleGoblin
	,14 : RedGoblin
	,15 : PurpleGoblin
	,16 : OrangeGoblin
	,17 : BrownGoblin
	,18 : PurpleGoblin
	,19 : RedGoblin
	,20 : BrownGoblin
}
var enemy_waves: Array[Dictionary] = [
	enemy_wave_1,
	enemy_wave_2,
	enemy_wave_3,
	enemy_wave_4,
	enemy_wave_5,
	enemy_wave_6,
	enemy_wave_7,
	enemy_wave_8,
	enemy_wave_9,
	enemy_wave_10
]
