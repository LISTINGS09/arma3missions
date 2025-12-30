params ["_newUnit","_oldUnit","_respawn","_respawnDelay"];
// Disable player voice and radio
[player, "NoVoice"] remoteExec ["setSpeaker", -2, player];
showSubtitles false;