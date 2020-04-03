script "auto_mr2014.ash"

#	This is meant for items that have a date of 2014.
#	Handling: Little Geneticist DNA-Splicing Lab, Xi-Receiver Unit
#


boolean dna_bedtime();
boolean dna_sorceressTest();
boolean dna_generic();
boolean dna_startAcquire();
boolean xiblaxian_makeStuff();


//Supplemental




boolean dna_startAcquire()
{
	if(!is_unrestricted($item[Little Geneticist DNA-Splicing Lab]))
	{
		return false;
	}
	if(my_path() == "Community Service")
	{
		return false;
	}
	if((get_property("auto_day1_dna") == "finished") || (my_daycount() != 1))
	{
		return false;
	}
	if(have_effect($effect[Human-Weird Thing Hybrid]) == 2147483647)
	{
		return false;
	}
	if(item_amount($item[DNA Extraction Syringe]) == 0)
	{
		return false;
	}

	if(get_property("dnaSyringe") == $phylum[weird])
	{
		cli_execute("camp dnainject");
	}
	else
	{
		if(!autoForbidFamiliarChange($familiar[Machine Elf]))
		{
			familiar bjorn = my_bjorned_familiar();
			if(bjorn == $familiar[Machine Elf])
			{
				handleBjornify($familiar[Grinning Turtle]);
			}
			handleFamiliar($familiar[Machine Elf]);
			autoAdv(1, $location[The Deep Machine Tunnels]);
			if(bjorn == $familiar[Machine Elf])
			{
				handleBjornify(bjorn);
			}
			cli_execute("camp dnainject");
		}
		else if(elementalPlanes_access($element[sleaze]))
		{
			if($location[Sloppy Seconds Diner].turns_spent == 0)
			{
				autoAdv(1, $location[Sloppy Seconds Diner]);
			}
			autoAdv(1, $location[Sloppy Seconds Diner]);
			cli_execute("camp dnainject");
		}
	}
	set_property("auto_day1_dna", "finished");
	if(have_effect($effect[Human-Weird Thing Hybrid]) != 2147483647)
	{
		auto_log_warning("DNA Hybridization failed, perhaps it was due to ML which is annoying us right now.", "red");
	}
	return true;
}

boolean dna_generic()
{
	if(!is_unrestricted($item[Little Geneticist DNA-Splicing Lab]))
	{
		return false;
	}
	if(get_property("dnaSyringe") == $phylum[none])
	{
		return false;
	}

	boolean[phylum] potion;

	if(auto_my_path() == "Standard")
	{
		switch(my_daycount())
		{
		case 1:			potion = $phylums[construct, construct, humanoid];	break;
		case 2:			potion = $phylums[dude, constellation, humanoid];	break;
		case 3:			potion = $phylums[dude, constellation, plant];		break;
		default:		potion = $phylums[humanoid, construct, dude];		break;
		}
	}
	else if(auto_my_path() == "Heavy Rains")
	{
		switch(my_daycount())
		{
		case 1:			potion = $phylums[construct, construct, fish];		break;
		case 2:			potion = $phylums[fish, constellation, dude];		break;
		case 3:			potion = $phylums[construct, humanoid, dude];		break;
		default:		potion = $phylums[humanoid, construct, dude];		break;
		}
	}
	else if(auto_my_path() == "Community Service")
	{
		switch(my_daycount())
		{
		case 1:			potion = $phylums[beast, pirate, elemental];		break;
		case 2:			potion = $phylums[construct, dude, humanoid];		break;
		default:		potion = $phylums[humanoid, construct, dude];		break;
		}
	}
	else
	{
		switch(my_daycount())
		{
		case 1:			potion = $phylums[construct, construct, fish];		break;
		case 2:			potion = $phylums[fish, constellation, dude];		break;
		case 3:			potion = $phylums[construct, humanoid, dude];		break;
		default:		potion = $phylums[humanoid, construct, dude];		break;
		}
	}

	int i = 0;
	foreach phy in potion
	{
		if((get_property("dnaSyringe") == phy) && (get_property("_dnaPotionsMade").to_int() == i))
		{
			cli_execute("camp dnapotion");
		}
		i = i + 1;
	}


	return false;
}


