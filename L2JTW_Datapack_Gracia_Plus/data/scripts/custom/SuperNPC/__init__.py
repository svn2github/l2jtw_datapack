# Created by rocknow
import sys
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.gameserver.model.base            import Experience
from com.l2jserver.gameserver.datatables            import SkillTable
from com.l2jserver.gameserver.datatables            import SpawnTable
from com.l2jserver.gameserver.datatables            import MessageTable
from com.l2jserver.gameserver.network               import SystemMessageId
from com.l2jserver.gameserver.network.serverpackets import MagicSkillUse
from com.l2jserver.gameserver.network.serverpackets import SystemMessage
from com.l2jserver.util                             import Rnd

qn = "SuperNPC"

BUFF={
"1032":[1032,3,100],
"1033":[1033,3,100],
"1035":[1035,4,100],
"1044":[1044,3,100],
"1078":[1078,6,100],
"1243":[1243,6,100],
"1259":[1259,4,100],
"1304":[1304,3,100],
"7041":[7041,1,100],
"7042":[7042,1,100],
"7043":[7043,1,100],
"7044":[7044,1,100],
"7045":[7045,1,100],
"7046":[7046,1,100],
"7047":[7047,1,100],
"7048":[7048,1,100],
"7049":[7049,1,100],
"7050":[7050,1,100],
"7051":[7051,1,100],
"7052":[7052,1,100],
"7053":[7053,1,100],
"7054":[7054,1,100],
"7055":[7055,1,100],
"7056":[7056,1,100],
"7057":[7057,1,100],
"7058":[7058,1,100],
"7059":[7059,1,100],
"7060":[7060,1,100],
"7061":[7061,1,100],
"7062":[7062,1,100],
"7063":[7063,1,100],
"7064":[7064,1,100],
"AEND":[1409,1,0],
}

BUFF_DS={
"264":[264,1,1000],
"266":[266,1,1000],
"267":[267,1,1000],
"268":[268,1,1000],
"269":[269,1,1000],
"271":[271,1,1000],
"272":[272,1,1000],
"273":[273,1,1000],
"274":[274,1,1000],
"275":[275,1,1000],
"276":[276,1,1000],
"310":[310,1,1000],
}

BUFF2={
"1182":[1182,3,100],
"1189":[1189,3,100],
"1191":[1191,3,100],
"1352":[1352,1,100],
"1353":[1353,1,100],
"1354":[1354,1,100],
"1392":[1392,3,100],
"1393":[1393,3,100],
"AEND2":[1409,1,0],
}

BUFF2_DS={
"277":[277,1,1000],
"306":[306,1,1000],
"307":[307,1,1000],
"308":[308,1,1000],
"309":[309,1,1000],
"311":[311,1,1000],
"529":[529,1,1000],
}

BUFF3={
"P1044":[1044,3,0],
"P7041":[7041,1,1000],
"P7042":[7042,1,1000],
"P7043":[7043,1,1000],
"P7044":[7044,1,1000],
"P7045":[7045,1,1000],
"P7046":[7046,1,1000],
"P7047":[7047,1,1000],
"P7048":[7048,1,1000],
"P7050":[7050,1,1000],
"P7051":[7051,1,1000],
"P7052":[7052,1,1000],
"P7053":[7053,1,1000],
"P7054":[7054,1,1000],
"P7055":[7055,1,1000],
"P7056":[7056,1,1000],
"P7057":[7057,1,1000],
"P7058":[7058,1,1000],
"P7059":[7059,1,1000],
"P7061":[7061,1,1000],
"P7062":[7062,1,1000],
"P7063":[7063,1,1000],
"P7064":[7064,1,1000],
}

BUFFA1={
"A001":["A1044",30000],
"A002":["A269",20000],
"A003":["A273",10000],
"A004":["A1354",30000],
}

BUFFA2={
"A1044":[1044,3,"A266"],
"A266":[266,1,"A267"],
"A267":[267,1,"A264"],
"A264":[264,1,"A268"],
"A268":[268,1,"A272"],
"A272":[272,1,"A7047"],
"A7047":[7047,1,"A7044"],
"A7044":[7044,1,"A7046"],
"A7046":[7046,1,"A7045"],
"A7045":[7045,1,"A7051"],
"A7051":[7051,1,"A7052"],
"A7052":[7052,1,"A7055"],
"A7055":[7055,1,"A7056"],
"A7056":[7056,1,"A7048"],
"A7048":[7048,1,"A7060"],
"A7060":[7060,1,"AEND"],
"A269":[269,1,"A310"],
"A310":[310,1,"A275"],
"A275":[275,1,"A274"],
"A274":[274,1,"A271"],
"A271":[271,1,"A7053"],
"A7053":[7053,1,"A7042"],
"A7042":[7042,1,"A7041"],
"A7041":[7041,1,"A7043"],
"A7043":[7043,1,"A7050"],
"A7050":[7050,1,"A7063"],
"A7063":[7063,1,"A7057"],
"A7057":[7057,1,"AEND"],
"A273":[273,1,"A276"],
"A276":[276,1,"A7059"],
"A7059":[7059,1,"A7054"],
"A7054":[7054,1,"A7062"],
"A7062":[7062,1,"A7058"],
"A7058":[7058,1,"A1078"],
"A1078":[1078,6,"AEND"],
"A1354":[1354,1,"A1352"],
"A1352":[1352,1,"A1353"],
"A1353":[1353,1,"A1393"],
"A1393":[1393,3,"A1392"],
"A1392":[1392,3,"A1189"],
"A1189":[1189,3,"A1182"],
"A1182":[1182,3,"A1191"],
"A1191":[1191,3,"AEND2"],
}

