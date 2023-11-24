_out = [];
{
    if (_x isKindOf "Man") then {
        _out = _out + [_x];
    } else {
        _out = _out + crew _x;
    };
} forEach _this;
_out