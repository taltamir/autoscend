script "auto_theSource.ash"

boolean theSource_initializeSettings();
boolean theSource_buySkills();
boolean LX_theSource();
boolean theSource_oracle();


boolean theSource_initializeSettings()
{
	if(my_path() == "The Source")
	{
#		set_property("auto_lastSpoon", 0);
		set_property("auto_getBeehive", true);
		set_property("auto_wandOfNagamar", false);
	}
	return false;
}

boolean theSource_buySkills()
{
	if(get_property("sourceEnlightenment").to_int() == 0)
	{
		return false;
	}

	string temp = visit_url("place.php?whichplace=manor1&action=manor1_sourcephone_ring");
	int enlightenment = get_property("sourceEnlightenment").to_int();
	while(enlightenment > 0)
	{
		int option = 0;
		if(!have_skill($skill[Restore]))
		{
			option = 10;
		}
		if(!have_skill($skill[Overclocked]))
		{
			option = 1;
		}
		if(!have_skill($skill[Reboot]))
		{
			option = 9;
		}
		if(!have_skill($skill[Bullet Time]))
		{
			option = 2;
		}
		if(!have_skill($skill[True Disbeliever]))
		{
			option = 3;
		}
		if(!have_skill($skill[Code Block]))
		{
			option = 4;
		}
		if(!have_skill($skill[Disarmament]))
		{
			option = 5;
		}
		if(!have_skill($skill[Humiliating Hack]))
		{
			option = 7;
		}
		if(!have_skill($skill[Big Guns]))
		{
			option = 6;
		}
		if(!have_skill($skill[Data Siphon]))
		{
			option = 11;
		}
		if(!have_skill($skill[Source Kick]))
		{
			option = 8;
		}

		if(option != 0)
		{
			temp = visit_url("choice.php?pwd=&whichchoice=1188&option=1&skid=" + option);
		}
		enlightenment -= 1;
	}
	return false;
}

