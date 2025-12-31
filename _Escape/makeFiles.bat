del *.pbo

xcopy "Escape_Master.vr\" "co20_Escape_APEX_NATO_vs_CSAT.Tanoa" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_APEX_CSAT_vs_NATO.Tanoa" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_BIS_CSAT_vs_NATO.Altis" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_BIS_NATO_vs_CSAT.Altis" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_BIS_CSAT_vs_NATO.Stratis" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_BIS_NATO_vs_CSAT.Stratis" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_BIS_CSAT_vs_NATO.Malden" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_BIS_NATO_vs_CSAT.Malden" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_Contact_CSAT_vs_NATO.Enoch" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_Contact_NATO_vs_CSAT.Enoch" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_GM_East_vs_West.gm_weferlingen_summer" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_GM_East_vs_West.gm_weferlingen_winter" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_GM_NATO_vs_CSAT.gm_weferlingen_summer" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_GM_NATO_vs_CSAT.gm_weferlingen_winter" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_GM_West_vs_East.gm_weferlingen_summer" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_GM_West_vs_East.gm_weferlingen_winter" /s /y
xcopy "Escape_Master.vr\" "co20_Escape_GM_East_vs_West.Tanoa" /s /y
xcopy "Escape_Master.vr\" "WS_co20_Escape_NATO_vs_SFIA.SefrouRamal" /s /y
xcopy "Escape_Master.vr\" "WS_co20_Escape_SFIA_vs_NATO.SefrouRamal" /s /y
xcopy "Escape_Master.vr\" "SOG_co20_Escape_SOG_MACV_vs_PAVN.Cam_Lao_Nam" /s /y
xcopy "Escape_Master.vr\" "SOG_co20_Escape_SOG_PAVN_vs_MACV.Cam_Lao_Nam" /s /y
xcopy "Escape_Master.vr\" "SOG_co20_Escape_SOG_MACV_vs_PAVN.vn_khe_sanh" /s /y
xcopy "Escape_Master.vr\" "SOG_co20_Escape_SOG_PAVN_vs_MACV.vn_khe_sanh" /s /y
xcopy "Escape_Master.vr\" "SPE_co20_Escape_SPE_GER_vs_US.SPE_Normandy" /s /y
xcopy "Escape_Master.vr\" "SPE_co20_Escape_SPE_US_vs_GER.SPE_Normandy" /s /y
xcopy "Escape_Master.vr\" "SPE_co20_Escape_SPE_NATO_vs_CSAT.SPE_Normandy" /s /y

"FileBank.exe" "co20_Escape_APEX_NATO_vs_CSAT.Tanoa"
"FileBank.exe" "co20_Escape_APEX_CSAT_vs_NATO.Tanoa"
"FileBank.exe" "co20_Escape_BIS_CSAT_vs_NATO.Altis"
"FileBank.exe" "co20_Escape_BIS_NATO_vs_CSAT.Altis"
"FileBank.exe" "co20_Escape_BIS_CSAT_vs_NATO.Stratis"
"FileBank.exe" "co20_Escape_BIS_NATO_vs_CSAT.Stratis"
"FileBank.exe" "co20_Escape_BIS_CSAT_vs_NATO.Malden"
"FileBank.exe" "co20_Escape_BIS_NATO_vs_CSAT.Malden"
"FileBank.exe" "co20_Escape_Contact_CSAT_vs_NATO.Enoch"
"FileBank.exe" "co20_Escape_Contact_NATO_vs_CSAT.Enoch"
"FileBank.exe" "co20_Escape_GM_East_vs_West.gm_weferlingen_summer"
"FileBank.exe" "co20_Escape_GM_East_vs_West.gm_weferlingen_winter"
"FileBank.exe" "co20_Escape_GM_NATO_vs_CSAT.gm_weferlingen_summer"
"FileBank.exe" "co20_Escape_GM_NATO_vs_CSAT.gm_weferlingen_winter"
"FileBank.exe" "co20_Escape_GM_West_vs_East.gm_weferlingen_summer"
"FileBank.exe" "co20_Escape_GM_West_vs_East.gm_weferlingen_winter"
"FileBank.exe" "co20_Escape_GM_East_vs_West.Tanoa"
"FileBank.exe" "WS_co20_Escape_SFIA_vs_NATO.SefrouRamal"
"FileBank.exe" "WS_co20_Escape_NATO_vs_SFIA.SefrouRamal"
"FileBank.exe" "SOG_co20_Escape_SOG_MACV_vs_PAVN.Cam_Lao_Nam"
"FileBank.exe" "SOG_co20_Escape_SOG_MACV_vs_PAVN.vn_khe_sanh"
"FileBank.exe" "SOG_co20_Escape_SOG_PAVN_vs_MACV.Cam_Lao_Nam"
"FileBank.exe" "SOG_co20_Escape_SOG_PAVN_vs_MACV.vn_khe_sanh"
"FileBank.exe" "SPE_co20_Escape_SPE_GER_vs_US.SPE_Normandy"
"FileBank.exe" "SPE_co20_Escape_SPE_US_vs_GER.SPE_Normandy"
"FileBank.exe" "SPE_co20_Escape_SPE_NATO_vs_CSAT.SPE_Normandy"

