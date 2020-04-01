script "auto_glover.ash"


void glover_initializeDay(int day)
{
	if((item_amount($item[Mumming Trunk]) > 0) && !get_property("_mummifyDone").to_boolean())
	{
		mummifyFamiliar($familiar[Disgeist], "myst");
		mummifyFamiliar($familiar[Slimeling], "mpregen");
		mummifyFamiliar($familiar[Intergnat], "item");
		mummifyFamiliar($familiar[Gelatinous Cubeling], "muscle");
		mummifyFamiliar($familiar[God Lobster], "moxie");
		mummifyFamiliar($familiar[Garbage Fire], "meat");
		set_property("_mummifyDone", true);
	}
}

void glover_initializeSettings()
{
	if(auto_my_path() == "G-Lover")
	{
		set_property("auto_getBeehive", true);
		set_property("auto_getBoningKnife", true);
		set_property("auto_dakotaFanning", true);
		set_property("auto_grimstoneOrnateDowsingRod", false);
		set_property("auto_ignoreFlyer", true);
		set_property("gnasirProgress", get_property("gnasirProgress").to_int() | 16);

		//Buy Crude Oil Congealer and um... A-Boo Glues.
		if(item_amount($item[Crude Oil Congealer]) == 0)
		{
			cli_execute("make " + $item[Crude Oil Congealer]);
		}
		while((item_amount($item[A-Boo Glue]) < 3) && (item_amount($item[G]) > 0))
		{
			cli_execute("make " + $item[A-Boo Glue]);
		}

	}
}

boolean glover_usable(string it)
{
	if(auto_my_path() != "G-Lover")
	{
		return true;
	}
	if(contains_text(it, "g"))
	{
		return true;
	}
	if(contains_text(it, "G"))
	{
		return true;
	}
	return false;
}

boolean LM_glover()
{
	if(auto_my_path() != "G-Lover")
	{
		return false;
	}
	foreach it in $items[Chaos Butterfly, Cornucopia, Disassembled Clover, Filthy Poultice, Metal Meteoroid, Oil Of Parrrlay, Pec Oil, Polysniff Perfume, Smut Orc Keepsake Box, Sonar-In-A-Biscuit, T.U.R.D.S. Key, Ten-Leaf Clover, Tonic Djinn, Turtle Wax]
	{
		if(item_amount(it) > 0)
		{
			put_closet(item_amount(it), it);
		}
	}

	if(((my_maxhp() - my_hp()) > 40) && have_skill($skill[Tongue Of The Walrus]) && (my_mp() > 100))
	{
		use_skill(1, $skill[Tongue Of The Walrus]);
	}

	return false;
}
