//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Arti       //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private [
			"_ArtiSide","_ArtiTyp","_array","_ArtiSets","_set0","_set1",
			"_set2","_set3","_set4","_set5","_set6","_set7","_set8","_set9","_set10","_s"
		];

			_ArtiTyp = _this select 0;_array = [];_s = 0;_set10 = 0;
			_set0 = [];_set1 = [];_set2 = [];_set3 = [];_set4 = [];_set5 = [];_set6 = [];_set7 = [];_set8 = [];_set9 = [];


if(_ArtiTyp == 0) exitWith {};

switch (_ArtiTyp) do
{
//-------------------------------------------------------------------------------------------------------------------------
	case 1:
	{		
		_set0  = [20,2,0,60];
		_set1  = [2,0.1,30,[],3,30];
		_set2  = [85,100,50,400,4,3,0];
		_set3  = [["O_Mortar_01_F",["M_PG_AT"]]];
		_set4  = [5,5,1];
		_set5  = [18,30,1];
		_set6  = [20,50,0];
		_set7  = [0.3,0.7,0];
		_set8  = [];
		_set9  = [];
		_set10 = 15000;
	};
//-------------------------------------------------------------------------------------------------------------------------
	case 2:
	{
		_set0  = [20,2,0,60];
		_set1  = [2,0.1,10,[],3,30];
		_set2  = [100,10,50,500,4,1,0];
		_set3  = [["B_Mortar_01_F",["M_PG_AT"]]];
		_set4  = [5,5,1];
		_set5  = [10,30,1];
		_set6  = [10,30,1];
		_set7  = [0.1,0.5,1];
		_set8  = [];
		_set9  = [];
		_set10 = 15000;
	};
//-------------------------------------------------------------------------------------------------------------------------
	case 3:
	{
		_set0  = [0,0,0,0];
		_set1  = [0,0,0,[],1,5];
		_set2  = [100,0,0,500,4,1,1];
		_set3  = [["B_Mortar_01_F",["M_Mo_82mm_AT_LG"]],["B_MBT_01_arty_F",["R_60mm_HE"]]];
		_set4  = [2,5,0];
		_set5  = [5,10,1];
		_set6  = [5,10,1];
		_set7  = [0.1,1,1];
		_set8  = [];
		_set9  = [];
		_set10 = 1500;
	};
//-------------------------------------------------------------------------------------------------------------------------
	Default {
				if(DAC_Basic_Value != 5) then
				{
					DAC_Basic_Value = 5;publicVariable "DAC_Basic_Value";
					//hintc "Error: DAC_Config_Camps > No valid config number";
					["[x] Error: DAC_Config_Camps > No valid config number"] call BIS_fnc_error;
				};
				if(true) exitWith {};
			};
};

_array = [_set0,_set1,_set2,_set3,_set4,_set5,_set6,_set7,_set8,_set9,_set10];
_array