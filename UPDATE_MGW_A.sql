INSERT INTO NEW_MGW(NUM, TXT, UNIT,GW,QUOTE,TYPE)VALUES  
        -- (1,'张择端',1,0,0,1),
        -- (1,'清明上河图',0,1,0,1),
        -- (2,'一个热爱学习的男孩',1,0,0,1),
        -- (2,'',0,1,0,1);--(这四行是例子)
INSERT INTO Unit_UniqueNames (UnitType, UniqueName, GreatWorkType)
SELECT 'UNIT_ARTIST', 'TXT_KEY_ARTIST_MGW_' || NUM, 'GREAT_WORK_ART_MGW_' || NUM
FROM NEW_MGW
WHERE UNIT = 1 AND TYPE = 1 AND
NOT EXISTS (SELECT 1 FROM Unit_UniqueNames 
                  WHERE UniqueName = 'TXT_KEY_ARTIST_MGW_' || NUM 
                  AND GreatWorkType = 'GREAT_WORK_ART_MGW_' || NUM);
INSERT INTO GreatWorks (Type, GreatWorkClassType, Description, Audio, Image)
SELECT 'GREAT_WORK_ART_MGW_' || NUM, 'GREAT_WORK_ART', 'TXT_KEY_ART_MGW_' || NUM, 'AS2D_GREAT_ARTIST_ARTWORK', 'MGW_A_' || NUM ||'.dds'
FROM NEW_MGW 
WHERE GW = 1 AND TYPE = 1 AND NOT EXISTS (SELECT 1 FROM GreatWorks WHERE Type = 'GREAT_WORK_ART_MGW_' || NUM);

INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_ARTIST_MGW_' || NUM, TXT
FROM NEW_MGW
WHERE UNIT = 1 AND TYPE = 1 AND NOT EXISTS (SELECT 1 FROM Language_en_US WHERE Tag = 'TXT_KEY_ARTIST_MGW_' || NUM);
INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_ART_MGW_' || NUM, TXT
FROM NEW_MGW
WHERE GW = 1 AND TYPE = 1 AND NOT EXISTS (SELECT 1 FROM Language_en_US WHERE Tag = 'TXT_KEY_ART_MGW_' || NUM);