//by Wiggum


private ["_pos","_MainRadius","_MainRadius2","_i"];

_pos = _this select 0;
_MainRadius = _this select 1;
_MainRadius2 = _this select 2;
_color = _this select 3;

_i = 1;

while {_i <= 20} do {

			_Marker = format ["%1%2%3", _pos select 0,_pos select 1,_i];
			_Marker = createMarker [_Marker, [_pos select 0, _pos select 1]];
			_Marker setMarkerShape "ELLIPSE";
			_Marker setMarkerType "Solid";
			_Marker setMarkercolor _color;
			_Marker setMarkerSize [_MainRadius,_MainRadius2];
			_Marker SetMarkerAlpha 0.03;

			//DeleteMarkerArray = DeleteMarkerArray + [_Marker];

_MainRadius = _MainRadius + (_MainRadius * 0.035);
_MainRadius2 = _MainRadius2 + (_MainRadius2 * 0.035);
_i = _i + 1;
};
