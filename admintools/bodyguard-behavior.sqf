_tempvar = _this select 0;
bg_behavior = _tempvar;
switch (bg_behavior) do
{
	case "CARELESS"    : {TitleText ["Bodyguard Stance Behavior Set To: Careless.", "PLAIN DOWN"];};
	case "COMBAT"    : {TitleText ["Bodyguard Stance Behavior Set To: Kneel When Possible.", "PLAIN DOWN"];};
	case "STEALTH"    : {TitleText ["Bodyguard Stance Behavior Set To: Prone When Possible.", "PLAIN DOWN"];};
};
