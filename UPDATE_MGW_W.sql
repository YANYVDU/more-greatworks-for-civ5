CREATE TABLE "NEW_MGW" (
	"NUM" INTEGER DEFAULT 0,--每一组杰作必须唯一
    "TXT" TEXT,--文本内容
	"UNIT" INTEGER DEFAULT 0,--写1表示该文本是大文名称，即作者名
	"GW" INTEGER DEFAULT 0,--写1表示该文本是作品名
    "QUOTE" INTEGER DEFAULT 0,--写1表示该文本是引言
    "TYPE"  INTEGER DEFAULT 0--区分文学、艺术、音乐，默认的0为文学，1为艺术，2为音乐
);
INSERT INTO NEW_MGW(NUM, TXT, UNIT,GW,QUOTE)
VALUES  (1,'李白',1,0,0),
        (1,'行路难',0,1,0),
        (1,'“长风破浪会有时，直挂云帆济沧海。”',0,0,1),
        (2,'苏轼',1,0,0),
        (2,'念奴娇·赤壁怀古',0,1,0),
        (2,'“人生如梦，一尊还酹江月。”',0,0,1),
        (3,'杜甫',1,0,0),
        (3,'石壕吏',0,1,0),
        (3,'“存者且偷生，死者长已矣。”',0,0,1),
        (4,'司马迁',1,0,0),
        (4,'史记',0,1,0),
        (4,'“天下熙熙，皆为利来；天下攘攘，皆为利往。”',0,0,1),
        (5,'白居易',1,0,0),
        (5,'钱塘湖春行',0,1,0),
        (5,'“乱花渐欲迷人眼，浅草才能没马蹄。”',0,0,1),
        (6,'辛弃疾',1,0,0),
        (6,'永遇乐·京口北固亭怀古',0,1,0),
        (6,'“四十三年，望中犹记，烽火扬州路。”',0,0,1),
        (7,'屈原',1,0,0),
        (7,'离骚',0,1,0),
        (7,'“何方圜之能周兮？夫孰异道而相安？”',0,0,1),
        (8,'李商隐',1,0,0),
        (8,'夜雨寄北',0,1,0),
        (8,'“何当共剪西窗烛，却话巴山夜雨时。”',0,0,1),
        (9,'王勃',1,0,0),
        (9,'滕王阁序',0,1,0),
        (9,'“落霞与孤鹜齐飞，秋水共长天一色。”',0,0,1),
        (10,'韩愈',1,0,0),
        (10,'古今贤文·劝学',0,1,0),
        (10,'“书山有路勤为径，学海无涯苦作舟。”',0,0,1),
        (11,'柳永',1,0,0),
        (11,'雨霖铃·寒蝉凄切',0,1,0),
        (11,'“多情自古伤离别，更那堪，冷落清秋节！”',0,0,1),
        (12,'陶渊明',1,0,0),
        (12,'饮酒',0,1,0),
        (12,'“采菊东篱下，悠然见南山。”',0,0,1),
        (13,'王维',1,0,0),
        (13,'使至塞上',0,1,0),
        (13,'“大漠孤烟直，长河落日圆。”',0,0,1),
        (14,'柳宗元',1,0,0),
        (14,'江雪',0,1,0),
        (14,'“孤舟蓑笠翁，独钓寒江雪。”',0,0,1),
        (15,'李清照',1,0,0),
        (15,'醉花阴',0,1,0),
        (15,'“莫道不销魂，帘卷西风，人比黄花瘦。”',0,0,1),
        (16,'范仲淹',1,0,0),
        (16,'岳阳楼记',0,1,0),
        (16,'“居庙堂之高则忧其民，处江湖之远则忧其君。”',0,0,1);
INSERT INTO Unit_UniqueNames (UnitType, UniqueName, GreatWorkType)
SELECT 'UNIT_WRITER', 'TXT_KEY_WRITER_CN_' || NUM, 'GREAT_WORK_POETRY_CN_' || NUM
FROM NEW_MGW
WHERE UNIT = 1 AND TYPE = 0 AND
NOT EXISTS (SELECT 1 FROM Unit_UniqueNames 
                  WHERE UniqueName = 'TXT_KEY_WRITER_CN_' || NUM 
                  OR GreatWorkType = 'GREAT_WORK_POETRY_CN_' || NUM);
INSERT INTO GreatWorks (Type, GreatWorkClassType, Description, Quote, Audio, Image)
SELECT 'GREAT_WORK_POETRY_CN_' || NUM, 'GREAT_WORK_LITERATURE', 'TXT_KEY_POETRY_CN_' || NUM, 'TXT_KEY_POETRY_QUOTE_CN_' || NUM, 'AS2D_GREAT_ARTIST_ARTWORK', 'GreatWriter_Background.dds'
FROM NEW_MGW 
WHERE GW = 1 AND NOT EXISTS (SELECT 1 FROM GreatWorks WHERE Type = 'GREAT_WORK_POETRY_CN_' || NUM);

INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_WRITER_CN_' || NUM, TXT
FROM NEW_MGW
WHERE UNIT = 1 AND TYPE = 0 AND NOT EXISTS (SELECT 1 FROM Language_en_US WHERE Tag = 'TXT_KEY_WRITER_CN_' || NUM);
INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_POETRY_CN_' || NUM, TXT
FROM NEW_MGW
WHERE GW = 1 AND TYPE = 0 AND NOT EXISTS (SELECT 1 FROM Language_en_US WHERE Tag = 'TXT_KEY_POETRY_CN_' || NUM);
INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_POETRY_QUOTE_CN_' || NUM, TXT
FROM NEW_MGW
WHERE QUOTE = 1 AND TYPE = 0 AND NOT EXISTS (SELECT 1 FROM Language_en_US WHERE Tag = 'TXT_KEY_POETRY_QUOTE_CN_' || NUM);