boolean dna_sorceressTest()
{
	# FIXME: Can we do this earlier? This isn't even all that useful, to be fair.
	# When is the last time we encounter each of these types?
	if(!is_unrestricted($item[Little Geneticist DNA-Splicing Lab]))
	{
		return false;
	}
	if(get_property("dnaSyringe") == $phylum[none])
	{
		return false;
	}
	if(my_level() < 13)
	{
		return false;
	}
	if(get_property("_dnaPotionsMade").to_int() >= 3)
	{
		return false;
	}
	if(get_property("choiceAdventure1003").to_int() < 3)
	{
		return false;
	}
	if((get_property("nsChallenge2") == "") && (get_property("telescopeUpgrades").to_int() >= 2))
	{
		ns_crowd3();
	}

	if((get_property("dnaSyringe") == $phylum[plant]) && (get_property("nsChallenge2") == $element[cold]) && (item_amount($item[Gene Tonic: Plant]) == 0))
	{
		boolean temp = cli_execute("camp dnainject");
	}
	else if((get_property("dnaSyringe") == $phylum[demon]) && (get_property("nsChallenge2") == $element[hot]) && (item_amount($item[Gene Tonic: Demon]) == 0))
	{
		boolean temp = cli_execute("camp dnainject");
	}
	else if((get_property("dnaSyringe") == $phylum[slime]) && (get_property("nsChallenge2") == $element[sleaze]) && (item_amount($item[Gene Tonic: Slime]) == 0))
	{
		boolean temp = cli_execute("camp dnainject");
	}
	else if((get_property("dnaSyringe") == $phylum[undead]) && (get_property("nsChallenge2") == $element[spooky]) && (item_amount($item[Gene Tonic: Undead]) == 0))
	{
		boolean temp = cli_execute("camp dnainject");
	}
	else if((get_property("dnaSyringe") == $phylum[hobo]) && (get_property("nsChallenge2") == $element[stench]) && (item_amount($item[Gene Tonic: Hobo]) == 0))
	{
		boolean temp = cli_execute("camp dnainject");
	}

	return false;
}

boolean dna_bedtime()
{
	if(!is_unrestricted($item[Little Geneticist DNA-Splicing Lab]))
	{
		return false;
	}
	if(get_property("dnaSyringe") == $phylum[none])
	{
		return false;
	}
	if(get_campground() contains $item[Little Geneticist DNA-Splicing Lab])
	{
		int potionsMade = get_property("_dnaPotionsMade").to_int();
		while(potionsMade < 3)
		{
			boolean temp = cli_execute("camp dnapotion");
			potionsMade += 1;
		}
	}
	return false;
}


boolean xiblaxian_makeStuff()
{
	if((my_daycount() >= 2) && possessEquipment($item[Xiblaxian holo-wrist-puter]))
	{
		item toMake = to_item(get_property("auto_xiblaxianChoice"));

		boolean canMake = false;
		if((toMake == $item[Xiblaxian Ultraburrito]) && (fullness_left() >= 4) && (item_amount($item[Xiblaxian Circuitry]) >= 1) && (item_amount($item[Xiblaxian Polymer]) >= 1) && (item_amount($item[Xiblaxian Alloy]) >= 3))
		{
			canMake = true;
		}
		if((toMake == $item[Xiblaxian Space-Whiskey]) && (inebriety_left() >= 4) && (item_amount($item[Xiblaxian Circuitry]) >= 3) && (item_amount($item[Xiblaxian Polymer]) >= 1) && (item_amount($item[Xiblaxian Alloy]) >= 1))
		{
			canMake = true;
		}

		if(!canMake)
		{
			return false;
		}

		if(item_amount(toMake) > 0)
		{
			return false;
		}

		if(item_amount($item[Xiblaxian 5D Printer]) == 0)
		{
			if(item_amount($item[transmission from planet Xi]) > 0)
			{
				use(1, $item[transmission from planet xi]);
				use(1, $item[Xiblaxian Cache Locator Simcode]);
			}
		}

		if(item_amount($item[Xiblaxian 5D Printer]) > 0)
		{
			int[item] canMake = eudora_xiblaxian();
			if((toMake == $item[Xiblaxian Ultraburrito]) && (canMake contains $item[Xiblaxian Ultraburrito]) && (canMake[$item[Xiblaxian Ultraburrito]] > 0))
			{
				visit_url("shop.php?pwd=&whichshop=5dprinter&action=buyitem&quantity=1&whichrow=339", true);
			}
			if((toMake == $item[Xiblaxian Space-Whiskey]) && (canMake contains $item[Xiblaxian Space-Whiskey]) && (canMake[$item[Xiblaxian Space-Whiskey]] > 0))
			{
				visit_url("shop.php?pwd=&whichshop=5dprinter&action=buyitem&quantity=1&whichrow=338", true);
			}
		}
	}
	return false;
}

