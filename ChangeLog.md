# V1.2.5
12/11/2025
"MultiAura"

**additions**
- added advanced mode
- - button in settings to enable it
- -  allows you to equip multiple auras at once
- -  allows you to adjust each auras settings individually

- added delay
- -  updates blocks in steps (toggleable
- - - greatly reduces lag by making few blocks update at time
-# without it updates all blocks every frame

- added block saving 
- -  makes ball and spiral be fully on top of ground
-# without it half of aura is under ground

- optimization
- - greatly improved loops and added anti lag settings
- - blocks now lag client only, if you have thousands of blocks other peoples dont lag as much as you do


**changes**
- changes max speed range 
- - 0 to +10 -> -5 to +5
-# im sorry but its needed to reduce flinging, lag and client-server sync

- fixed spiral strands
- - now spiral strands create alternate spirals
-# past just overlapped blocks


**negatives**
- disk aura officially deleted


**known bugs**
- thickness is buggy on advanced mode (making weird shapes if you have little blocks)
- thickness is broken in advanced mode
- polygon rotate blocks broken in advanced
- alternate delay does nothing in legacy
- in advanced when turning off aura  while another aura is on, all blocks from aura turned off tp to 0,0,0 before going to right position


# V1.1.0
13/8/2025
"Dozengon"

**additions**
- added DOZEN of polyGONS ;)
- -  all the way from triangle all the way to dodeca
- -  they also have "rotate poly blocks" and "rotate poly aura"
- -    tho rotate poly aura is broken atp, sorry!

- added aura thickness
- -  allows you to choose how thick your aura is in blocks, because big auras looks slim

- added transparency filter
- -  used so it automatically abonds blocks with low hp on pvp

- added info tab **PLEASE REMEMBER TO READ THIS!!!**
- -  it includes important stuff like
- -    devs who have made the script / are important
- -    rules for using this script
- -    copy right rules

- now you dont need to re run script constantly!
- -  script keeps running and workign even after goign to flight mode
- -  auras turn on automatically if they are turned on when you go to flight mode
- -  all functions now stop when you close gui

**changes**
- moved distance and rotation speed sliders from Aura to Settings

- increased some values
- -  spiral
- - -   spiral height 100 -> 250
- - -   spiral laps 10 -> 25
- -  universal
- - -   distance 50 -> 75
- - -   speed 5 -> 10

**negatives**
- accidentally broke disk aura



small update
V1.1.1 & V1.1.2
13/8/2025 
small update
made info tab more calm

**old code snippet:**
- local InfoTab = Window.CreateTab('Info')
- InfoTab.CreateLabel("IMPORTANT! PLEASE READ!!!")
- InfoTab.CreateDivider("Dev Info")
- InfoTab.CreateLabel("Script by Brotabrr / script reaper")
- InfoTab.CreateLabel("IF YOU GOT / FOUND THIS SCRIPT ANYWHERE ELSE THAN MY YOUTUBE TELL ME IMMEADLY!!!")
- InfoTab.CreateLabel("KR4K GUI by stysscythe")
- InfoTab.CreateLabel("Nexity for original idea")
- InfoTab.CreateDivider("Copy Right")
- InfoTab.CreateLabel("this script is protected by CC BY-NC")
- InfoTab.CreateLabel("this means that if you use, you must give me credit, and it must be for non commercial use")
- InfoTab.CreateLabel("not giving me credit or charging money for this script will result in legal action taken against you")
- InfoTab.CreateDivider("Rules")
- InfoTab.CreateLabel("If you break rules you can no longer use this script")
- InfoTab.CreateLabel("Please report any rule breakers to me on yt or dc")
- InfoTab.CreateLabel("1 you cannot use this in pvp for advantage,      2 you cannot fling anyone,")
- InfoTab.CreateLabel("3 you cannot use so many blocks that it lags others, 4, if others ask you to stop, please do")
- InfoTab.CreateLabel("REMEMBER THAT I CAN BAN YOU ANYTIME!!!")
- InfoTab.CreateLabel("WHEN YOU USE THIS SCRIPT YOU AGREE TO ALL OF THESE AND I CAN ANYTIME EDIT THESE RULES!!!")

**new code snippet:**
- local InfoTab = Window.CreateTab('Info')
- InfoTab.CreateLabel("IMPORTANT! PLEASE READ!!!")
- InfoTab.CreateDivider("Dev Info")
- InfoTab.CreateLabel("Script by Brotabrr / script reaper")
- InfoTab.CreateLabel("IF YOU GOT / FOUND THIS SCRIPT ANYWHERE ELSE THAN MY YOUTUBE TELL ME IMMEADLY!!!")
- InfoTab.CreateLabel("KR4K GUI by stysscythe")
- InfoTab.CreateLabel("Nexity for original idea")
- InfoTab.CreateDivider("Copy Right")
- InfoTab.CreateLabel("this script is protected by CC BY-NC")
- InfoTab.CreateLabel("this means that if you use, you must give me credit, and it must be for non commercial use")
- InfoTab.CreateLabel("not giving me credit or charging money for this script will result in legal action taken against you")
- InfoTab.CreateDivider("Rules")
- InfoTab.CreateLabel("If you break rules you can no longer use this script")
- InfoTab.CreateLabel("Please report any rule breakers to me on yt or dc")
- InfoTab.CreateLabel("1 you cannot use this in pvp for advantage,")
- InfoTab.CreateLabel("2 you cannot fling anyone,")
- InfoTab.CreateLabel("3 you cannot use so many blocks that it lags others,")
- InfoTab.CreateLabel("4, if others ask you to stop, please do")
- InfoTab.CreateLabel("please remember that i can ban you from using this script, forever, account and/or ip ban")
- InfoTab.CreateLabel("when you use this script you agree to these rules and remember that i can change these anytime")
