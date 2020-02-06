; Новая таблица существ
Temp1 dd ?
Temp2 dd ?
Temp3 dd ?
Temp4 dd ?
Temp5 dd ?
Temp6 dd ?
TextBufferAmmo rb 16
Адрес_параметров_альтерветки_для_диалога_постройки_альтерветок dd ?
Language db ?

; Данные триггера "Битва_Перед_действием"
Адрес_структуры_стека_совершающего_действие dd ?
Тип_действия_в_бою dd ?
Адрес_структуры_стека_на_которого_направлено_действие dd ?


rb 116; во избежание вылета в Форте на холме
MonTable_Buffer dd ?
MonTable rb sizeof._Creature_*MonNum; структура существ (главная)
Save_Massive = $
   MonTable2 rb 59000; вторичные абилки
	  Counterstrike_Table	      = MonTable2
	  AlwaysPositiveMorale_Table  = MonTable2+1000
	  AlwaysPositiveLuck_Table    = MonTable2+2000
	  Arrow_Table		      = MonTable2+3000
	  Ballistic_Table	      = MonTable2+4000
	  DeathBlow_Table	      = MonTable2+5000
	  DeathCloudAndFireBall_Table = MonTable2+6000
	  Espionage_Table	      = MonTable2+7000
	  Fear_Table		      = MonTable2+8000
	  Fearless_Table	      = MonTable2+9000
	  NoWallPenalty_Table	      = MonTable2+10000
	  MagicAura_Table	      = MonTable2+11000
	  FireShield_Table	      = MonTable2+12000
	  StrikeAndReturn_Table       = MonTable2+13000
	  SpellsCostLess_Table	      = MonTable2+14000
	  SpellsCostDump_Table	      = MonTable2+15000
	  Skeleton_Transformer_Table  = MonTable2+16000
	  Upgrades_Table	      = MonTable2+20000
	  Properties1_Table	      = MonTable2+24000
	  Properties2_Table	      = MonTable2+25000
	  Properties3_Table	      = MonTable2+26000
	  Properties4_Table	      = MonTable2+27000
	  Properties5_Table	      = MonTable2+28000
	  Immun_Table		      = MonTable2+29000
	  GnomResistance_Table	      = MonTable2+30000
	  GolemResistance_Table       = MonTable2+31000
	  Spells_Table		      = MonTable2+32000
	  Hate_Table		      = MonTable2+33000
	  JoustingBonus_Table	      = MonTable2+34000
	  ImmunToJoustingBonus_Table  = MonTable2+35000
	  RegenerationHitPoints_Table = MonTable2+36000
	  RegenerationChance_Table    = MonTable2+40000
	  ThreeHeadedAttack_Table     = MonTable2+41000
	  ManaDrain_Table	      = MonTable2+42000
	  MagicChannel_Table	      = MonTable2+44000
	  MagicMirror_Table	      = MonTable2+45000
	  Sharpshooters_Table	      = MonTable2+46000
	  ShootingAdjacent_Table      = MonTable2+47000
	  ReduceTargetDefense_Table   = MonTable2+48000
	  Rebirth_Table 	      = MonTable2+49000
	  PackAttack_Table	      = MonTable2+50000
	  AttackAllMove1	      = MonTable2+51000
	  AttackAllMove2	      = MonTable2+52000
	  PreventiveCounterstrikeTable= MonTable2+53000
	  RangeRetaliation_Table      = MonTable2+54000
	  RayColor_Table	      = MonTable2+55000
	  Ban_Table		      = MonTable2+56000;
	  Stun_Table		      = MonTable2+57000;
	  ProtectFromShooting_Table   = MonTable2+58000;
   CrAnim rb 84*MonNum
   Alternatives_Table rb 1512
   TownCreatures rb 48*504
   ImposedSpells_Table rb 6000
   DefenseBonus_Table rb 1000
   FireWall_Table rb 125
   Demonology_Table rb 2000
End_Save_Massive = $
CrExpMod rb 20*MonNum

MonNamesERM rb 12*MonNum; названия и описания существ для ERM
Имена		  rd 1000
Мн_имена	  rd 1000
Способности	  rd 1000

Reset_Имена	  rd 1000
Reset_Мн_имена	  rd 1000
Reset_Способности rd 1000

CrExpBon rb 340*1000
