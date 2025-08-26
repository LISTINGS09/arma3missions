params [["_fileLocation","",[""]]]; 

private _isFile = loadFile _fileLocation;

if !(_isFile isEqualTo "") exitWith {true}; 

false 