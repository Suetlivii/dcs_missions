-------------------------------------------------------------------------------------------------------
redTransportWingTasksConfig = {}

-------------------------------------------------------------------------------------------------------
red_heli_tr_01_task = 
{
    name = 'rht01',
    groupsPrefixes = { "TR" },
    coalition = 1,
    startTrigger = "20101",
    goodEndTrigger = "20102",
    badEndTrigeer = "20103",
    cancelTrigger = "20104",
    startMsgFriendly = [[01."Пробный бросок"
Поставлена задача. Доставить пехоту в северную часть города Idlib (Северная часть BV-88). При подлете к LZ уничтожить пехоту противника и высадить наши силы!

01."Test throw"
The task is set. Deliver the infantry to the northern part of the city of Idlib (northern part of BV-88). When approaching LZ, destroy enemy infantry and land our forces!]],
    startMsgEnemy = "",
    goodEndMsgFriendly = 'Транспортная задача выполнена! Transport mission complete!',
    goodEndMsgEnemy = "",
    badEndMsgFriendly = "",
    badEndMsgEnemy = "",
    cancelEndMsgFriendly = "",
    cancelEndMsgEnemy = "",
    briefMsgFriendly = nil,
    briefMsgEnemy = "",
    markZoneName = "",
    markText = ''
}
-------------------------------------------------------------------------------------------------------
red_heli_tr_02_task = 
{
    name = 'rht02',
    groupsPrefixes = { "TR" },
    coalition = 1,
    startTrigger = "20201",
    goodEndTrigger = "20202",
    badEndTrigeer = "20203",
    cancelTrigger = "20204",
    startMsgFriendly = [[02."Шаверма для соника"
Пьяный Соник ушел с базы. С КПП докладывают - "Он ушел в город Saraqib (CV-07) за шавермой". За такой проступок, ему придется покупать шаверму для всего гарнизона. Найдите его и доставте на базу!

02. "Shawarma for sonic"
Drunken Sonic left the base. From the checkpoint they report - "He went to the city of Saraqib (CV-07) for a shawarma." For such an offense, he will have to buy a shawarma for the entire garrison. Find him and take him to base!]],
    startMsgEnemy = "",
    goodEndMsgFriendly = 'Транспортная задача выполнена! Transport mission complete!',
    goodEndMsgEnemy = "",
    badEndMsgFriendly = "Миссия провалена - Соник погиб! Mission failed - Sonique is dead!",
    badEndMsgEnemy = "",
    cancelEndMsgFriendly = "",
    cancelEndMsgEnemy = "",
    briefMsgFriendly = nil,
    briefMsgEnemy = "",
    markZoneName = "",
    markText = ''
}
-------------------------------------------------------------------------------------------------------
red_heli_tr_03_task = 
{
    name = 'rht03',
    groupsPrefixes = { "TR" },
    coalition = 1,
    startTrigger = "20301",
    goodEndTrigger = "20302",
    badEndTrigeer = "20303",
    cancelTrigger = "20304",
    startMsgFriendly = [[03."Джони, они на мостах..."
В восточной части квадрата CV-27 боевики захватили Ж/Д мост. Ваша задача - уничтожить группу пехоты у моста и высадить десант. Удачи!

03. "Johnny, they're on the bridges ..."
In the eastern part of the CV-27 square, militants seized the railway bridge. Your task is to destroy the group of infantry near the bridge, and then land the troops. Good luck!]],
    startMsgEnemy = "",
    goodEndMsgFriendly = 'Транспортная задача выполнена! Transport mission complete!',
    goodEndMsgEnemy = "",
    badEndMsgFriendly = "Миссия провалена! Mission failed!",
    badEndMsgEnemy = "",
    cancelEndMsgFriendly = "",
    cancelEndMsgEnemy = "",
    briefMsgFriendly = nil,
    briefMsgEnemy = "",
    markZoneName = "",
    markText = ''
}
-------------------------------------------------------------------------------------------------------
red_heli_tr_04_task = 
{
    name = 'rht04',
    groupsPrefixes = { "TR" },
    coalition = 1,
    startTrigger = "20401",
    goodEndTrigger = "20402",
    badEndTrigeer = "20403",
    cancelTrigger = "20404",
    startMsgFriendly = [[04."Помощь окруженцам"
С аэродрома Kuweires (находится в окружении врага) запрашивают боеприпасы. Ваша задача доставить 4 ящика боеприпасов нашим войнам. Будте осторожны! За аэродром ведутся ожесточенные бои!

04. "Helping the Surroundings"
Ammunition is requested from the Kuweires airfield (surrounded by the enemy). Your task is to deliver 4 boxes of ammunition to our soldiers. Be careful! Fierce battles are being waged for the airfield!]],
    startMsgEnemy = "",
    goodEndMsgFriendly = 'Транспортная задача выполнена! Transport mission complete!',
    goodEndMsgEnemy = "",
    badEndMsgFriendly = "Миссия провалена! Mission failed!",
    badEndMsgEnemy = "",
    cancelEndMsgFriendly = "",
    cancelEndMsgEnemy = "",
    briefMsgFriendly = nil,
    briefMsgEnemy = "",
    markZoneName = "",
    markText = ''
}
-------------------------------------------------------------------------------------------------------
red_heli_tr_05_task = 
{
    name = 'rht05',
    groupsPrefixes = { "TR" },
    coalition = 1,
    startTrigger = "20501",
    goodEndTrigger = "20502",
    badEndTrigeer = "20503",
    cancelTrigger = "20504",
    startMsgFriendly = [[05."Археологи"
В крепости Алеппо археологи нашли артефакты. Доставьте их в Тафтаназ. Требуется погрузка 2хUh1(600kg) или 1хМи8(3000kg) с посадкой на площадке амфитеатра крепости.

04. "Archaeologists"
In the fortress of Aleppo, archaeologists have found artifacts. Take them to Taftanaz. Loading of 2xUh1(600kg) or 1xMi8(3000kg) with landing on the site of the fortress amphitheater is required.]],
    startMsgEnemy = "",
    goodEndMsgFriendly = 'Транспортная задача выполнена! Transport mission complete!',
    goodEndMsgEnemy = "",
    badEndMsgFriendly = "Миссия провалена! Mission failed!",
    badEndMsgEnemy = "",
    cancelEndMsgFriendly = "",
    cancelEndMsgEnemy = "",
    briefMsgFriendly = nil,
    briefMsgEnemy = "",
    markZoneName = "",
    markText = ''
}
-------------------------------------------------------------------------------------------------------

table.insert(redTransportWingTasksConfig, red_heli_tr_01_task)
table.insert(redTransportWingTasksConfig, red_heli_tr_02_task)
table.insert(redTransportWingTasksConfig, red_heli_tr_03_task)
table.insert(redTransportWingTasksConfig, red_heli_tr_04_task)
table.insert(redTransportWingTasksConfig, red_heli_tr_05_task)