BUFFB1={
"A005":["AP7046",50000],
}

BUFFB2={
"AP7046":[7046,1,"AP7045"],
"AP7045":[7045,1,"AP7059"],
"AP7059":[7059,1,"AP7054"],
"AP7054":[7054,1,"AP7053"],
"AP7053":[7053,1,"AP7042"],
"AP7042":[7042,1,"AP7041"],
"AP7041":[7041,1,"AP7043"],
"AP7043":[7043,1,"AP7047"],
"AP7047":[7047,1,"AP1044"],
"AP1044":[1044,3,"AP7051"],
"AP7051":[7051,1,"AP7050"],
"AP7050":[7050,1,"AP7052"],
"AP7052":[7052,1,"AP7055"],
"AP7055":[7055,1,"AP7056"],
"AP7056":[7056,1,"AP7048"],
"AP7048":[7048,1,"AP7063"],
"AP7063":[7063,1,"AP7057"],
"AP7057":[7057,1,"AP7044"],
"AP7044":[7044,1,"P1044"],
}

COLOR1={
"CON01":[0xFFFFFF,200000],
"CON02":[0x5500FF,200000],
"CON03":[0xFF00FF,200000],
"CON04":[0x0077FF,200000],
"CON05":[0x00FFFF,200000],
"CON06":[0x55FF99,200000],
"CON07":[0x008800,200000],
"CON08":[0xFFFF00,200000],
"CON09":[0xFF6600,200000],
"CON10":[0xFF0000,200000],
}

COLOR2={
"COT01":[0xFFFFFF,200000],
"COT02":[0x5500FF,200000],
"COT03":[0xFF00FF,200000],
"COT04":[0x0077FF,200000],
"COT05":[0x00FFFF,200000],
"COT06":[0x55FF99,200000],
"COT07":[0x008800,200000],
"COT08":[0xFFFF00,200000],
"COT09":[0xFF6600,200000],
"COT10":[0xFF0000,200000],
}

COLOR3={
"COA01":[0xFFFFFF,200000],
"COA02":[0x5500FF,200000],
"COA03":[0xFF00FF,200000],
"COA04":[0x0077FF,200000],
"COA05":[0x00FFFF,200000],
"COA06":[0x55FF99,200000],
"COA07":[0x008800,200000],
"COA08":[0xFFFF00,200000],
"COA09":[0xFF6600,200000],
"COA10":[0xFF0000,200000],
}

