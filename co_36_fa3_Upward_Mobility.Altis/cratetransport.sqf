_this addAction ["Detach Creates", {
                                        {detach _x;} forEach attachedObjects (_this select 0);
                                    },nil,1.5,true,false,"","count attachedObjects _target != 0"];
_this addEventHandler ["Killed", {
                                     {detach _x;} forEach attachedObjects (_this select 0);
                                 }];