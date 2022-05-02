-------------------------------------------------------------------------------------------------------
redDeirezzorRotaryWingTasksConfig = {}

-------------------------------------------------------------------------------------------------------
red_deirezzor_heli_01_task = 
{
    name = 'rdz01',
    groupsPrefixes = { "TDZ" },
    coalition = 1,
    startTrigger = "80101",
    goodEndTrigger = "80102",
    badEndTrigeer = "80103",
    cancelTrigger = "80104",
    startMsgFriendly = [[01."Махмуд, они идут"
Вражеская техника на Юго-Западе от аэродрома Dier ez-Zore стоит и обстреливает объект. Заставьте их замолчать!

01."Mahmoud, they're coming"
Enemy Tanks in the South-West of the Dier ez-Zore airfield is standing and firing at the object. Silence them!]],
    goodEndMsgFriendly = 'Вертолетная задача выполнена! Helicopter mission complete!',
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
red_deirezzor_heli_02_task = 
{
    name = 'rdz02',
    groupsPrefixes = { "TDZ" },
    coalition = 1,
    startTrigger = "80201",
    goodEndTrigger = "80202",
    badEndTrigeer = "80203",
    cancelTrigger = "80204",
    startMsgFriendly = [[01."Сегодня в районе аэродрома фугасный дождь"
Ребята с аэродрома жалуются на плохую погоду, запрашивают зонтика к северу базы (FV01)! Найдите и уничтожьте Человека-дождя

01."High-explosive rain near the airfield today"
The guys from the airfield are complaining about the bad weather, asking for an umbrella to the north of the base (FV01)! Find and destroy Rain Man]],
    goodEndMsgFriendly = 'Вертолетная задача выполнена! Helicopter mission complete!',
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
red_Deirezzor_heli_02_task = 
{
    name = 'rdz02',
    groupsPrefixes = { "TDZ" },
    coalition = 1,
    startTrigger = "80201",
    goodEndTrigger = "80202",
    badEndTrigeer = "80203",
    cancelTrigger = "80204",
    startMsgFriendly = [[02."Сегодня в районе аэродрома фугасный дождь"
Ребята с аэродрома жалуются на плохую погоду, запрашивают зонтика к северу базы (FV01)! Найдите и уничтожьте Человека-дождя

02."High-explosive rain near the airfield today"
The guys from the airfield are complaining about the bad weather, asking for an umbrella to the north of the base (FV01)! Find and destroy Rain Makers]],
    goodEndMsgFriendly = 'Вертолетная задача выполнена! Helicopter mission complete!',
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
red_deirezzor_heli_03_task = 
{
    name = 'rdz03',
    groupsPrefixes = { "TDZ" },
    coalition = 1,
    startTrigger = "80301",
    goodEndTrigger = "80302",
    badEndTrigeer = "80303",
    cancelTrigger = "80304",
    startMsgFriendly = [[03."ИГИЛ експресс"
Агентура доложила: Колонна ИГ движется вдоль железной дороги (FV10) на северо-запад. Так же есть иноформация, что достигнув FV01, колонна свернет в направлении ародрома. Организуйте врагам технические проблемы.

03."ISIS Express"
Agents reported: The IS column is moving along the railway (FV10) to the northwest. There is also information that, having reached FV01, the column will turn in the direction of the airfield. Organize technical problems for enemies.]],
    goodEndMsgFriendly = 'Вертолетная задача выполнена! Helicopter mission complete!',
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
red_deirezzor_heli_04_task = 
{
    name = 'rdz04',
    groupsPrefixes = { "TDZ" },
    coalition = 1,
    startTrigger = "80401",
    goodEndTrigger = "80402",
    badEndTrigeer = "80403",
    cancelTrigger = "80404",
    startMsgFriendly = [[04."Сирийская клоунада"
Замечена демонстративная группа ИГ, которая перемещается в квадратах EV80, EV81, EV91, EV90. уничтожьте этот бл*дский цирк.

04."Syrian Clowns"
A demonstrative group of ISIS has been observed, which moves in the squares EV80, EV81, EV91, EV90. destroy this f*cking circus.]],
    goodEndMsgFriendly = 'Вертолетная задача выполнена! Helicopter mission complete!',
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

table.insert(redDeirezzorRotaryWingTasksConfig, red_deirezzor_heli_01_task)
table.insert(redDeirezzorRotaryWingTasksConfig, red_deirezzor_heli_02_task)
table.insert(redDeirezzorRotaryWingTasksConfig, red_deirezzor_heli_03_task)
table.insert(redDeirezzorRotaryWingTasksConfig, red_deirezzor_heli_04_task)