TELE={
"TELE_13":[-16730,209417,-3664,1000],
"TELE_17":[169008,-208272,-3504,1000],
"TELE_28":[105918,109759,-3207,1000],
"TELE_45":[105918,109759,-3207,1000],
"TELE_48":[85348,16142,-3699,1000],
"TELE_49":[116819,76994,-2714,1000],
"TELE_50":[105918,109759,-3207,1000],
"TELE_60":[47942,186764,-3485,1000],
"TELE_66":[82684,183551,-3597,1000],
"TELE_67":[91186,217104,-3649,1000],
"TELE_68":[115583,192261,-3488,1000],
"TELE_69":[73024,118485,-3688,1000],
"TELE_76":[146440,46723,-3432,1000],
"TELE_81":[155310,-16339,-3320,1000],
"TELE_84":[168217,37990,-4072,1000],
"TELE_86":[46467,126885,-3720,1000],
"TELE_87":[20505,189036,-3344,1000],
"TELE_88":[-23789,169683,-3424,1000],
"TELE_90":[-46932,140883,-2936,1000],
"TELE_91":[-70387,115501,-3472,1000],
"TELE_92":[-45210,202654,-3592,1000],
"TELE_93":[-8804,-114748,-3088,1000],
"TELE_94":[-17870,-90980,-2528,1000],
"TELE_96":[7603,-138871,-920,1000],
"TELE_97":[87252,85514,-3056,1000],
"TELE_98":[64328,26803,-3768,1000],
"TELE_99":[104426,33746,-3800,1000],
"TELE_100":[124904,61992,-3920,1000],
"TELE_101":[142065,81300,-3000,1000],
"TELE_109":[125543,-40953,-3724,1000],
"TELE_110":[146954,-67390,-3660,1000],
"TELE_124":[52112,-53939,-3159,1000],
"TELE_125":[70006,-49902,-3251,1000],
"TELE_136":[47942,186764,-3485,1000],
"TELE_418":[139714,-177456,-1536,1000],
"TELE_419":[171946,-173352,3448,1000],
"TELE_464":[-22224,14168,-3232,1000],
"TELE_465":[-56532,78321,-2960,1000],
"TELE_466":[-30777,49750,-3552,1000],
"TELE_467":[-23520,68688,-3640,1000],
"TELE_468":[21362,51122,-3688,1000],
"TELE_470":[29294,74968,-3776,1000],
"TELE_471":[9340,-112509,-2536,1000],
"TELE_1001":[-99678,237562,-3567,1000],
"TELE_1002":[-101294,212553,-3093,1000],
"TELE_1003":[-113329,235327,-3653,1000],
"TELE_1004":[-107456,242669,-3493,1000],
"TELE_1013":[-10674,75550,-3597,1000],
"TELE_1022":[136910,-205082,-3664,1000],
"TELE_1029":[-68628,162336,-3592,1000],
"TELE_1030":[-52841,190730,-3518,1000],
"TELE_1031":[-9993,176457,-4182,1000],
"TELE_1032":[-42256,198333,-2800,1000],
"TELE_1042":[-42504,120046,-3519,1000],
"TELE_1043":[-20057,137618,-3897,1000],
"TELE_1044":[-89839,105362,-3580,1000],
"TELE_1051":[5106,126916,-3664,1000],
"TELE_1052":[17192,114178,-3439,1000],
"TELE_1053":[630,179184,-3720,1000],
"TELE_1054":[58316,163851,-2816,1000],
"TELE_1060":[132828,114421,-3725,1000],
"TELE_1061":[43408,206881,-3752,1000],
"TELE_1062":[79798,130624,-3677,1000],
"TELE_1069":[86006,231069,-3600,1000],
"TELE_1076":[82764,61145,-3502,1000],
"TELE_1077":[85995,-2433,-3528,1000],
"TELE_1083":[184742,19745,-3168,1000],
"TELE_1084":[142065,81300,-3000,1000],
"TELE_1085":[183543,-14974,-2776,1000],
"TELE_1086":[106517,-2871,-3416,1000],
"TELE_1087":[170838,55776,-5280,1000],
"TELE_1088":[114649,11115,-5120,1000],
"TELE_1095":[149594,-112698,-2065,1000],
"TELE_1096":[165054,-47861,-3560,1000],
"TELE_1097":[106414,-87799,-2920,1000],
"TELE_1103":[57059,-82976,-2847,1000],
"TELE_1104":[67992,-72012,-3748,1000],
"TELE_1105":[123743,-75032,-2902,1000],
"TELE_1116":[68693,-110438,-1904,1000],
"TELE_1117":[111965,-154172,-1528,1000],
"TELE_1118":[113903,-108752,-848,1000],
"TELE_1119":[47692,-115745,-3744,1000],
"TELE_1120":[91280,-117152,-3928,1000],
"TELE_1121":[-88525,83379,-2864,1000],
"TELE_1128":[-122410,73205,-2872,1000],
"TELE_1129":[-95540,52150,-2024,1000],
"TELE_1130":[-85928,37095,-2048,1000],
"TELE_1131":[-74016,51932,-3680,1000],
"TELE_1132":[-149365,255309,-86,1000],
"TELE_1133":[-186594,243643,2612,1000],
"TELE_1134":[-184258,243061,1576,1000],
"TELE_9000":[46094,41288,-3509,5000],
"TELE_9001":[-73145,256520,-3126,5000],
"TELE_9002":[-88406,249168,-3576,5000],
"TELE_9003":[-96041,261133,-3483,5000],
"TELE_9004":[51746,71559,-3427,5000],
"TELE_9005":[-45563,73216,-3575,5000],
"TELE_9006":[-5162,55702,-3483,5000],
"TELE_9008":[-47129,59678,-3336,5000],
"TELE_9009":[23965,10989,-3723,5000],
"TELE_9010":[-37814,65734,-3353,5000],
"TELE_9110":[26174,-17134,-2747,5000],
"TELE_9011":[20385,7420,-3577,5000],
"TELE_9012":[124585,-160240,-1180,5000],
"TELE_9013":[155535,-173560,2495,5000],
"TELE_9014":[152375,-179887,849,5000],
"TELE_9015":[139783,-177260,-1539,5000],
"TELE_9016":[153951,-189072,-2892,5000],
"TELE_9017":[113859,-171223,-168,5000],
"TELE_9018":[115963,-175409,-1001,5000],
"TELE_9019":[108467,-174137,-401,5000],
"TELE_9020":[-37955,-100767,-3774,5000],
"TELE_9021":[23006,-126115,-870,5000],
"TELE_9022":[-40929,-108285,-1767,5000],
"TELE_9023":[-19299,-127960,-2158,5000],
"TELE_9024":[-56623,-113613,-688,5000],
"TELE_9025":[-84757,60009,-2581,5000],
"TELE_9026":[-86976,43251,-2684,5000],
"TELE_9027":[-112792,68617,-3007,5000],
"TELE_9028":[-125552,38105,1187,5000],
"TELE_9029":[-99673,39812,-2251,5000],
"TELE_9030":[-66931,120296,-3651,5000],
"TELE_9031":[-89199,149962,-3586,5000],
"TELE_9032":[-16730,209417,-3664,5000],
"TELE_9033":[-23403,186599,-4317,5000],
"TELE_9034":[-60586,122251,-2941,5000],
"TELE_9035":[-7785,204828,-3718,5000],
"TELE_9036":[-43448,129317,-2766,5000],
"TELE_9037":[-27643,108735,-3717,5000],
"TELE_9038":[-309,100258,-3672,5000],
"TELE_9039":[17724,114004,-11672,10000],
"TELE_9040":[17730,108301,-9057,20000],
"TELE_9041":[17719,115430,-6582,30000],
"TELE_9042":[30777,140179,-2965,5000],
"TELE_9043":[17144,170156,-3497,5000],
"TELE_9044":[16658,154580,-3478,5000],
"TELE_9045":[51055,141959,-2869,5000],
"TELE_9046":[70000,126636,-3804,5000],
"TELE_9047":[41298,200350,-4583,5000],
"TELE_9048":[107051,132772,-3527,5000],
"TELE_9049":[85170,241576,-6848,5000],
"TELE_9050":[85531,256976,-11671,5000],
"TELE_9051":[82586,252206,-7714,5000],
"TELE_9052":[159111,183721,-3720,50000],
"TELE_9053":[149361,172327,-945,50000],
"TELE_9054":[152857,149040,-3280,50000],
"TELE_9055":[-11802,236360,-3271,100000],
"TELE_9056":[-59047,-56894,-2039,1000],
"TELE_9057":[113995,198959,-3742,5000],
"TELE_9058":[82662,-15977,-1893,5000],
"TELE_9059":[94945,8138,-3159,5000],
"TELE_9060":[68703,68640,-3630,5000],
"TELE_9061":[165584,85997,-2338,5000],
"TELE_9062":[109699,-7908,-2902,5000],
"TELE_9063":[114172,-18034,-1875,5000],
"TELE_9064":[172136,20325,-3326,10000],
"TELE_9065":[174528,52683,-4369,10000],
"TELE_9066":[147475,19775,-2005,5000],
"TELE_9067":[178283,-15739,-2262,5000],
"TELE_9068":[114665,12697,-3609,20000],
"TELE_9069":[111249,16031,-2127,30000],
"TELE_9070":[114605,19371,-645,40000],
"TELE_9071":[114097,19935,935,50000],
"TELE_9072":[114743,19707,1947,60000],
"TELE_9073":[114552,12354,2957,70000],
"TELE_9074":[110963,16147,3967,80000],
"TELE_9075":[117356,18462,4977,90000],
"TELE_9076":[118250,15858,5897,100000],
"TELE_9077":[115824,17242,6760,110000],
"TELE_9078":[113288,14692,7997,120000],
"TELE_9079":[115322,16756,9007,800000],
"TELE_9080":[112787,14158,10077,900000],
"TELE_9081":[141792,59794,-3485,5000],
"TELE_9082":[135998,16312,-3690,5000],
"TELE_9083":[161742,17386,-3648,5000],
"TELE_9084":[141377,-123793,-1906,5000],
"TELE_9085":[170723,-116207,-2067,50000],
"TELE_9086":[188191,-74959,-2738,50000],
"TELE_9087":[178293,-83983,-7209,50000],
"TELE_9088":[168505,-86606,-2992,50000],
#"TELE_9090":[136137,57323,-2849,5000],
"TELE_9090":[133205,-60392,-2969,5000],
"TELE_9091":[193991,-60215,-2934,5000],
"TELE_9092":[69762,-111260,-1807,5000],
"TELE_9093":[48336,-107734,-1577,5000],
"TELE_9094":[108090,-120925,-3628,5000],
"TELE_9095":[109060,-128655,-3084,5000],
"TELE_9096":[113487,-109888,-865,5000],
"TELE_9097":[87475,-109835,-3330,5000],
"TELE_9098":[117715,-141750,-2700,5000],
"TELE_9099":[58000,-30767,380,5000],
"TELE_9100":[57849,-93182,-1360,5000],
"TELE_9101":[93078,-58289,-2854,5000],
"TELE_9102":[89880,-44515,-2135,5000],
"TELE_9103":[38015,-38305,-3609,5000],
"TELE_9104":[67992,-72012,-3748,5000],
"TELE_9105":[80471,-84022,-3646,5000],
"TELE_9106":[80471,-84022,-3646,5000],
"TELE_9107":[91840,-86269,-2703,5000],
"TELE_9108":[40723,-92245,-3747,5000],
"TELE_9109":[59425,-47753,-2562,5000],
"TELE_9111":[8264,-14431,-3696,5000],
"TELE_9112":[6229,-2924,-2965,5000],
"TELE_9113":[26174,-17134,-2747,5000],
"TELE_9114":[10468,-24569,-3650,5000],
"TELE_9115":[8264,-14431,-3696,5000],
"TELE_9116":[6229,-2924,-2965,5000],
"TELE_9201":[-83941,243382,-3729,5000],
"TELE_9202":[45873,49288,-3064,5000],
"TELE_9203":[12428,16551,-4588,5000],
"TELE_9204":[115339,-178178,-929,5000],
"TELE_9205":[-44133,-113911,-244,5000],
"TELE_9206":[-116934,46616,368,5000],
"TELE_9207":[-83063,150791,-3133,5000],
"TELE_9208":[-14225,123540,-3121,5000],
"TELE_9209":[18748,145437,-3132,5000],
"TELE_9210":[82698,148638,-3473,5000],
"TELE_9211":[111115,219017,-3547,5000],
"TELE_9212":[82761,53574,-1496,5000],
"TELE_9213":[116589,76268,-2734,5000],
"TELE_9214":[147422,27393,-2208,5000],
"TELE_9215":[147725,-56517,-2780,5000],
"TELE_9216":[87358,-141982,-1341,5000],
"TELE_9217":[43802,-48110,-797,5000],
"TELE_9218":[-18361,113887,-2767,5000],
"TELE_9219":[22306,156027,-2953,5000],
"TELE_9220":[112122,144855,-2751,5000],
"TELE_9221":[147457,10843,-736,5000],
"TELE_9222":[116265,244631,-1057,5000],
"TELE_9223":[78116,36961,-2458,5000],
"TELE_9224":[147482,-45026,-2084,5000],
"TELE_9225":[77540,-149114,-352,5000],
"TELE_9226":[19118,-49136,-1266,5000],
"TELE_9231":[12312,182752,-3558,5000],
"TELE_9232":[73890,142656,-3778,5000],
"TELE_9233":[-86979,142402,-3643,5000],
"TELE_9234":[152180,-126093,-2282,5000],
"TELE_9241":[-79582,111360,-4899,5000],
"TELE_9242":[-80545,86525,-5155,5000],
"TELE_9243":[-20706,13484,-4901,50000],
"TELE_9244":[112893,84529,-6541,50000],
"TELE_9245":[139339,79682,-5429,50000],
"TELE_9246":[76549,78429,-5124,50000],
"TELE_9247":[44953,170285,-4981,50000],
"TELE_9248":[41933,143919,-5381,50000],
"TELE_9249":[81977,209219,-5439,50000],
"TELE_9250":[171379,-17603,-4901,50000],
"TELE_9251":[117080,132777,-4831,50000],
"TELE_9252":[-53166,79106,-4741,50000],
"TELE_9253":[-22889,77352,-5173,50000],
"TELE_9254":[110016,174008,-5439,50000],
"TELE_9255":[45269,125019,-5413,50000],
"TELE_9256":[-41565,208737,-5087,50000],
"TELE_9257":[-213401,210401,4408,10000],
"TELE_9258":[-183321,205994,-12896,10000],
"TELE_9260":[-247746,251079,4328,10000],
"TELE_9261":[-245833,220174,-12104,10000],
"TELE_9262":[-251624,213420,-12072,10000],
"TELE_9263":[-249774,207316,-11952,10000],
"TELE_9264":[-213473,244899,2017,10000],
"TELE_9265":[-8391,242342,-1890,20000],
"TELE_9266":[-22432,243491,-3068,20000],
"TELE_9267":[-20325,250337,-3247,30000],
"TELE_9268":[-27289,253838,-2154,40000],
"TELE_9269":[-16989,253858,-3360,40000],
"TELE_9270":[-4156,255301,-3139,50000],
"TELE_9271":[298,235111,-3273,70000],
"TELE_9272":[171946,-173352,3440,50000],
"TELE_9273":[178591,-184615,360,50000],
"TELE_9274":[114720,-114798,-11204,200000],
"TELE_9275":[-178463,153369,2477,100000],
"TELE_9276":[76883,63814,-3655,70000],
"TELE_F001":[10527,96849,-3424,1000],
"TELE_F002":[-54316,89187,-2819,1000],
"TELE_F003":[-55004,157132,-2050,1000],
"TELE_F004":[15447,186169,-2921,1000],
"TELE_F005":[-25348,219856,-3249,1000],
"TELE_F006":[7690,150721,-2887,1000],
"TELE_F007":[126064,120508,-2583,1000],
"TELE_F008":[116400,203804,-3331,1000],
"TELE_F009":[58948,137927,-1752,1000],
"TELE_F010":[72889,188048,-2580,1000],
"TELE_F011":[71419,6187,-3036,1000],
"TELE_F012":[124188,93295,-2142,1000],
"TELE_F013":[77910,89232,-2883,1000],
"TELE_F014":[112350,-17183,-992,1000],
"TELE_F015":[156707,53966,-3251,1000],
"TELE_F016":[157008,-68935,-2861,1000],
"TELE_F017":[189897,36705,-3407,1000],
"TELE_F018":[98822,-56465,-649,1000],
"TELE_F019":[68731,-63848,-2783,1000],
"TELE_F020":[111798,-141743,-2927,1000],
"TELE_F021":[71894,-92615,-1420,1000],
"TELE_32323":[85332,15877,-2810,1000],
"TELE_30832":[105746,113746,-3197,1000],
"TELE_30464":[17238,146773,-3087,1000],
"TELE_30701":[120103,76012,-2264,1000],
"TELE_20638":[135479,81125,-3554,1000],
"TELE_21294":[167668,-49491,-3573,10000],
"TELE_20250":[3900,166333,-3490,1000],
"TELE_22267":[156740,158908,-3336,10000],
"TELE_32009":[35987,-48551,893,10000],
"TELE_32342":[148468,176253,-4802,10000],
"TELE_32349":[159165,183748,-3710,10000],
"TELE_18367B":[133526,170954,-3707,10000],
"TELE_18367C":[145169,150490,-2854,10000],
"TELE_18367D":[156723,158693,-3354,10000],
"FISH_11401":[142106,-109882,-3583,5000],
"FISH_11403":[141224,-105665,-3620,5000],
"FISH_11404":[144656,-104829,-3674,5000],
"FISH_11405":[153180,-108289,-2799,5000],
"FISH_11406":[155852,-106117,-2739,5000],
"FISH_11408":[156610,-109214,-2668,5000],
"FISH_11409":[152365,-115862,-1564,5000],
"FISH_11410":[152717,-113402,-1649,5000],
"FISH_11411":[157237,-115875,-1885,5000],
"FISH_11413":[-79985,245089,-3736,5000],
"FISH_11414":[150906,69662,-3722,5000],
"FISH_11415":[141816,38271,-3689,5000],
"FISH_11416":[126161,-211226,-3722,5000],
"FISH_11417":[88781,156047,-3719,5000],
"FISH_11418":[81814,142392,-3656,5000],
"FISH_11419":[76629,167183,-3581,5000],
"FISH_11420":[33449,191564,-3685,5000],
"FISH_11421":[53875,78678,-3667,5000],
"FISH_11422":[69536,5865,-3694,5000],
"FISH_11423":[12152,111929,-3745,5000],
"FISH_11424":[40987,-90846,-3222,5000],
"FISH_11425":[10798,169348,-3717,5000],
"FISH_11426":[39757,43153,-3593,5000],
"FISH_11427":[14587,40994,-3661,5000],
"FISH_11428":[-6127,73170,-3632,5000],
"FISH_11429":[-24971,14206,-3282,5000],
"FISH_11430":[-9496,58071,-3634,5000],
"FISH_11433":[-57351,192378,-3684,5000],
"FISH_11434":[-63594,116992,-3555,5000],
"DarkCloud":[139819,150295,-3112,100000],
"QueenAnt":[-21607,184371,-5725,400000],
"Core":[17716,115605,-6584,500000],
"Orfen":[47262,17083,-4578,500000],
"Zaken":[52572,219100,-3231,600000],
}

