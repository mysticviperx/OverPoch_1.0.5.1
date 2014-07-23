_tempvar = _this select 0;
bg_engagement = _tempvar;
switch (bg_engagement) do
{
	case "BLUE"    : {TitleText ["Bodyguard Engagement Behavior Set To: Never Fire.", "PLAIN DOWN"];};
	case "GREEN"    : {TitleText ["Bodyguard Engagement Behavior Set To: Passive.", "PLAIN DOWN"];};
	case "WHITE"    : {TitleText ["Bodyguard Engagement Behavior Set To: Defensive.", "PLAIN DOWN"];};
	case "YELLOW"    : {TitleText ["Bodyguard Engagement Behavior Set To: Combat(Keep Formation).", "PLAIN DOWN"];};
	case "RED"    : {TitleText ["Bodyguard Engagement Behavior Set To: Combat(Free Will).", "PLAIN DOWN"];};					
};