boolean LX_theSource()
{
	if(my_path() != "The Source")
	{
		return false;
	}

	if((my_daycount() <= 2) && (have_effect($effect[Substats.enh]) == 0) && (my_level() < 13))
	{
		auto_sourceTerminalEnhance("substats");
	}

	location goal = get_property("sourceOracleTarget").to_location();
	if((goal != $location[none]) && (item_amount($item[No Spoon]) == 0))
	{
		if(goal == $location[The Skeleton Store])
		{
			if(internalQuestStatus("questM23Meatsmith") == 0)
			{
				if(item_amount($item[Skeleton Store Office Key]) > 0)
				{
					set_property("choiceAdventure1060", 4);
				}
				else
				{
					set_property("choiceAdventure1060", 1);
				}
			}
			else
			{
				set_property("choiceAdventure1060", 2);
			}
		}
		if(item_amount($item[Check to the Meatsmith]) > 0)
		{
			string temp = visit_url("shop.php?whichshop=meatsmith");
			temp = visit_url("choice.php?pwd=&whichchoice=1059&option=2");
			return true;
		}
		if(goal == $location[Madness Bakery])
		{
			if(internalQuestStatus("questM25Armorer") <= 1)
			{
				set_property("choiceAdventure1061", 1);
			}
			else
			{
				set_property("choiceAdventure1061", 5);
			}
		}
		if(item_amount($item[no-handed pie]) > 0)
		{
			string temp = visit_url("shop.php?whichshop=armory");
			temp = visit_url("choice.php?pwd=&whichchoice=1065&option=2");
			return true;
		}
		if(goal == $location[The Overgrown Lot])
		{
			//Meh.
			if(get_property("questM24Doc") != "finished")
			{
				set_property("choiceAdventure1062", 1);
			}
			else
			{
				set_property("choiceAdventure1062", 4);
			}
		}
		if((item_amount($item[Swindleblossom]) >= 3) && (item_amount($item[Fraudwort]) >= 3) && (item_amount($item[Shysterweed]) >= 3))
		{
			string temp = visit_url("shop.php?whichshop=doc");
			temp = visit_url("shop.php?whichshop=doc&action=talk");
			temp = visit_url("choice.php?pwd=&whichchoice=1064&option=2");
			return true;
		}
		if((goal == $location[The Batrat and Ratbat Burrow]) && (internalQuestStatus("questL04Bat") < 1))
		{
			return false;
		}
		if((goal == $location[Cobb\'s Knob Laboratory]) && (item_amount($item[Cobb\'s Knob Lab Key]) == 0))
		{
			return false;
		}

		if (goal == $location[Lair of the Ninja Snowmen] && internalQuestStatus("questL08Trapper") < 2)
		{
			return false;
		}
		if (goal == $location[The VERY Unquiet Garves] && get_property("questL07Cyrptic") != "finished")
		{
			return false;
		}
		if(goal == $location[The Castle in the Clouds in the Sky (Top Floor)])
		{
			if (internalQuestStatus("questL10Garbage") < 9)
			{
				return false;
			}
			if(L10_topFloor() || L10_holeInTheSkyUnlock())
			{
				return true;
			}
		}
		if(goal == $location[Lair of the Ninja Snowmen])
		{
			if((item_amount($item[Ninja Rope]) == 0) || (item_amount($item[Ninja Carabiner]) == 0) || (item_amount($item[Ninja Crampons]) == 0))
			{
				if(L8_trapperNinjaLair())
				{
					return true;
				}
			}
		}

		if((goal == $location[The Red Zeppelin]) && (internalQuestStatus("questL11Ron") < 3))
		{
			return false;
		}
		if (goal == $location[The Hidden Park] && internalQuestStatus("questL11Worship") > 2)
		{
			return false;
		}

		auto_log_info("Not searching for a spoon, not at all...", "green");
		return autoAdv(goal);
	}
	return false;
}

boolean theSource_oracle()
{
	if(my_path() != "The Source")
	{
		return false;
	}

	if(have_skill($skill[Restore]))
	{
		return false;
	}

	if(get_property("sourceOracleTarget").to_location() == $location[none])
	{
		string temp = visit_url("place.php?whichplace=town_wrong&action=townwrong_oracle");
		temp = visit_url("choice.php?pwd=&whichchoice=1190&option=1");

		switch(get_property("sourceOracleTarget").to_location())
		{
		case $location[The Skeleton Store]:			startMeatsmithSubQuest();		break;
		case $location[Madness Bakery]:				startArmorySubQuest();			break;
		case $location[The Overgrown Lot]:			startGalaktikSubQuest();		break;
		}

	}
	else if(item_amount($item[No Spoon]) > 0)
	{
		string temp = visit_url("place.php?whichplace=town_wrong&action=townwrong_oracle");
		temp = visit_url("choice.php?pwd=&whichchoice=1190&option=2");
		return true;
	}

	return false;
}

boolean LX_attemptPowerLevelTheSource()
{
	if(my_path() != "The Source")
	{
		return false;
	}
	if (get_property("lastSecondFloorUnlock").to_int() != my_ascensions())
	{
		return false;
	}

	if(get_property("barrelShrineUnlocked").to_boolean())
	{
		if(cloversAvailable() == 0)
		{
			handleBarrelFullOfBarrels(false);
			string temp = visit_url("barrel.php");
			temp = visit_url("choice.php?whichchoice=1099&pwd=&option=2");
			handleBarrelFullOfBarrels(false);
			return true;
		}
		stat myStat = my_primestat();
		if(my_basestat(myStat) >= 148)
		{
			return false;
		}
		else if(my_basestat(myStat) >= 125)
		{
			//Should probably prefer to check what equipment failures we may be having.
			if((my_basestat($stat[Muscle]) < my_basestat(myStat)) && (my_basestat($stat[Muscle]) < 70))
			{
				myStat = $stat[Muscle];
			}
			if((my_basestat($stat[Mysticality]) < my_basestat(myStat)) && (my_basestat($stat[Mysticality]) < 70))
			{
				myStat = $stat[Mysticality];
			}
			if((my_basestat($stat[Moxie]) < my_basestat(myStat)) && (my_basestat($stat[Moxie]) < 70))
			{
				myStat = $stat[Moxie];
			}
		}
		//Else, default to mainstat.

		//Determine where to go for clover stats, do not worry about clover failures
		location whereTo = $location[none];
		switch(myStat)
		{
			case $stat[Muscle]:			whereTo = $location[The Haunted Gallery];				break;
			case $stat[Mysticality]:	whereTo = $location[The Haunted Bathroom];				break;
			case $stat[Moxie]:			whereTo = $location[The Haunted Ballroom];				break;
		}
		
		if (whereTo == $location[The Haunted Ballroom] && internalQuestStatus("questM21Dance") > 3)
		{
			use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
			LX_spookyBedroomCombat();
			return true;
		}
		if(cloversAvailable() > 0)
		{
			cloverUsageInit();
		}
		autoAdv(1, whereTo);
		cloverUsageFinish();
		return true;
	}
	//Banish mahogant, elegant after gown only. (Harold\'s Bell?)
	return LX_spookyBedroomCombat();
}