SET ver=v51
%ver%
ren "co20_Escape_APEX_NATO_vs_CSAT.Tanoa.pbo" "co 20 Escape APEX NATO vs CSAT %ver%.Tanoa.pbo"
ren "co20_Escape_APEX_CSAT_vs_NATO.Tanoa.pbo" "co 20 Escape APEX CSAT vs NATO %ver%.Tanoa.pbo"
ren "co20_Escape_BIS_CSAT_vs_NATO.Altis.pbo" "co 20 Escape BIS CSAT vs NATO %ver%.Altis.pbo"
ren "co20_Escape_BIS_NATO_vs_CSAT.Altis.pbo" "co 20 Escape BIS NATO vs CSAT %ver%.Altis.pbo"
ren "co20_Escape_BIS_CSAT_vs_NATO.Stratis.pbo" "co 20 Escape BIS CSAT vs NATO %ver%.Stratis.pbo"
ren "co20_Escape_BIS_NATO_vs_CSAT.Stratis.pbo" "co 20 Escape BIS NATO vs CSAT %ver%.Stratis.pbo"
ren "co20_Escape_BIS_CSAT_vs_NATO.Malden.pbo" "co 20 Escape BIS_CSAT vs NATO %ver%.Malden.pbo"
ren "co20_Escape_BIS_NATO_vs_CSAT.Malden.pbo" "co 20 Escape BIS NATO vs CSAT %ver%.Malden.pbo"
ren "co20_Escape_Contact_CSAT_vs_NATO.Enoch.pbo" "co 20 Escape BIS CSAT vs NATO %ver%.Enoch.pbo"
ren "co20_Escape_Contact_NATO_vs_CSAT.Enoch.pbo" "co 20 Escape BIS NATO vs CSAT %ver%.Enoch.pbo"
ren "co20_Escape_GM_East_vs_West.gm_weferlingen_summer.pbo" "GM co 20 Escape East vs West %ver%.gm_weferlingen_summer.pbo"
ren "co20_Escape_GM_East_vs_West.gm_weferlingen_winter.pbo" "GM co 20 Escape East vs West %ver%.gm_weferlingen_winter.pbo"
ren "co20_Escape_GM_NATO_vs_CSAT.gm_weferlingen_summer.pbo" "GM co 20 Escape NATO vs CSAT %ver%.gm_weferlingen_summer.pbo"
ren "co20_Escape_GM_NATO_vs_CSAT.gm_weferlingen_winter.pbo" "GM co 20 Escape NATO vs CSAT %ver%.gm_weferlingen_winter.pbo"
ren "co20_Escape_GM_West_vs_East.gm_weferlingen_summer.pbo" "GM co 20 Escape West vs East %ver%.gm_weferlingen_summer.pbo"
ren "co20_Escape_GM_West_vs_East.gm_weferlingen_winter.pbo" "GM co 20 Escape West vs East %ver%.gm_weferlingen_winter.pbo"
ren "co20_Escape_GM_East_vs_West.Tanoa.pbo" "GM co 20 Escape East vs West %ver%.Tanoa.pbo"
ren "WS_co20_Escape_SFIA_vs_NATO.SefrouRamal.pbo" "WS co 20 Escape SFIA vs NATO %ver%.SefrouRamal.pbo"
ren "WS_co20_Escape_NATO_vs_SFIA.SefrouRamal.pbo" "WS co 20 Escape NATO vs SFIA %ver%.SefrouRamal.pbo"
ren "SOG_co20_Escape_SOG_MACV_vs_PAVN.Cam_Lao_Nam.pbo" "SOG co 20 Escape SOG MACV vs PAVN %ver%.Cam_Lao_Nam.pbo"
ren "SOG_co20_Escape_SOG_MACV_vs_PAVN.vn_khe_sanh.pbo" "SOG co 20 Escape SOG MACV vs PAVN %ver%.vn_khe_sanh.pbo"
ren "SOG_co20_Escape_SOG_PAVN_vs_MACV.Cam_Lao_Nam.pbo" "SOG co 20 Escape SOG PAVN vs MACV %ver%.Cam_Lao_Nam.pbo"
ren "SOG_co20_Escape_SOG_PAVN_vs_MACV.vn_khe_sanh.pbo" "SOG co 20 Escape SOG PAVN vs MACV %ver%.vn_khe_sanh.pbo"
ren "SPE_co20_Escape_SPE_GER_vs_US.SPE_Normandy.pbo" "SPE co 20 Escape SPE GER vs US %ver%.SPE_Normandy.pbo"
ren "SPE_co20_Escape_SPE_US_vs_GER.SPE_Normandy.pbo" "SPE co 20 Escape SPE US vs GER %ver%.SPE_Normandy.pbo"
ren "SPE_co20_Escape_SPE_NATO_vs_CSAT.SPE_Normandy.pbo" "SPE co 20 Escape SPE NATO vs CSAT %ver%.SPE_Normandy.pbo"