TELE2={
"Baium":[112746,14163,10077,750000,4295,"染血的布"],
"Antharas":[154440,121211,-3809,790000,3865,"傳送石"],
"Valakas":[189883,-105401,-789,850000,7267,"浮游石"],
"Sailren":[23586,-7380,-1192,600000,8784,"卡茲克"],
"Baylor":[149332,173378,-5024,200000,9690,"被污染的水晶"],
"Halisha":[181380,-80894,-2731,900000,8073,"芙琳泰沙的結界破咒書"],
}

class Quest (JQuest) :
 def __init__(self,id,name,descr):
    JQuest.__init__(self,id,name,descr)
    npc1 = self.addSpawn(88000,  147410,   25948, -2012, 13271, False, 0)
    npc2 = self.addSpawn(88000,   83451,  147936, -3404, 22211, False, 0)
    npc3 = self.addSpawn(88000,   82933,   53138, -1495, 13607, False, 0)
    npc4 = self.addSpawn(88000,   15582,  142901, -2705, 13029, False, 0)
    npc5 = self.addSpawn(88000,  111344,  219409, -3545, 48836, False, 0)
    npc6 = self.addSpawn(88000,  -12788,  122782, -3116, 54517, False, 0)
    npc7 = self.addSpawn(88000,  147906,  -55218, -2734, 43737, False, 0)
    npc8 = self.addSpawn(88000,   87134, -143445, -1319, 13029, False, 0)
    npc9 = self.addSpawn(88000,  -82032,  150160, -3127, 19498, False, 0)
    npca = self.addSpawn(88000,  -80718,  149810, -3043, 23750, False, 0)
    npcb = self.addSpawn(88000,  117090,   76974, -2722, 39953, False, 0)
    npcc = self.addSpawn(88000,   43778,  -47672,  -796, 47671, False, 0)
    npcd = self.addSpawn(88000,   46876,   51501, -2976, 49477, False, 0)
    npce = self.addSpawn(88000,   11220,   15971, -4583, 13029, False, 0)
    npcf = self.addSpawn(88000,  -84436,  243210, -3729, 21400, False, 0)
    npcg = self.addSpawn(88000,  115079, -178119,  -912, 62180, False, 0)
    npch = self.addSpawn(88000,  -44802, -113878,  -208, 44928, False, 0)
    npci = self.addSpawn(88000, -116822,   46577,   368, 40960, False, 0)
    npcj = self.addSpawn(88000, -148873,  253700,  -184, 25730, False, 0)
    npck = self.addSpawn(88000, -185543,  240254,  1571, 11873, False, 0)

 def onAdvEvent (self,event,npc,player) :
    htmltext = event
    st = player.getQuestState(qn)
    if not st: return

    if event == "exp" :
       htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
       if st.getPlayer().getLevel() < 10 :
          htmltext="<html><body><center><font color=\"LEVEL\"><br>你的等級已經夠低了.....</body></html>"
       elif 10 <= st.getPlayer().getLevel() <= 19 :
          if st.getQuestItemsCount(57) >= 20000 :
              st.takeItems(57,20000)
              st.playSound("ItemSound.quest_finish")
              st.getPlayer().getStat().addLevel(-1)
              htmltext="<html><body><center><font color=\"LEVEL\"><br>沒想到真的會有人花錢降級.....</body></html>"
       elif 20 <= st.getPlayer().getLevel() <= 39 :
          if st.getQuestItemsCount(57) >= 100000 :
              st.takeItems(57,100000)
              st.playSound("ItemSound.quest_finish")
              st.getPlayer().getStat().addLevel(-1)
              htmltext="<html><body><center><font color=\"LEVEL\"><br>沒想到真的會有人花錢降級.....</body></html>"
       elif 40 <= st.getPlayer().getLevel() <= 75 :
          if st.getQuestItemsCount(57) >= 500000 :
              st.takeItems(57,500000)
              st.playSound("ItemSound.quest_finish")
              st.getPlayer().getStat().addLevel(-1)
              htmltext="<html><body><center><font color=\"LEVEL\"><br>沒想到真的會有人花錢降級.....</body></html>"
       elif 76 <= st.getPlayer().getLevel() <= 80 :
          if st.getQuestItemsCount(57) >= 1000000 :
              st.takeItems(57,1000000)
              st.playSound("ItemSound.quest_finish")
              st.getPlayer().getStat().addLevel(-1)
              htmltext="<html><body><center><font color=\"LEVEL\"><br>沒想到真的會有人花錢降級.....</body></html>"
       elif st.getPlayer().getLevel() >= 81 :
          if st.getQuestItemsCount(57) >= 2000000 :
              st.takeItems(57,2000000)
              st.playSound("ItemSound.quest_finish")
              st.getPlayer().getStat().addLevel(-1)
              htmltext="<html><body><center><font color=\"LEVEL\"><br>沒想到真的會有人花錢降級.....</body></html>"
    elif event == "Noble" :
       if st.getPlayer().getLevel() < 78 :
          htmltext = "<html><body><font color=\"LEVEL\"><center><br>想要獲得貴族資格，必須等級達到78級。<br>請等級達到78級以後再來吧！</body></html>"
       elif st.getQuestItemsCount(57) < 200000000 :
          htmltext = "<html><body><font color=\"LEVEL\"><center><br>你身上的錢不夠，轉貴族需要二億金幣。<br>請多存點錢再來吧！</body></html>"
       elif st.getPlayer().isNoble() :
          htmltext = "<html><body><center><br>你已經是貴族了！</body></html>"
       else :
          st.getPlayer().setNoble(True)
          st.playSound("ItemSound.quest_finish")
          st.takeItems(57,200000000)
          st.giveItems(7694,1)
          htmltext = "<html><body><center><font color=\"LEVEL\"><br>恭喜你成為貴族，祝遊戲愉快。</body></html>"
    elif event == "Noble0" :
       st.getPlayer().setNoble(False)
       st.playSound("ItemSound.quest_finish")
       st.takeItems(7694,-1)
       htmltext = "<html><body><center><br>你現在是平民了，祝遊戲愉快。</body></html>"
    elif event in BUFF.keys() :
        skillId,level,coins=BUFF[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           npc.setTarget(st.getPlayer())
           npc.doCast(SkillTable.getInstance().getInfo(skillId,level))
           st.getPlayer().setCurrentHpMp(st.getPlayer().getMaxHp(),st.getPlayer().getMaxMp())
           htmltext = "10.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in BUFF_DS.keys() :
        skillId,level,coins=BUFF_DS[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           npc.broadcastPacket(MagicSkillUse(st.getPlayer(), st.getPlayer(), skillId, level, 0, 0))
           SkillTable.getInstance().getInfo(skillId,level).getEffects(st.getPlayer(), st.getPlayer())
           sm = SystemMessage.getSystemMessage(SystemMessageId.YOU_FEEL_S1_EFFECT)
           sm.addSkillName(skillId)
           st.getPlayer().sendPacket(sm)
           htmltext = "10.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in BUFF2.keys() :
        skillId,level,coins=BUFF2[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           npc.setTarget(st.getPlayer())
           npc.doCast(SkillTable.getInstance().getInfo(skillId,level))
           htmltext = "10a.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in BUFF2_DS.keys() :
        skillId,level,coins=BUFF2_DS[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           npc.broadcastPacket(MagicSkillUse(st.getPlayer(), st.getPlayer(), skillId, level, 0, 0))
           SkillTable.getInstance().getInfo(skillId,level).getEffects(st.getPlayer(), st.getPlayer())
           sm = SystemMessage.getSystemMessage(SystemMessageId.YOU_FEEL_S1_EFFECT)
           sm.addSkillName(skillId)
           st.getPlayer().sendPacket(sm)
           htmltext = "10a.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in BUFF3.keys() :
        skillId,level,coins=BUFF3[event]
        if st.getPlayer().getPet() == None :
           htmltext="<html><body><center><font color=\"FF0000\"><br>請先召喚寵物！</body></html>"
        elif st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           npc.setTarget(st.getPlayer().getPet())
           npc.doCast(SkillTable.getInstance().getInfo(skillId,level))
           st.getPlayer().getPet().setCurrentHpMp(st.getPlayer().getPet().getMaxHp(),st.getPlayer().getPet().getMaxMp())
           htmltext = "10b.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in BUFFA1.keys() :
        next,coins=BUFFA1[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           self.startQuestTimer(next,0,npc,player)
           htmltext=""
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in BUFFA2.keys() :
        skillId,level,next=BUFFA2[event]
        SkillTable.getInstance().getInfo(skillId,level).getEffects(st.getPlayer(), st.getPlayer())
        self.startQuestTimer(next,50,npc,player)
        htmltext=""
    elif event in BUFFB1.keys() :
        next,coins=BUFFB1[event]
        if st.getPlayer().getPet() == None :
           htmltext="<html><body><center><font color=\"FF0000\"><br>請先召喚寵物！</body></html>"
        elif st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           self.startQuestTimer(next,0,npc,player)
           htmltext=""
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in BUFFB2.keys() :
        skillId,level,next=BUFFB2[event]
        SkillTable.getInstance().getInfo(skillId,level).getEffects(st.getPlayer().getPet(), st.getPlayer().getPet())
        self.startQuestTimer(next,50,npc,player)
        htmltext=""
    elif event in COLOR1.keys() :
        color,coins=COLOR1[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           st.getPlayer().getAppearance().setNameColor(color)
           st.getPlayer().broadcastUserInfo();
           htmltext = "08.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in COLOR2.keys() :
        color,coins=COLOR2[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           st.getPlayer().getAppearance().setTitleColor(color)
           st.getPlayer().broadcastUserInfo();
           htmltext = "08.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in COLOR3.keys() :
        color,coins=COLOR3[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           st.getPlayer().getAppearance().setNameColor(color)
           st.getPlayer().getAppearance().setTitleColor(color)
           st.getPlayer().broadcastUserInfo();
           htmltext = "08.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event == "COLOR1_Rnd" :
        if st.getQuestItemsCount(57) >= 20000 :
           st.takeItems(57,20000)
           COLOR_Rnd = st.getRandom(16777216)
           if COLOR_Rnd == 65280 or COLOR_Rnd == 1044480:
              COLOR_Rnd = 0
           st.getPlayer().getAppearance().setNameColor(COLOR_Rnd)
           st.getPlayer().broadcastUserInfo();
           htmltext = "08.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event == "COLOR2_Rnd" :
        if st.getQuestItemsCount(57) >= 20000 :
           st.takeItems(57,20000)
           COLOR_Rnd = st.getRandom(16777216)
           if COLOR_Rnd == 65280 or COLOR_Rnd == 1044480:
              COLOR_Rnd = 0
           st.getPlayer().getAppearance().setTitleColor(COLOR_Rnd)
           st.getPlayer().broadcastUserInfo();
           htmltext = "08.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event == "COLOR3_Rnd" :
        if st.getQuestItemsCount(57) >= 20000 :
           st.takeItems(57,20000)
           COLOR_Rnd = st.getRandom(16777216)
           if COLOR_Rnd == 65280 or COLOR_Rnd == 1044480:
              COLOR_Rnd = 0
           st.getPlayer().getAppearance().setNameColor(COLOR_Rnd)
           st.getPlayer().getAppearance().setTitleColor(COLOR_Rnd)
           st.getPlayer().broadcastUserInfo();
           htmltext = "08.htm"
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in TELE.keys() :
        x,y,z,coins=TELE[event]
        if st.getQuestItemsCount(57) >= coins :
           st.takeItems(57,coins)
           st.getPlayer().teleToLocation(x,y,z)
           htmltext=""
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    elif event in TELE2.keys() :
        x,y,z,coins,stone,name=TELE2[event]
        if st.getQuestItemsCount(57) >= coins :
           if st.getQuestItemsCount(stone) < 1 :
              htmltext="<html><body><center><font color=\"FF0000\"><br>任務道具</font><font color=\"LEVEL\">「"+name+"」</font><font color=\"FF0000\">不足！<br>請完成所需任務或直接購買道具！</body></html>"
           else :
              st.takeItems(57,coins)
              st.getPlayer().teleToLocation(x,y,z)
              htmltext=""
        else :
           htmltext="<html><body><center><font color=\"LEVEL\"><br>"+MessageTable.Messages[1049].getMessage()+"</body></html>"
    return htmltext

 def onFirstTalk (self,npc,player):
    npcId = npc.getNpcId()
    st = player.getQuestState(qn)
    if not st :
       st = self.newQuestState(player)
    if npcId == 88000 :
       htmltext = "00.htm"
    return htmltext

QUEST = Quest(-1,qn,"custom")

QUEST.addFirstTalkId(88000)
QUEST.addStartNpc(88000)
QUEST.addTalkId(88000)

print "■■■■■■■■■■■■■■■■"
print "■　　載入全功能 NPC v1.02　　■"
print "■■■■■■■■■■■■■■■■"
