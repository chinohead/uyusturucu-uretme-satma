/*

		Uyuşturucu Üretme/Satma Sistemi trf. manhunt
			   25.04.2020, 20:21

*/

#include <a_samp>
#include <zcmd> 					// https://forum.sa-mp.com/showthread.php?t=91354
#include <streamer>					// https://forum.sa-mp.com/showthread.php?t=102865

#define VEHICLE_CAPACITY			(3) 	// 422. satıra bakın
#define VEHICLE_MODEL 				(482) 	// https://wiki.sa-mp.com/wiki/Vehicle_Model_ID_List
#define MAP_ICON_MODEL				(17)	// https://wiki.sa-mp.com/wiki/MapIcons
#define PICKUP_MODEL				(1279)	// https://wiki.sa-mp.com/wiki/Pickup_IDs
#define SKIN_MODEL				(70)	// https://wiki.sa-mp.com/wiki/Skins:All

enum E_METH
{
	Pickup[2],
	Text3D: Label[6],
	Checkpoint,
	MapIcon,
	Vehicle,
	Planted
}
new MethData[E_METH], Text3D: LabelCar[MAX_VEHICLES];

public OnFilterScriptInit()
{
	MethData[Pickup][0] = CreateDynamicPickup(PICKUP_MODEL, 1, 853.0966, -1060.4996, 25.1068, -1, -1, -1, STREAMER_PICKUP_SD, -1, 0);
	MethData[Pickup][1] = CreateDynamicPickup(PICKUP_MODEL, 1, 771.1697,-1109.2479,-43.2600, -1, -1, -1, STREAMER_PICKUP_SD, -1, 0);
	
	MethData[Label][0] = CreateDynamic3DTextLabel("{44bd32}Meth Laboratuvarı\n{ffffff}Giriş", -1, 853.0966, -1060.4996, 25.1068, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
	MethData[Label][1] = CreateDynamic3DTextLabel("{44bd32}Meth Laboratuvarı\n{ffffff}Çıkış", -1, 771.1697,-1109.2479,-43.2600, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
	MethData[Label][2] = CreateDynamic3DTextLabel("{44bd32}Makineyi Kur\n{ffffff}/makinekur\n{00a8ff}Durum: {ffffff}Açık", -1, 763.9513,-1098.7047,-43.2600, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
	MethData[Label][3] = CreateDynamic3DTextLabel("{44bd32}Meth Pişir\n{ffffff}/pisir\n{00a8ff}Durum: {ffffff}Açık", -1, 760.1642,-1103.8280,-43.2600, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
	MethData[Label][4] = CreateDynamic3DTextLabel("{44bd32}Paketle ve Taşı\n{ffffff}/paketle\n{00a8ff}Durum: {ffffff}Boş", -1, 766.5353,-1105.5032,-43.2600, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
	MethData[Label][5] = CreateDynamic3DTextLabel("{44bd32}Lavoratuvar Kıyafeti\n{ffffff}/giyin", -1, 757.1643,-1115.0687,-43.2600, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);

	// https://forum.sa-mp.com/showthread.php?t=653780
	CreateDynamicObject(19907, 763.85, -1107.11, -44.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(19908, 755.16, -1100.17, -41.82, 0.00, 0.00, 0.00);
	CreateDynamicObject(19908, 755.16, -1105.55, -41.82, 0.00, 0.00, 0.00);
	CreateDynamicObject(19355, 770.71, -1122.94, -42.51, 0.00, 0.00, 0.00);
	CreateDynamicObject(19355, 770.71, -1126.14, -42.51, 0.00, 0.00, 0.00);
	CreateDynamicObject(19355, 765.21, -1122.94, -42.51, 0.00, 0.00, 0.00);
	CreateDynamicObject(19355, 765.21, -1126.15, -42.51, 0.00, 0.00, 0.00);
	CreateDynamicObject(19456, 767.49, -1127.58, -42.51, 0.00, 0.00, 270.00);
	CreateDynamicObject(19463, 769.13, -1126.53, -44.35, 0.00, 90.00, 90.00);
	CreateDynamicObject(19463, 769.13, -1123.05, -44.35, 0.00, 90.00, 90.00);
	CreateDynamicObject(1496, 769.35, -1106.30, -44.66, 0.00, 0.00, 0.00);
	CreateDynamicObject(1496, 770.82, -1106.30, -44.66, 0.00, 0.00, 0.00);
	CreateDynamicObject(11729, 770.16, -1107.48, -44.26, 330.00, 0.00, 0.00);
	CreateDynamicObject(1810, 771.05, -1107.18, -44.26, 330.00, 0.00, 0.00);
	CreateDynamicObject(2415, 762.25, -1112.11, -44.45, 0.00, 0.00, 180.00);
	CreateDynamicObject(2146, 768.82, -1103.91, -43.78, 0.00, 0.00, 180.00);
	CreateDynamicObject(2029, 770.10, -1108.10, -44.04, 0.00, 316.00, 90.00);
	CreateDynamicObject(1217, 771.61, -1107.60, -43.84, 0.00, 0.00, 0.00);
	CreateDynamicObject(1217, 769.90, -1109.32, -43.84, 0.00, 0.00, 0.00);
	CreateDynamicObject(3470, 769.49, -1112.42, -40.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(3805, 769.98, -1111.87, -41.84, 0.00, 0.00, 0.00);
	CreateDynamicObject(3813, 755.70, -1110.79, -41.23, 0.00, 0.00, 0.00);
	CreateDynamicObject(14635, 758.31, -1113.45, -42.19, 0.00, 0.00, 270.00);
	CreateDynamicObject(2912, 756.26, -1111.72, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(925, 756.85, -1120.14, -43.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2062, 758.70, -1120.47, -43.69, 0.00, 0.00, 0.00);
	CreateDynamicObject(2062, 758.73, -1119.56, -43.69, 0.00, 0.00, 0.00);
	CreateDynamicObject(930, 756.45, -1118.81, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(930, 756.45, -1118.14, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(930, 756.45, -1117.43, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(930, 756.45, -1116.75, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(925, 760.66, -1120.14, -43.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2921, 769.35, -1110.17, -39.29, 0.00, 0.00, 0.00);
	CreateDynamicObject(16779, 762.45, -1117.10, -40.38, 0.00, 0.00, 0.00);
	CreateDynamicObject(3787, 763.94, -1120.03, -43.70, 0.00, 0.00, 0.00);
	CreateDynamicObject(3787, 763.94, -1120.07, -42.86, 0.00, 0.00, 0.00);
	CreateDynamicObject(3793, 764.08, -1118.86, -43.65, 0.00, 0.00, 0.00);
	CreateDynamicObject(16641, 749.25, -1097.77, -42.76, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1103.27, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1428, 758.85, -1100.21, -42.69, 0.00, 0.00, 90.00);
	CreateDynamicObject(929, 757.53, -1099.61, -41.56, 0.00, 0.00, 0.00);
	CreateDynamicObject(943, 765.59, -1095.36, -43.50, 0.00, 0.00, 0.00);
	CreateDynamicObject(934, 766.03, -1100.52, -42.93, 0.00, 0.00, 0.00);
	CreateDynamicObject(958, 763.06, -1112.27, -43.38, 0.00, 0.00, 0.00);
	CreateDynamicObject(952, 766.36, -1124.08, -43.15, 0.00, 0.00, 0.00);
	CreateDynamicObject(851, 769.11, -1125.97, -43.95, 0.00, 0.00, 0.00);
	CreateDynamicObject(3119, 768.44, -1122.73, -43.96, 0.00, 0.00, 0.00);
	CreateDynamicObject(1442, 769.99, -1122.00, -43.67, 0.00, 0.00, 0.00);
	CreateDynamicObject(1438, 769.39, -1123.77, -44.26, 0.00, 0.00, 18.00);
	CreateDynamicObject(1369, 767.90, -1126.72, -43.64, 0.00, 0.00, 320.00);
	CreateDynamicObject(1355, 768.08, -1125.23, -44.07, 0.00, 0.00, 0.00);
	CreateDynamicObject(1338, 769.09, -1125.86, -43.55, 0.00, 0.00, 0.00);
	CreateDynamicObject(1338, 769.09, -1125.86, -43.55, 0.00, 0.00, 0.00);
	CreateDynamicObject(1264, 768.92, -1124.62, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(1264, 768.84, -1125.72, -42.41, 0.00, 0.00, 0.00);
	CreateDynamicObject(16101, 757.83, -1099.52, -40.62, 0.00, 0.00, 0.00);
	CreateDynamicObject(16101, 757.83, -1100.25, -41.04, 0.00, 0.00, 0.00);
	CreateDynamicObject(18644, 757.80, -1099.72, -40.97, 0.00, 268.00, 148.00);
	CreateDynamicObject(19815, 761.78, -1113.03, -41.73, 0.00, 0.00, 0.00);
	CreateDynamicObject(19816, 761.89, -1111.31, -44.00, 0.00, 0.00, 0.00);
	CreateDynamicObject(14693, 764.73, -1102.59, -43.85, 0.00, 0.00, 0.00);
	CreateDynamicObject(14693, 764.73, -1098.06, -43.85, 0.00, 0.00, 290.00);
	CreateDynamicObject(14693, 764.73, -1098.93, -43.85, 0.00, 0.00, 289.99);
	CreateDynamicObject(19570, 764.52, -1098.07, -43.59, 0.00, 0.00, 0.00);
	CreateDynamicObject(19570, 764.67, -1098.07, -43.59, 0.00, 0.00, 0.00);
	CreateDynamicObject(19573, 764.99, -1099.13, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(19573, 764.99, -1099.27, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(19585, 764.58, -1098.73, -43.43, 0.00, 0.00, 0.00);
	CreateDynamicObject(2847, 768.26, -1120.17, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2146, 768.81, -1098.66, -43.78, 0.00, 0.00, 179.99);
	CreateDynamicObject(2146, 768.81, -1107.77, -43.78, 0.00, 0.00, 179.99);
	CreateDynamicObject(1575, 768.81, -1103.61, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1103.99, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1104.37, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1107.12, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1107.54, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1107.97, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1108.34, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1108.16, -43.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1107.70, -43.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1107.26, -43.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1107.48, -43.12, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 768.81, -1107.92, -43.12, 0.00, 0.00, 0.00);
	CreateDynamicObject(2816, 770.16, -1109.48, -43.03, 0.00, 0.00, 0.00);
	CreateDynamicObject(929, 758.15, -1104.75, -43.30, 0.00, 0.00, 0.00);
	CreateDynamicObject(920, 764.96, -1099.81, -43.78, 0.00, 0.00, 0.00);
	CreateDynamicObject(920, 764.03, -1099.81, -43.78, 0.00, 0.00, 0.00);
	CreateDynamicObject(920, 764.98, -1101.33, -43.78, 0.00, 0.00, 0.00);
	CreateDynamicObject(920, 764.02, -1101.33, -43.78, 0.00, 0.00, 0.00);
	CreateDynamicObject(927, 765.18, -1093.07, -42.38, 0.00, 0.00, 0.00);
	CreateDynamicObject(927, 763.51, -1093.07, -44.15, 0.00, 0.00, 0.00);
	CreateDynamicObject(927, 766.39, -1093.06, -43.23, 0.00, 0.00, 0.00);
	CreateDynamicObject(927, 768.03, -1093.08, -41.36, 0.00, 0.00, 0.00);
	CreateDynamicObject(927, 767.61, -1093.08, -44.05, 0.00, 0.00, 0.00);
	CreateDynamicObject(927, 767.61, -1093.08, -44.82, 0.00, 0.00, 0.00);
	CreateDynamicObject(927, 769.26, -1093.08, -42.18, 0.00, 0.00, 0.00);
	CreateDynamicObject(919, 766.02, -1101.20, -41.72, 0.00, 0.00, 0.00);
	CreateDynamicObject(16101, 766.17, -1101.05, -41.58, 0.00, 0.00, 0.00);
	CreateDynamicObject(16101, 765.68, -1102.65, -37.66, 0.00, 180.00, 0.00);
	CreateDynamicObject(16101, 765.52, -1094.48, -37.66, 0.00, 179.99, 0.00);
	CreateDynamicObject(3643, 757.68, -1090.19, -40.22, 0.00, 0.00, 0.00);
	CreateDynamicObject(919, 758.12, -1095.81, -43.80, 0.00, 0.00, 0.00);
	CreateDynamicObject(919, 758.12, -1094.98, -43.80, 0.00, 0.00, 0.00);
	CreateDynamicObject(919, 757.28, -1094.98, -43.80, 0.00, 0.00, 0.00);
	CreateDynamicObject(919, 757.28, -1095.78, -43.80, 0.00, 0.00, 0.00);
	CreateDynamicObject(3384, 768.60, -1105.84, -42.88, 0.00, 0.00, 0.00);
	CreateDynamicObject(14578, 763.39, -1103.14, -38.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(14578, 775.37, -1106.89, -38.38, 0.00, 0.00, 0.00);
	CreateDynamicObject(14578, 758.30, -1091.60, -38.38, 0.00, 0.00, 270.00);
	CreateDynamicObject(2413, 761.73, -1093.32, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2413, 760.15, -1093.32, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(1950, 759.85, -1093.64, -43.85, 0.00, 0.00, 336.00);
	CreateDynamicObject(1950, 760.09, -1093.64, -43.85, 0.00, 0.00, 243.74);
	CreateDynamicObject(19621, 762.59, -1093.18, -43.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19621, 762.26, -1093.18, -43.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(19621, 761.96, -1093.18, -43.13, 0.00, 0.00, 0.00);
	CreateDynamicObject(3633, 756.28, -1109.19, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(3632, 759.15, -1103.76, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(3633, 760.41, -1111.99, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(2912, 757.24, -1111.72, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2912, 758.15, -1111.72, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2912, 759.14, -1111.72, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2912, 759.14, -1110.50, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2912, 758.15, -1110.50, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2912, 757.24, -1110.50, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2912, 756.26, -1110.50, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(10814, 761.59, -1083.95, -40.33, 0.00, 0.00, 90.00);
	CreateDynamicObject(2146, 767.58, -1105.84, -43.78, 0.00, 0.00, 179.99);
	CreateDynamicObject(1575, 767.69, -1105.08, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1105.52, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1105.86, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1106.30, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1106.70, -43.37, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1106.44, -43.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1106.05, -43.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1105.66, -43.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1105.26, -43.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 767.69, -1105.48, -43.10, 0.00, 0.00, 0.00);
	CreateDynamicObject(2146, 761.39, -1109.83, -43.78, 0.00, 0.00, 110.00);
	CreateDynamicObject(1575, 760.78, -1110.11, -43.42, 0.00, 0.00, 291.00);
	CreateDynamicObject(1575, 761.22, -1109.92, -43.42, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 761.65, -1109.79, -43.42, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 762.06, -1109.65, -43.42, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 761.85, -1109.73, -43.29, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 761.43, -1109.87, -43.29, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 760.98, -1110.07, -43.29, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 761.22, -1109.94, -43.18, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 761.66, -1109.80, -43.18, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 761.44, -1109.90, -43.10, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 761.44, -1109.90, -43.09, 0.00, 0.00, 290.99);
	CreateDynamicObject(14558, 773.15, -1120.24, -44.29, 0.00, 0.00, 270.00);
	CreateDynamicObject(14558, 773.15, -1120.24, -43.97, 0.00, 0.00, 270.00);
	CreateDynamicObject(19873, 768.87, -1104.67, -43.22, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 768.53, -1106.84, -43.22, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 768.83, -1099.72, -43.22, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 768.56, -1099.57, -43.22, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 761.10, -1093.55, -43.16, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 760.95, -1093.55, -43.16, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 760.79, -1093.55, -43.16, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 760.64, -1093.55, -43.16, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 760.73, -1093.55, -43.03, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 760.87, -1093.55, -43.03, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 761.03, -1093.55, -43.03, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 760.95, -1093.55, -42.91, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 760.81, -1093.55, -42.91, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.49, -1093.30, -44.20, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.49, -1093.30, -44.12, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.49, -1093.30, -44.01, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.48, -1093.30, -43.92, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.48, -1093.30, -43.81, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.48, -1093.30, -43.69, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.48, -1093.30, -43.69, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.30, -1093.30, -44.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.30, -1093.30, -44.15, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.30, -1093.30, -44.08, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.30, -1093.30, -43.98, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.30, -1093.30, -43.87, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.30, -1093.30, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(19873, 759.30, -1093.30, -43.68, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1097.78, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1097.95, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1098.14, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1098.25, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1098.44, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1098.60, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1098.76, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1098.94, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1099.08, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1099.29, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.73, -1099.46, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.95, -1099.46, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.95, -1099.26, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.95, -1099.08, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.95, -1098.88, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.95, -1098.72, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.95, -1098.52, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.94, -1098.33, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.94, -1098.15, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.94, -1098.00, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.94, -1097.82, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.53, -1097.87, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.53, -1098.09, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.53, -1098.29, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.53, -1098.45, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.53, -1098.64, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.52, -1098.80, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.52, -1098.95, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.52, -1099.09, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.52, -1099.28, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19874, 768.52, -1099.41, -43.28, 0.00, 0.00, 0.00);
	CreateDynamicObject(19878, 768.74, -1093.61, -44.19, 0.00, 0.00, 330.00);
	CreateDynamicObject(2361, 759.45, -1096.77, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2361, 759.45, -1098.84, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2417, 759.35, -1102.84, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2417, 760.29, -1102.84, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2417, 761.25, -1102.84, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2417, 761.25, -1102.01, -44.26, 0.00, 0.00, 180.00);
	CreateDynamicObject(2417, 760.28, -1102.01, -44.26, 0.00, 0.00, 179.99);
	CreateDynamicObject(2417, 759.36, -1102.01, -44.28, 0.00, 0.00, 179.99);
	CreateDynamicObject(2421, 759.54, -1102.46, -43.34, 0.00, 0.00, 0.00);
	CreateDynamicObject(2190, 760.26, -1093.15, -43.22, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.51, -44.08, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.51, -43.95, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.51, -43.78, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.51, -43.67, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.51, -43.52, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.95, -43.52, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.95, -43.59, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.95, -43.68, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.95, -43.86, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.95, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.95, -43.95, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.94, -44.09, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 759.42, -1096.94, -44.03, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.13, -1096.94, -44.03, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.13, -1096.94, -43.89, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.13, -1096.94, -43.70, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.13, -1096.94, -43.60, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.13, -1096.94, -43.54, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.15, -1096.50, -43.60, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.15, -1096.50, -43.70, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.15, -1096.50, -43.81, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.15, -1096.50, -43.90, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.15, -1096.50, -44.00, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.15, -1096.50, -44.08, 0.00, 0.00, 0.00);
	CreateDynamicObject(1576, 760.15, -1096.50, -44.08, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 759.82, -1098.81, -43.93, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 759.82, -1098.81, -43.74, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 759.82, -1098.81, -43.55, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1112.33, -44.10, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1111.90, -44.10, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1111.43, -44.10, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1111.04, -44.10, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1111.29, -43.90, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1111.71, -43.90, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1112.17, -43.90, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1111.90, -43.73, 0.00, 0.00, 0.00);
	CreateDynamicObject(2060, 764.94, -1111.55, -43.68, 0.00, 0.00, 0.00);
	CreateDynamicObject(2057, 763.54, -1112.38, -42.33, 0.00, 0.00, 0.00);
	CreateDynamicObject(2057, 764.35, -1102.13, -44.09, 0.00, 0.00, 0.00);
	CreateDynamicObject(1218, 765.54, -1103.52, -43.77, 0.00, 0.00, 0.00);
	CreateDynamicObject(1218, 765.54, -1103.52, -43.77, 0.00, 0.00, 0.00);
	CreateDynamicObject(1225, 764.56, -1093.93, -43.89, 0.00, 0.00, 0.00);
	CreateDynamicObject(2780, 758.73, -1101.70, -50.56, 0.00, 0.00, 0.00);
	CreateDynamicObject(3461, 760.92, -1102.26, -45.58, 0.00, 0.00, 0.00);
	CreateDynamicObject(19528, 755.25, -1096.01, -43.07, 0.00, 0.00, 0.00);
	CreateDynamicObject(16101, 760.30, -1102.54, -31.99, 0.00, 179.99, 0.00);
	CreateDynamicObject(16101, 761.25, -1102.54, -31.99, 0.00, 179.99, 0.00);
	CreateDynamicObject(19585, 761.51, -1102.95, -42.96, 0.00, 0.00, 0.00);
	CreateDynamicObject(19584, 760.54, -1102.91, -43.00, 0.00, 0.00, 0.00);
	CreateDynamicObject(19631, 764.62, -1102.55, -43.55, 0.00, 250.00, 0.00);
	CreateDynamicObject(1264, 768.62, -1102.12, -43.79, 0.00, 0.00, 0.00);
	CreateDynamicObject(2675, 770.85, -1109.69, -44.20, 0.00, 0.00, 0.00);
	CreateDynamicObject(1764, 758.25, -1116.48, -44.26, 0.00, 0.00, 52.25);
	CreateDynamicObject(1737, 759.60, -1116.98, -44.59, 0.00, 0.00, 40.00);
	CreateDynamicObject(11729, 755.55, -1114.52, -44.26, 0.00, 0.00, 90.00);
	CreateDynamicObject(11729, 755.55, -1115.21, -44.26, 0.00, 0.00, 90.00);
	CreateDynamicObject(11730, 755.55, -1115.91, -44.26, 0.00, 0.00, 90.00);
	CreateDynamicObject(11735, 756.07, -1115.33, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(11735, 756.20, -1115.70, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(11736, 762.59, -1093.42, -43.67, 0.00, 0.00, 0.00);
	CreateDynamicObject(11736, 762.15, -1093.42, -43.67, 0.00, 0.00, 0.00);
	CreateDynamicObject(11736, 761.69, -1093.42, -43.67, 0.00, 0.00, 0.00);
	CreateDynamicObject(11736, 761.94, -1093.42, -43.63, 0.00, 0.00, 0.00);
	CreateDynamicObject(11736, 762.43, -1093.42, -43.63, 0.00, 0.00, 0.00);
	CreateDynamicObject(11738, 760.92, -1093.48, -43.66, 0.00, 0.00, 0.00);
	CreateDynamicObject(11738, 760.24, -1093.48, -43.66, 0.00, 0.00, 0.00);
	CreateDynamicObject(11748, 761.64, -1109.83, -42.77, 0.00, 0.00, 0.00);
	CreateDynamicObject(1575, 761.55, -1109.80, -42.98, 0.00, 0.00, 290.99);
	CreateDynamicObject(1575, 761.58, -1109.80, -43.09, 0.00, 0.00, 290.99);
	CreateDynamicObject(11750, 760.22, -1104.30, -44.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(11750, 763.65, -1094.97, -44.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(11750, 765.42, -1103.81, -43.04, 0.00, 0.00, 0.00);
	CreateDynamicObject(11750, 759.94, -1102.91, -43.14, 0.00, 0.00, 0.00);
	CreateDynamicObject(11750, 768.59, -1099.74, -43.27, 0.00, 0.00, 0.00);
	CreateDynamicObject(19305, 768.70, -1113.03, -42.70, 0.00, 0.00, 0.00);
	CreateDynamicObject(1567, 765.30, -1112.94, -44.26, 0.00, 0.00, 278.00);
	CreateDynamicObject(1567, 768.43, -1113.00, -44.26, 0.00, 0.00, 138.00);
	CreateDynamicObject(16101, 755.28, -1110.14, -29.67, 0.00, 179.99, 0.00);
	CreateDynamicObject(16101, 755.28, -1111.31, -29.67, 0.00, 179.99, 0.00);
	CreateDynamicObject(16101, 768.67, -1105.81, -30.67, 0.00, 179.99, 0.00);
	CreateDynamicObject(1952, 765.60, -1095.23, -42.71, 0.00, 0.00, 0.00);
	CreateDynamicObject(1953, 759.37, -1101.90, -43.16, 0.00, 0.00, 0.00);
	CreateDynamicObject(1955, 767.66, -1109.81, -42.94, 0.00, 0.00, 0.00);
	CreateDynamicObject(2779, 771.59, -1117.43, -44.26, 0.00, 0.00, 240.00);
	CreateDynamicObject(2778, 771.63, -1115.38, -44.26, 0.00, 0.00, 300.00);
	CreateDynamicObject(962, 761.26, -1100.55, -43.55, 0.00, 0.00, 0.00);
	CreateDynamicObject(3465, 765.17, -1095.56, -43.08, 0.00, 0.00, 0.00);
	CreateDynamicObject(2712, 763.14, -1100.04, -43.69, 0.00, 0.00, 0.00);
	CreateDynamicObject(2711, 761.71, -1102.33, -42.77, 0.00, 0.00, 0.00);
	CreateDynamicObject(2680, 770.77, -1106.51, -43.64, 0.00, 0.00, 0.00);
	CreateDynamicObject(2611, 761.95, -1093.05, -41.90, 0.00, 0.00, 0.00);
	CreateDynamicObject(2612, 760.03, -1093.04, -41.90, 0.00, 0.00, 0.00);
	CreateDynamicObject(1622, 769.35, -1093.84, -39.09, 0.00, 0.00, 0.00);
	CreateDynamicObject(1613, 769.35, -1103.41, -39.63, 0.00, 0.00, 0.00);
	CreateDynamicObject(1614, 769.35, -1108.29, -40.39, 0.00, 0.00, 0.00);
	CreateDynamicObject(1615, 769.35, -1099.27, -41.23, 0.00, 0.00, 0.00);
	CreateDynamicObject(14773, 764.22, -1092.99, -40.68, 0.00, 0.00, 0.00);
	CreateDynamicObject(1886, 759.01, -1093.84, -38.64, 17.25, 359.74, 0.08);
	CreateDynamicObject(1886, 762.01, -1093.84, -38.64, 17.25, 359.74, 0.08);
	CreateDynamicObject(1886, 765.26, -1093.84, -38.64, 17.25, 359.74, 0.08);
	CreateDynamicObject(1886, 768.01, -1093.84, -38.64, 17.25, 359.74, 0.08);
	CreateDynamicObject(1886, 755.76, -1093.84, -38.64, 17.25, 359.74, 0.08);
	CreateDynamicObject(2387, 761.38, -1118.46, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2393, 757.48, -1097.16, -42.65, 0.00, 90.00, 89.50);
	CreateDynamicObject(2393, 757.48, -1097.16, -42.29, 0.00, 90.00, 89.50);
	CreateDynamicObject(2393, 757.48, -1097.16, -41.99, 0.00, 90.00, 89.50);
	CreateDynamicObject(2393, 757.48, -1097.16, -41.66, 0.00, 90.00, 89.50);
	CreateDynamicObject(2393, 757.48, -1097.16, -43.00, 0.00, 90.00, 89.50);
	CreateDynamicObject(2384, 759.67, -1116.89, -43.69, 0.00, 0.00, 0.00);
	CreateDynamicObject(2705, 756.03, -1116.11, -42.65, 0.00, 0.00, 29.25);
	CreateDynamicObject(2845, 759.83, -1115.21, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2846, 756.42, -1115.49, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(1511, 765.44, -1101.95, -42.47, 0.00, 0.00, 0.00);
	CreateDynamicObject(1511, 765.82, -1101.95, -42.49, 0.00, 0.00, 0.00);
	CreateDynamicObject(1518, 760.37, -1116.40, -43.52, 0.00, 0.00, 210.00);
	CreateDynamicObject(1738, 768.92, -1113.37, -43.61, 0.00, 0.00, 0.00);
	CreateDynamicObject(1738, 769.13, -1095.53, -43.61, 0.00, 0.00, 270.00);
	CreateDynamicObject(1778, 761.56, -1103.55, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(1778, 767.92, -1110.91, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(1778, 768.70, -1095.03, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(1780, 764.10, -1114.09, -43.11, 0.00, 0.00, 0.00);
	CreateDynamicObject(2426, 763.24, -1097.85, -43.42, 0.00, 0.00, 0.00);
	CreateDynamicObject(2370, 762.69, -1097.76, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(2683, 763.60, -1096.76, -43.29, 0.00, 0.00, 0.00);
	CreateDynamicObject(2438, 758.08, -1106.95, -42.86, 0.00, 0.00, 0.00);
	CreateDynamicObject(16101, 758.47, -1107.25, -48.22, 0.00, 0.00, 0.00);
	CreateDynamicObject(16101, 758.47, -1106.98, -48.22, 0.00, 0.00, 0.00);
	CreateDynamicObject(2837, 760.96, -1116.61, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(1370, 757.52, -1109.54, -43.72, 0.00, 0.00, 0.00);
	CreateDynamicObject(1370, 758.34, -1109.54, -43.72, 0.00, 0.00, 50.00);
	CreateDynamicObject(1370, 759.24, -1109.54, -43.72, 0.00, 0.25, 240.00);
	CreateDynamicObject(1370, 763.96, -1095.55, -43.60, 0.00, 0.25, 160.00);
	CreateDynamicObject(2978, 763.99, -1095.58, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(19898, 762.12, -1106.00, -44.25, 0.00, 0.00, 0.00);
	CreateDynamicObject(19898, 762.12, -1099.00, -44.25, 0.00, 0.00, 262.00);
	CreateDynamicObject(19898, 768.37, -1101.75, -44.25, 0.00, 0.00, 332.00);
	CreateDynamicObject(19898, 758.12, -1107.00, -44.25, 0.00, 0.00, 332.00);
	CreateDynamicObject(19900, 759.05, -1106.31, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(19899, 755.88, -1104.01, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(19903, 759.17, -1097.83, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(19903, 766.47, -1103.30, -44.26, 0.00, 0.00, 268.75);
	CreateDynamicObject(19942, 764.02, -1112.18, -42.40, 0.00, 0.00, 0.00);
	CreateDynamicObject(19421, 760.10, -1116.91, -43.80, 0.00, 0.00, 0.00);
	CreateDynamicObject(19421, 759.20, -1103.82, -43.31, 0.00, 0.00, 0.00);
	CreateDynamicObject(19487, 755.52, -1115.21, -42.21, 0.00, 0.00, 0.00);
	CreateDynamicObject(2833, 762.70, -1111.29, -44.26, 0.00, 0.00, 0.00);
	CreateDynamicObject(11709, 758.37, -1093.43, -43.58, 0.00, 0.00, 0.00);
	CreateDynamicObject(11709, 756.20, -1093.43, -43.58, 0.00, 0.00, 0.00);
	CreateDynamicObject(19463, 769.13, -1126.53, -40.87, 0.00, 90.00, 90.00);
	CreateDynamicObject(19463, 769.13, -1123.05, -40.87, 0.00, 90.00, 90.00);
	SetObjectMaterial(CreateDynamicObject(19527, 758.09, -1105.21, -43.46, 0.00, 0.00, 0.00), 0, 1676, "wshxrefpump", "metalic128", 0xFFFFFFFF);
	SetObjectMaterial(CreateDynamicObject(19527, 757.64, -1101.61, -41.71, 0.00, 0.00, 0.00), 0, 1676, "wshxrefpump", "metalic128", 0xFFFFFFFF);
	SetObjectMaterial(CreateDynamicObject(19527, 761.23, -1102.38, -43.15, 0.00, 0.00, 0.00), 0, 1676, "wshxrefpump", "metalic128", 0xFFFFFFFF);
	SetObjectMaterial(CreateDynamicObject(19527, 760.30, -1102.43, -43.15, 0.00, 0.00, 0.00), 0, 1676, "wshxrefpump", "metalic128", 0xFFFFFFFF);
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	DeletePVar(playerid, "Packed");
	DeletePVar(playerid, "Cooked");
	DeletePVar(playerid, "Wear");
	DeletePVar(playerid, "VehicleCreated");
	DeletePVar(playerid, "MachineInstalled");
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(pickupid == MethData[Pickup][0])
	{
		SetPlayerPos(playerid, 771.3663,-1111.5791,-43.2600);
	}

	if(pickupid == MethData[Pickup][1])
	{
		SetPlayerPos(playerid, 853.0966+2, -1060.4996, 25.1068);
	}
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == MethData[Checkpoint])
	{
		if(MethData[Planted] == 1)
		{
			GivePlayerMoney(playerid, 5000);
			SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}1 paket uyuşturucu getirerek $5.000 kazandın.");
			DestroyDynamicMapIcon(MethData[MapIcon]);
			MethData[Vehicle] = GetPlayerVehicleID(playerid);
			DestroyVehicle(MethData[Vehicle]);			
			DestroyDynamicCP(MethData[Checkpoint]);
		}
		if(MethData[Planted] == 2)
		{
			GivePlayerMoney(playerid, 10000);
			SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}2 paket uyuşturucu getirerek $10.000 kazandın.");
			DestroyDynamicMapIcon(MethData[MapIcon]);
			MethData[Vehicle] = GetPlayerVehicleID(playerid);
			DestroyVehicle(MethData[Vehicle]);				
			DestroyDynamicCP(MethData[Checkpoint]);
		}
		if(MethData[Planted] == 3)
		{
			GivePlayerMoney(playerid, 15000);
			SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}3 paket uyuşturucu getirerek $15.000 kazandın.");
			DestroyDynamicMapIcon(MethData[MapIcon]);
			MethData[Vehicle] = GetPlayerVehicleID(playerid);
			DestroyVehicle(MethData[Vehicle]);				
			DestroyDynamicCP(MethData[Checkpoint]);
		}
	}
	return 1;
}

CMD:giyin(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 1.0, 757.1643,-1115.0687,-43.2600))
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Bu komutu sadece gardrobun yanında kullanabilirsin.");

	if(GetPVarInt(playerid, "Wear") == 1)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Laboratuvar kıyafetini zaten giymişsin.");

	ApplyAnimation(playerid, "CLOTHES", "CLO_POSE_SHOES", 4.1, 0, 1, 1, 1, 3000, 1);
	GameTextForPlayer(playerid, "kiyafet giyiliyor", 3000, 5);

	SetPlayerSkin(playerid, SKIN_MODEL);

	SetPVarInt(playerid, "Wear", 1);
	return 1;
}

CMD:makinekur(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 1.0, 763.9513,-1098.7047,-43.2600))
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Bu komutu sadece makinenin yanında kullanabilirsin.");

	if(GetPVarInt(playerid, "Wear") == 0)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Laboratuvar kıyafetini giymeden işe başlayamazsın.");

	if(GetPVarInt(playerid, "MachineInstalled") == 1)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Makine zaten kurulmuş.");

	ApplyAnimation(playerid, "BUDDY", "BUDDY_FIRE_POOR", 4.1, 0, 1, 1, 1, 3000, 1);
	GameTextForPlayer(playerid, "makine kuruluyor", 3000, 5);

	UpdateDynamic3DTextLabelText(MethData[Label][2], -1, "{44bd32}Makineyi Kur\n{ffffff}/makinekur\n{FF0000}Durum: {ffffff}Kuruldu");

	SetPVarInt(playerid, "MachineInstalled", 1);
	return 1;
}

CMD:pisir(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 1.0, 760.1642,-1103.8280,-43.2600))
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Bu komutu sadece pişirme ocağının yanında kullanabilirsin.");

	if(GetPVarInt(playerid, "MachineInstalled") == 0)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Makineyi kurmadan meth pişiremezsin.");

	if(GetPVarInt(playerid, "Cooked") == 1)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Meth zaten pişmiş.");

	ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_2IDLE", 4.1, 0, 1, 1, 1, 3000, 1);
	GameTextForPlayer(playerid, "meth pisiriliyor", 3000, 5);

	UpdateDynamic3DTextLabelText(MethData[Label][3], -1, "{44bd32}Meth Pişir\n{ffffff}/pisir\n{FF0000}Durum: {ffffff}Pişirildi");

	SetPVarInt(playerid, "Cooked", 1);
	return 1;
}

CMD:paketle(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 1.0, 766.5353,-1105.5032,-43.2600))
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Bu komutu sadece paketlerin yanında kullanabilirsin.");

	if(GetPVarInt(playerid, "Cooked") == 0)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Methi pişirmeden paketleyemezsin.");

	if(GetPVarInt(playerid, "Packed") == 1)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Meth zaten paketlenmiş.");


	GameTextForPlayer(playerid, "meth paketleniyor", 3000, 5);
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 5000, 1);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid, 0, 1580, 5, 0.101, -0.0, 0.0, 5.50, 90, 90, 1, 1);

	if(GetPVarInt(playerid, "VehicleCreated") == 0)
	{
		SetPVarInt(playerid, "VehicleCreated", 1);
		MethData[Vehicle] = CreateVehicle(VEHICLE_MODEL, 863.8102,-1064.6680,25.1016, 278.9088, 1, 1, 0, 0);
	
		new string[150];
		format(string, sizeof(string), "{00ff00}Paket Aracı\n{ffffff}/aracayukle\n{AAF4C9}KAPASİTE: {ffffff}%d/%d", MethData[Planted], VEHICLE_CAPACITY);
		LabelCar[ MethData[Vehicle] ] = Create3DTextLabel(string, -1, 0.0, 0.0, 0.0, 25.0, 0, 0);
		Attach3DTextLabelToVehicle(LabelCar[ MethData[Vehicle] ], MethData[Vehicle], 0.0, 0.0, 0.0);
	}

	UpdateDynamic3DTextLabelText(MethData[Label][4], -1, "{44bd32}Paketle ve Taşı\n{ffffff}/paketle\n{FF0000}Durum: {ffffff}Paketlendi");
	SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Meth toplandı, dışarı çık ve /aracayukle ile methi yükle.");

	SetPVarInt(playerid, "Packed", 1);
	SetPVarInt(playerid, "MachineInstalled", 0);
	SetPVarInt(playerid, "Cooked", 0);
	return 1;
}

CMD:aracayukle(playerid, params[])
{
	if(MethData[Planted] == VEHICLE_CAPACITY)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Aracın kapasitesi doldu, elindeki methi /methyak ile yakmalısın.");

	if(GetPVarInt(playerid, "Packed") == 0)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Elinde meth yok araca yükleyemezsin.");

	UpdateDynamic3DTextLabelText(MethData[Label][2], -1, "{44bd32}Makineyi Kur\n{ffffff}/makinekur\n{00a8ff}Durum: {ffffff}Kurulabilir");
	UpdateDynamic3DTextLabelText(MethData[Label][3], -1, "{44bd32}Meth Pişir\n{ffffff}/pisir\n{00a8ff}Durum: {ffffff}Pişirilebilir");
	UpdateDynamic3DTextLabelText(MethData[Label][4], -1, "{44bd32}Paketle ve Taşı\n{ffffff}/paketle\n{00a8ff}Durum: {ffffff}Boş");

	MethData[MapIcon] = CreateDynamicMapIcon(1018.5337,-299.8953,73.9931, MAP_ICON_MODEL, -1, -1, -1, -1, 500000, 1, -1, 0);
	MethData[Checkpoint] = CreateDynamicCP(1018.5337,-299.8953,73.9931, 3.0, -1, -1, -1, 100.0);

	SetPVarInt(playerid, "Packed", 0);

	new Float: X, Float: Y, Float: Z;
	GetPlayerPos(playerid, X, Y, Z);

	for(new v = 1; v < MAX_VEHICLES; v++)
	{
		if((MethData[Vehicle] = GetVehicleModel(v)))
		{
			if(MethData[Vehicle] == VEHICLE_MODEL)
			{
				if(GetVehicleDistanceFromPoint(v, X, Y, Z) < 5.0)
				{
					SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Paket araca yüklendi, teslimat bölgesine gidebilirsin.");
					RemovePlayerAttachedObject(playerid, 0);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
					MethData[Planted] += 1;

					new str[244];
					format(str, sizeof(str), "{00ff00}Paket Aracı\n{ffffff}/aracayukle\n{AAF4C9}KAPASİTE: {ffffff}%d/3", MethData[Planted], VEHICLE_CAPACITY);
					Update3DTextLabelText(LabelCar[MethData[Vehicle]], -1, str);
				}
				else
				{
				    SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Aracın yakınında değilsin.");
				}
			}
		}
	}
	return 1;
}

CMD:methyak(playerid, params[])
{
	if(GetPVarInt(playerid, "Packed") == 0)
		return SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Elinde meth yok.");

	RemovePlayerAttachedObject(playerid, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	GivePlayerMoney(playerid, -5000);
	SendClientMessage(playerid, -1, "{42B4A5}[METH] {ffffff}Pişirdiğin methi yaktın ve $5000 kaybettin.");
	return 1;
}