boolean ornateDowsingRod()
{
	if(!get_property("auto_grimstoneOrnateDowsingRod").to_boolean())
	{
		return false;
	}
	if(!is_unrestricted($item[Grimstone Mask]))
	{
		set_property("auto_grimstoneOrnateDowsingRod", false);
		return false;
	}
	if(possessEquipment($item[UV-resistant compass]))
	{
		auto_log_warning("You have a UV-resistant compass for some raisin, I assume you don't want an Ornate Dowsing Rod.", "red");
		set_property("auto_grimstoneOrnateDowsingRod", false);
		return false;
	}
	if(possessEquipment($item[Ornate Dowsing Rod]))
	{
		auto_log_info("Hey, we have the dowsing rod already, yippie!", "blue");
		set_property("auto_grimstoneOrnateDowsingRod", false);
		return false;
	}
	if(my_adventures() <= 6)
	{
		return false;
	}
	if(item_amount($item[Grimstone Mask]) == 0)
	{
		return false;
	}
	if(my_daycount() < 2)
	{
		return false;
	}
	if(get_counters("", 0, 6) != "")
	{
		return false;
	}

	#Need to make sure we get our grimstone mask
	auto_log_info("Acquiring a Dowsing Rod!", "blue");
	set_property("choiceAdventure829", "1");
	use(1, $item[grimstone mask]);

	set_property("choiceAdventure822", "1");
	set_property("choiceAdventure823", "1");
	set_property("choiceAdventure824", "1");
	set_property("choiceAdventure825", "1");
	set_property("choiceAdventure826", "1");
	while(item_amount($item[odd silver coin]) < 1)
	{
		autoAdv(1, $location[The Prince\'s Balcony]);
	}
	while(item_amount($item[odd silver coin]) < 2)
	{
		autoAdv(1, $location[The Prince\'s Dance Floor]);
	}
	while(item_amount($item[odd silver coin]) < 3)
	{
		autoAdv(1, $location[The Prince\'s Lounge]);
	}
	while(item_amount($item[odd silver coin]) < 4)
	{
		autoAdv(1, $location[The Prince\'s Kitchen]);
	}
	while(item_amount($item[odd silver coin]) < 5)
	{
		autoAdv(1, $location[The Prince\'s Restroom]);
	}

	cli_execute("make ornate dowsing rod");
	set_property("auto_grimstoneOrnateDowsingRod", false);
	set_property("choiceAdventure805", "1");
	return true;
}

boolean fancyOilPainting()
{
	if(get_property("chasmBridgeProgress").to_int() >= 30)
	{
		return false;
	}
	if(my_adventures() <= 4)
	{
		return false;
	}
	if(item_amount($item[Grimstone Mask]) == 0)
	{
		return false;
	}
	if(!get_property("auto_grimstoneFancyOilPainting").to_boolean())
	{
		return false;
	}
	if(get_counters("", 0, 6) != "")
	{
		return false;
	}
	auto_log_info("Acquiring a Fancy Oil Painting!", "blue");
	set_property("choiceAdventure829", "1");
	use(1, $item[grimstone mask]);
	set_property("choiceAdventure823", "1");
	set_property("choiceAdventure824", "1");
	set_property("choiceAdventure825", "1");
	set_property("choiceAdventure826", "1");

	while(item_amount($item[odd silver coin]) < 1)
	{
		autoAdv(1, $location[The Prince\'s Balcony]);
	}
	while(item_amount($item[odd silver coin]) < 2)
	{
		autoAdv(1, $location[The Prince\'s Dance Floor]);
	}
	while(item_amount($item[odd silver coin]) < 3)
	{
		autoAdv(1, $location[The Prince\'s Lounge]);
	}
	while(item_amount($item[odd silver coin]) < 4)
	{
		autoAdv(1, $location[The Prince\'s Kitchen]);
	}
	cli_execute("make fancy oil painting");
	set_property("auto_grimstoneFancyOilPainting", false);
	return true;
}
