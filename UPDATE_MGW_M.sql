INSERT INTO NEW_MGW(NUM, TXT, UNIT,GW,QUOTE,TYPE)
VALUES  (1,'Kraftwerk',1,0,0,2),
        (1,'Autobahn',0,1,0,2),
        (2,'Kraftwerk',1,0,0,2),
        (2,'Trans-Europe Express',0,1,0,2),
        (3,'Louis Armstrong',1,0,0,2),
        (3,'What a Wonderful World',0,1,0,2),
        (4,'Louis Armstrong',1,0,0,2),
        (4,'When the Saints Go Marching In',0,1,0,2),
        (5,'The Beatles',1,0,0,2),
        (5,'Hey Jude',0,1,0,2),
        (6,'The Beatles',1,0,0,2),
        (6,'Let It Be',0,1,0,2),
        (7,'Depeche Mode',1,0,0,2),
        (7,'Enjoy the Silence',0,1,0,2),
        (8,'Depeche Mode',1,0,0,2),
        (8,'Personal Jesus',0,1,0,2),
        (9,'Michael Jackson',1,0,0,2),
        (9,'Billie Jean',0,1,0,2),
        (10,'Michael Jackson',1,0,0,2),
        (10,'Smooth Criminal',0,1,0,2),
        (11,'Nirvana',1,0,0,2),
        (11,'Smells Like Teen Spirit',0,1,0,2),
        (12,'Nirvana',1,0,0,2),
        (12,'Heart-Shaped Box',0,1,0,2),
        (13,'Elvis Presley',1,0,0,2),
        (13,'Jailhouse Rock',0,1,0,2),
        (14,'Elvis Presley',1,0,0,2),
        (14,'Can not Help Falling In Love',0,1,0,2),
        (15,'John Williams',1,0,0,2),
        (15,'Star Wars Main Theme',0,1,0,2),
        (16,'John Williams',1,0,0,2),
        (16,'The Raiders March',0,1,0,2),
        (17,'Led Zeppelin',1,0,0,2),
        (17,'Whole Lotta Love',0,1,0,2),
        (18,'Led Zeppelin',1,0,0,2),
        (18,'Kashmir',0,1,0,2),
        (19,'Pink Floyd',1,0,0,2),
        (19,'Time',0,1,0,2),
        (20,'Pink Floyd',1,0,0,2),
        (20,'Wish You Were Here',0,1,0,2);

INSERT INTO Audio_Sounds(SoundID, Filename, LoadType)
SELECT 'SND_MGW_MUSIC_' || NUM, 'MGW_M_' || NUM ||'.mp3', 'DynamicResident'
FROM NEW_MGW
WHERE UNIT = 1 AND TYPE = 2 AND
NOT EXISTS (SELECT 1 FROM Audio_Sounds 
                  WHERE SoundID = 'SND_MGW_MUSIC_' || NUM 
                  OR Filename = 'MGW_M_' || NUM ||'.mp3');

INSERT INTO Audio_2DSounds(ScriptID,SoundID, SoundType, MinVolume,MaxVolume,IsMusic,Priority,Looping)
SELECT 'AS2D_GREAT_MUSICIAN_MUSICIAN_MGW_ '|| NUM ||'_MUSIC_MGW_' || NUM ,'SND_MGW_MUSIC_' || NUM, 'GAME_MUSIC',90,90,1,0,1
FROM NEW_MGW
WHERE UNIT = 1 AND TYPE = 2 AND
NOT EXISTS (SELECT 1 FROM Audio_2DSounds 
                  WHERE SoundID = 'SND_MGW_MUSIC_' || NUM 
                  OR ScriptID = 'AS2D_GREAT_MUSICIAN_MUSICIAN_MGW_ '|| NUM ||'_MUSIC_MGW_' || NUM);

INSERT INTO Unit_UniqueNames (UnitType, UniqueName, GreatWorkType)
SELECT 'UNIT_MUSICIAN', 'TXT_KEY_GREAT_PERSON_MUSICIAN_MGW_' || NUM, 'GREAT_WORK_MUSIC_MGW_' || NUM
FROM NEW_MGW
WHERE UNIT = 1 AND TYPE = 2 AND
NOT EXISTS (SELECT 1 FROM Unit_UniqueNames 
                  WHERE UniqueName = 'TXT_KEY_MUSICIAN_MGW_' || NUM 
                  OR GreatWorkType = 'GREAT_WORK_MUSIC_MGW_' || NUM);
INSERT INTO GreatWorks (Type, GreatWorkClassType, Description, Audio, Image)
SELECT 'GREAT_WORK_MUSIC_MGW_' || NUM, 'GREAT_WORK_MUSIC', 'TXT_KEY_MUSIC_MGW_' || NUM, 'AS2D_GREAT_MUSICIAN_MUSICIAN_MGW_ '|| NUM ||'_MUSIC_MGW_' || NUM, 'GreatMusician_Background.dds'
FROM NEW_MGW 
WHERE GW = 1 AND TYPE = 2 AND NOT EXISTS (SELECT 1 FROM GreatWorks WHERE Type = 'GREAT_WORK_MUSIC_MGW_' || NUM);

INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_GREAT_PERSON_MUSICIAN_MGW_' || NUM, TXT
FROM NEW_MGW
WHERE UNIT = 1 AND TYPE = 2 AND NOT EXISTS (SELECT 1 FROM Language_en_US WHERE Tag = 'TXT_KEY_MUSICIAN_MGW_' || NUM);
INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_MUSIC_MGW_' || NUM, TXT
FROM NEW_MGW
WHERE GW = 1 AND TYPE = 2 AND NOT EXISTS (SELECT 1 FROM Language_en_US WHERE Tag = 'TXT_KEY_MUSIC_MGW_' || NUM);