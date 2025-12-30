class CfgFunctions
{
	class A3E
	{
		class Common
		{
			class BootstrapEscape {
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
			};
			class Briefing {};
			class CallRandomFunction {};
			class CheckCampDistance {};
			class FireSmokeFX {};
			class GetEnemyCount{};
			class GetPlayerGroup {};
			class GetPlayers {};
			class GetRandomPlayer {};
			class GetSideColor {};
			class HealAtBuilding {};
			class Hijack {};
			class InitLocalPlayer {};			
			class KeyDown {};
			class RandomPatrolPos {};
			class RandomSpawnPos {};
			class RotatePosition{};
			class WriteParamBriefing {};
			class addUserActions {};
			class cleanupTerrain {};
			class findFlatAreaNear{};
			class findFlatArea{};
			class groupChat {};
			class handleRating {};
			class handleScore {};
			class initArsenal {};
			class initVillageMarkers {};
			class systemChat {};
			class toggleEarplugs {};
		};
		class AI
		{
			class RandomPatrolRoute {};
			class EngageReportedGroup {};
			class InCombat {};
			class Move {};
			class Search {};
			class SearchDrone {};
			class LeafletDrone {};
			class Patrol {};
			class MilitaryTrafficPatrol {};
			class Guard {};
			class GuardBuilding {};
			class Flee {};
			class FireArtillery {};
			class CallCAS {};
			class OrderSearch {};
			class SetTaskState {};
			class GetTaskState {};
			class AquaticPatrol {};
			class AddStaticGunner {};
			class ExtractionBoat {};
			class ExtractionCar {};
			class ExtractionChopper {};
			class SpawnGarisson {};
			class onEnemyDetected {};
			class PatrolBuildings {};
			class MoveInBuilding {};
			class CivilianCommuter {};
			class Stroll {};
			class Occupy {};
			class resumeTask {};
			class SeekShelter {};
		};
		class Garrison
		{
			class GetBuildingPositions {};
			class GetBuildingPositionsInMarker {};
			class GetRndBuilding {};
			class GetRndBuildingPosition {};
			class GetRndBuildingWithPositions {};
			
		};
		class Debug
		{
			class drawMapLine {};
			class TrackGroup {};
			class TrackGroup_Add {};
			class TrackGroup_Update {};
            class DebugMsg {};
			class rptLog {};
			class Log {};
			class logMessage {};
			class startDebugView {};
			class getDebugMessages {};
		};
		class Intel
		{
			class AddIntel {};
			class CollectIntel {};
			class RevealPOI {};
		};
		class Helper
		{
			class GetRandomCirclePosition {};
			class NearestObjectDis {};
			class GetCircularSpawnPos {};
			class RandomMarkerPos {};
			class calcMarkerArea {};
			class getBuildingsInMarker {};
			class getSideColor {};
		};
		class Server
		{
			class initServer {};
			class initPlayer {};
			class watchKnownPosition {};
			class parameterInit {}; 
            class createComCenters {};
            class createMotorPools {};
            class createAmmoDepots {};
			class createMortarSites {};
			class createLocationMarker {};
			class UpdateLocationMarker {};
			class createExtractionPoint {};
			class runExtraction {};
			class runExtractionBoat {};
			class runExtractionCar {};
			class runExtractionHeli {};
			class firedNearExtraction {};
			class weather {};
			class FindSpawnRoad {};
			class EndMissionServer {};
			class SelectExtractionZone {};
			class RoadBlocks {};
			class MissionFlow {};
			class createStartpos {};
			class initTraps {};
			class updateTraps {};
		};
		class Spawning
		{
			class initVillages {};
			class onEnemySoldierSpawn {};
			class onCivilianSpawn {};
			class spawnPatrol {};
			class createObject {};
			class spawnMilitaryVehicle {};
			class spawnCivilianVehicle {};
			class spawnCivilianStroller {};
			class getDynamicSquadsize {};
			class findSpawnPosBuilding {};
			class populateVillageZone {};
			class populateLocationZone {};
			class AmbientPatrols {};
			class MilitaryTraffic {};
			class CivilianCommuters {};
			class onEnemyGroupSpawn {};
			class onCivilianGroupSpawn {};
			class OnVehicleSpawn {};
		};
		class Zones
		{
			class InitZone {};
			class InitLocationZone {};
			class ActivateZone {};
			class DeactivateZone {};
			class SerializeZoneGroups {};
			class DeserializeZoneGroups {};
			
		};
		class Templates
		{
            class BuildPrison {};
			class BuildPrison1 {};
			class BuildPrison2 {};
			class BuildPrison3 {};
			class BuildPrison4 {};
			class BuildPrison5 {};
			class BuildComCenter {};
			class BuildComCenter2 {};
			class BuildComCenter3 {};
			class BuildComCenter4 {};
			class BuildComCenter5 {};
			class BuildComCenter_VN_US1 {};
			class BuildComCenter_VN_US2 {};
			class BuildComCenter_VN_NVA1 {};
			class BuildComCenter_VN_NVA2 {};
            class BuildMotorPool {};
			class BuildMotorPool1 {};
			class BuildMotorPool2 {};
			class BuildMotorPool3 {};
			class BuildMotorPool4 {};
			class BuildMotorPool_VN {};
			class AmmoDepot {};
			class AmmoDepot2 {};
			class AmmoDepot3 {};
			class AmmoDepot4 {};
			class AmmoDepot5 {};
			class AmmoDepot6 {};
			class AmmoDepot7 {};
			class AmmoDepot8 {};
			class AmmoDepot9 {};
			class AmmoDepot10 {};
			class AmmoDepot11 {};
			class AmmoDepot12 {};
			class AmmoDepot_VN_US1 {};
			class AmmoDepot_VN_NVA1 {};
			class CrashSite {};
			class MortarSite {};
			class MortarSite2 {};
			class MortarSite3 {};
			class MortarSite4 {};
			class MortarSite5 {};
			class MortarSite6 {};
			class MortarSite_VN_US1 {};
			class MortarSite_VN_NVA1 {};
			class Roadblock {};
			class Roadblock2 {};
			class Roadblock3 {};
			class Roadblock4 {};
			class Roadblock5 {};
			class Roadblock6 {};
			class Roadblock7 {};
			class Roadblock8 {};
			class Roadblock9 {};
			class Roadblock10 {};
			class Roadblock_VN1 {};
			class Roadblock_VN2 {};	
		};
		class Chronos
		{
			class Chronos_Init {
				 postInit = 1;
			};
			class Chronos_Run {};
			class Chronos_Register {};
			class Chronos_Dispatch {};
		};
		class Statistics
		{
			class StartStatistics {};
			class LoadStatistics {};
			class WriteStatisticsToBriefing {};
			class SaveStatistics {};
			class ParseStatistics {};
			class PingStatistics {};
		};
		class Searchleader
		{
			class PlayerDetection {};
			class recordSighting {};
			class ReportToHQ {};
			class SearchLeader {};
			class SearchLeaderInit {};
			class SearchLeaderRadio {};
			class CreateKnownPosition {};
			class onPlayerSpotted {};
			
		};
	};
	class drn
	{
		class DRN
		{
			class AmbientInfantry {}; 
			class MoveInfantryGroup {}; 
			class MonitorEmptyGroups {};
			class PopulateLocation {};
			class DepopulateLocation {};
			class InitGuardedLocations {};
			class InsertionTruck {};
			class MilitaryTraffic {};
			class MoveVehicle {};
			class MotorizedSearchGroup {};	
			class SearchChopper {};
			class SearchGroup {};
			class PopulateAquaticPatrol {};
			class DepopulateAquaticPatrol {};
			class InitAquaticPatrolMarkers {};
			class InitAquaticPatrols {};
			class GarrisonUnits {};
		};
	};
	class ATR
	{
		class Revive
		{
#ifndef A3E_EDITOR
			file = "Revive\functions\revive";
			#include "..\Revive\functions\revive\revive.hpp"
#endif
		};
	};
	class ATHSC
	{
		class HSC
		{
#ifndef A3E_EDITOR
			file = "Revive\functions\HSC";
			#include "..\Revive\functions\HSC\hsc.hpp"
#endif
		};
	};
	class ace
	{
		class ace
		{
			class HandleUnconscious {};
			class ATCam {};
			class CaptiveHandle {};
			class GroundHandler {};
		};
	};
	class f
	{
		class zeus
		{
			class zeusJoin {
				file = "f\misc\f_zeusJoin.sqf";
				postInit = 1;
			};
		};
	};
};
