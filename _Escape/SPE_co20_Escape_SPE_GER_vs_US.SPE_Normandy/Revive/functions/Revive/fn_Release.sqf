switch (true) do
		{
		case (currentweapon player == ""): {[player,"AmovPknlMstpSnonWnonDnon"] remoteExec ["playmove", 0, false]}; 
		case (currentweapon player == binocular player): {[player,"AmovPknlMstpSoptWbinDnon"] remoteExec ["playmove", 0, false]};
		case (currentweapon player == (primaryweapon player)): {[player,"AmovPknlMstpSrasWrflDnon"] remoteExec ["playmove", 0, false]};
		//case (currentweapon player == (primaryweapon player)): {[player,"AcinPknlMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon"] remoteExec ["playmove", 0, false]};
		case (currentweapon player == (secondaryweapon player)): {[player,"AmovPknlMstpSrasWrflDnon"] remoteExec ["playmove", 0, false]};	
		case (currentweapon player == (handgunweapon player)): {[player,"AmovPknlMstpSrasWpstDnon"] remoteExec ["playmove", 0, false]};	
		};

player setVariable ["AT_Revive_isDragging",objNull,true];