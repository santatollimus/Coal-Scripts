-----------------------------------------
-- hunting.lua (combined client+server)
-----------------------------------------

-- =====================================
--  SHARED CONFIG (from coal_hunting.lua)
-- =====================================
-- Copy your entire HuntingConfig table from coal_hunting.lua here.
-- Example structure:
HuntingConfig = {
    rewards = {
		----------------------------------------------------------------
        -- Generic pelt prop1 (delete it, but give no items)
        [-1038420333] = {},   		
		--Generic pelt prop2 (delete it, but give noitems)
        [-1202329112] = {},
		--Generic pelt prop3 (delete it, but give noitems)
		[1780825678] = {},
		--Generic pelt prop4 (delete it, but give noitems)
        [85379810] = {},
		--Generic pelt prop5 {delete it, but give noitems)
		[-1258513246] = {},
		--Generic pelt prop6 {delete it, but give noitems)
		[412583060] = {},
		--Generic snake pelt prop {delete it, but givenoitems}
		[-1240210710] = {},
		--Generic alligator chop
		[382484708] = {},
		--Generic large pelts w/ head {delete it, but give noitems)
		[-1739401517] = {},
		--Generic large pelts w/ head {delete it, but give noitems)
		[468877146] = {},
		--Generic large pelt w/ head for dville variant {delete it, but give noitems}
		[1979120156] = {},
		--Generic large pelts w/o head (deletethem, but give no items; the original skinned version
		--should be giving the losses)
		[-1155533407] = {},	
		
		----------------------------------------------------------------
		--"Legend 'wait for it' . . . daries"
		-- Legendary Boa
		[-1747620994] = {
			{ item = "legendsnakes", count = 1 },
			{ item = "stringy", count = 4 },
			{ item = "snaket", count = 2 },
			{ item = "Snake_Poison", count = 2 },
		},
		-- Legendary Bear pelt
		[-1631768462] = {
			{ item = "biggame", count = 3 },
			{ item = "leggbears", count = 1 },
	--		{ item = "bearc", count = 1 },
		},
		-- Big Son
		[-1970772011] = {
			{ item = "biggame", count = 4 },
			{ item = "legendsnakes", count = 1 },
			{ item = "snaket", count = 2 },
			{ item = "Snake_Poison", count = 2 },
		},
		-- Legendary Bike Bear
		[-1258652484] = {
			{ item = "biggame", count = 3 },
			{ item = "leggbears", count = 1 },
	--		{ item = "bearc", count = 1 },
		},
		-- Prarie Bear
		[-776014362] = {
			{ item = "biggame", count = 3 },
			{ item = "leggbears", count = 1 },
	--		{ item = "bearc", count = 1 },
		},
		--Grizzly Bear
		[1386005610] = {
			{ item = "gbears", count = 1 },
			{ item = "biggame", count = 3 },
		},
		-- Golden Bear
		[-1414989025] = {
			{ item = "biggame", count = 3 },
			{ item = "leggbears", count = 1 },
	--		{ item = "bearc", count = 1 },
		},
		-- Lord Of The Ham
		[803807302] = {
			{ item = "boar", count = 6 },
			{ item = "legboars", count = 1 },
		},
		-- Legendary Tatanka Bison
		[-638523734] = {
			{ item = "beef", count = 5 },
			{ item = "legbisons", count = 1 },
		},
		-- Legendary Bison Boy
		[1722580350] = {
			{ item = "beef", count = 5 },
			{ item = "legbisons", count = 1 },
		},
		-- Legendary Ridgeback Spirit Bear
		[1963317232] = {
			{ item = "biggame", count = 4 },
			{ item = "leggbears", count = 1 },
	--		{ item = "bearc", count = 1 },
		},
		-- Legendary Ota Fox
		[961994491] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legfoxs", count = 1 },
		},
		-- Legendary Iya Coyote
		[576533130] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legcoyotes", count = 1 },
		},
		-- Legendary Sapa Cougar
		[1079459457] = {
			{ item = "biggame", count = 3 },
			{ item = "legcougs", count = 1 },
		},
		-- Legendary Iguga Cougar
		[-1435105840] = {
			{ item = "biggame", count = 3 },
			{ item = "legcougs", count = 1 },
		},
		-- Legendary Ghost Cougar
		[1901752714] = {
			{ item = "biggame", count = 3 },
			{ item = "legcougs", count = 1 },
		},
		--Legendary Nightstalker Panther
		[-1189368951] = {
			{ item = "biggame", count = 3 },
		},
		--Legendary Ghost Panther 1
		[-1189368951] = {
			{ item = "biggame", count = 3 },
		},
		-- Ghost Wolf
		[-446959] = {
			{ item = "biggame", count = 3 },
			{ item = "legwolfs", count = 1 },
		},
		-- Mel Phones Wolf
		[-1166973418] = {
			{ item = "biggame", count = 3 },
			{ item = "legwolfs", count = 1 },
		},
		-- Onyx Wolf
		[-1602860000] = {
			{ item = "biggame", count = 3 },
			{ item = "legwolfs", count = 1 },
		},
		-- Legendary Cogi Deer
		[1965649527] = {
			{ item = "deermeat", count = 4 },
			{ item = "legdeers", count = 1 },
		},
		-- Legendary Niali Elk
		[-1175422032] = {
			{ item = "deermeat", count = 4 },
			{ item = "legelk", count = 1 },
		},
		-- Legendary Monarch Buck
		[-1000427148] = {
			{ item = "deermeat", count = 4 },
			{ item = "legbucks", count = 1 },
		},
		-- Legendary Knights Buck
		[1620292759] = {
			{ item = "deermeat", count = 4 },
			{ item = "legbucks", count = 1 },
		},
		-- Legendary Black Buck
		[1423330433] = {
			{ item = "deermeat", count = 4 },
			{ item = "legbucks", count = 1 },
		},
		-- Legendary Snow Elk
		[-2011226991] = {
			{ item = "deermeat", count = 4 },
			{ item = "legelk", count = 1 },
		},
		-- Legendary Cory Coyote
		[623248077] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legcoyotes", count = 1 },
		},
		-- Legendary Midnight Paw Coyote
		[1457863779] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legcoyotes", count = 1 },
		},
		-- Legendary Inahme Elk
		[-776917561] = {
			{ item = "deermeat", count = 4 },
			{ item = "legelk", count = 1 },
		},
		-- Legendary Cuimites Elk
		[1012811790] = {
			{ item = "deermeat", count = 4 },
			{ item = "legelk", count = 1 },
		},
		-- Legendary Ota Brown Bear
		[1169181] = {
			{ item = "biggame", count = 3 },
			{ item = "leggbears", count = 1 },
	--		{ item = "bearc", count = 1 },
		},
		-- Legendary Ota Grizzly Bear
		[-1378414392] = {
			{ item = "biggame", count = 3 },
			{ item = "leggbears", count = 1 },
	--		{ item = "bearc", count = 1 },
		},
		-- Legendary Cross Fox
		[-1500514424] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legfoxs", count = 1 },
		},
		-- Legendary Marble Fox
		[-1283569733] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legfoxs", count = 1 },
		},
		-- Legendary White Fox
		[435188269] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legfoxs", count = 1 },
		},
		-- Legendary Black Wolf
		[33409331] = {
			{ item = "biggame", count = 3 },
			{ item = "legwolfs", count = 1 },
		},
		-- Legendary Emerald Wolf
		[-655778027] = {
			{ item = "biggame", count = 3 },
			{ item = "legwolfs", count = 1 },
		},
		-- Legendary Ota Ram
		[198516061] = {
			{ item = "mutton", count = 5 },
			{ item = "legrams", count = 1 },
		},
		-- Legendary Gault Ram
		[-1498647787] = {
			{ item = "mutton", count = 5 },
			{ item = "legrams", count = 1 },
		},
		-- Legendary Ground Ram
		[-175454415] = {
			{ item = "mutton", count = 5 },
			{ item = "legrams", count = 1 },
		},
		-- deer
		[1110710183] = {
			{ item = "venison", count = 2 },
		},
		-- Legendary Gray Bison
		[-842852186] = {
			{ item = "beef", count = 5 },
			{ item = "legbisons", count = 1 },
		},
		-- Legendary Ota Bison
		[924402139] = {
			{ item = "beef", count = 5 },
			{ item = "legbisons", count = 1 },
		},
		-- Legendary Badger
		[-2007945778] = {
			{ item = "biggame", count = 2 },
			{ item = "leanimalskute", count = 1 },
		},
		-- Legendary Beaver
		[-1994305406] = {
			{ item = "biggame", count = 2 },
			{ item = "leanimalskute", count = 1 },
		},
		-- Legendary Muskrat
		[1454249975] = {
			{ item = "biggame", count = 2 },
			{ item = "leanimalskute", count = 1 },
		},
		-- Legendary Katata Elk
		[898796589] = {
			{ item = "deermeat", count = 4 },
			{ item = "legelk", count = 1 },
		},
		-- Legendary Cow
		[1408051722] = {
			{ item = "beef", count = 6 },
			{ item = "legcow", count = 1 },
		},
		-- Legendary Pig
		[-2145890973] = {
			{ item = "pork", count = 6 },
			{ item = "legpig", count = 1 },
		},
		-- Legendary Devon Bull
		[1043079683] = {
			{ item = "beef", count = 6 },
			{ item = "legbull", count = 1 },
		},
		-- Legendary Roanoke Ox
		[-685968821] = {
			{ item = "beef", count = 6 },
			{ item = "legox", count = 1 },
		},
		-- Legendary Giaguaro Cougar
		[-1279160793] = {
			{ item = "biggame", count = 4 },
			{ item = "legcougs", count = 1 },
		},
		-- Legendary Winyan Cougar
		[-809569142] = {
			{ item = "biggame", count = 4 },
			{ item = "legcougs", count = 1 },
		},
		-- Legendary iguga Cougar
		[-133441068] = {
			{ item = "biggame", count = 4 },
			{ item = "legcougs", count = 1 },
		},
		-- Legendary Midnight Fox
		[645735707] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legfoxs", count = 1 },
		},
		-- Legendary Bright Fox
		[-581970620] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legfoxs", count = 1 },
		},
		-- Legendary Widebarrel Fox
		[-862954331] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legfoxs", count = 1 },
		},
		-- Legendary Wight Streak Coyote
		[-969805446] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legcoyotes", count = 1 },
		},
		-- Legendary Red Streak Coyote
		[776406997] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legcoyotes", count = 1 },
		},
		-- Legendary Nightwalker Coyote
		[-1460370390] = {
			{ item = "coyotemeat", count = 4 },
			{ item = "legcoyotes", count = 1 },
		},
		-- Legendary Seacrest Wolf
		[-1238096137] = {
			{ item = "biggame", count = 4 },
			{ item = "legwolfs", count = 1 },
		},
		-- Legendary Blackheart Wolf
		[790937716] = {
			{ item = "biggame", count = 4 },
			{ item = "legwolfs", count = 1 },
		},
		-- Legendary Onyx Wolf
		[-622383060] = {
			{ item = "biggame", count = 4 },
			{ item = "legwolfs", count = 1 },
		},
		-- Legendary Paramount Bison
		--deer [1110710183] = {
		--	{ item = "beef", count = 5 },
		--	{ item = "legbisons", count = 1 },
		-- },
		-- Legendary Bluefairy Bison
		[-842852186] = {
			{ item = "beef", count = 5 },
			{ item = "legbisons", count = 1 },
		},
		-- Legendary Gray Overlord Bison
		[924402139] = {
			{ item = "beef", count = 5 },
			{ item = "legbisons", count = 1 },
		},
		-- Legendary Jackelope
		[-830944652] = {
			{ item = "game", count = 3 },
			{ item = "jegend", count = 1 },
		},
		-- Legendary Cony
		[-2050932021] = {
			{ item = "game", count = 3 },
			{ item = "jegend", count = 1 },
		},
		-- Legendary Obsidian Fish
		[-584281304] = {
			{ item = "a_c_fishchainpickerel_01_sm", count = 1 },
		},
		-- Legendary Lake Sturgeon
		[889514592] = {
			{ item = "a_c_fishlakesturgeon_01_lg", count = 1 },
		},
		-- Legendary Steelhead Trout
		[-754462656] = {
			{ item = "a_c_fishrainbowtrout_01_ms", count = 1 },
		},
		-- Legendary Western Bullhead Catfish
		[2120184051] = {
			{ item = "a_c_fishbullheadcat_01_ms", count = 1 },
		},
		-- Legendary Channel Catfish
		[-997642591] = {
			{ item = "a_c_fishchannelcatfish_01_xl", count = 1 },
		},
		-- Legendary Largemouth Bass
		[-1755537850] = {
			{ item = "a_c_fishlargemouthbass_01_ms", count = 1 },
		},
		-- Legendary Northern Pike
		[1652270150] = {
			{ item = "a_c_fishnorthernpike_01_lg", count = 1 },
		},
		-- Legendary Longnose Gar
		[11906616] = {
			{ item = "a_c_fishlongnosegar_01_lg", count = 1 },
		},
		-- Legendary Muskie
		[-2018028915] = {
			{ item = "a_c_fishmuskie_01_lg", count = 1 },
		},
		-- Legendary Perch
		[1012644445] = {
			{ item = "a_c_fishperch_01_sm", count = 1 },
		},
		-- Legendary Redfin Pickerel
		[-1191697412] = {
			{ item = "a_c_fishredfinpickerel_01_sm", count = 1 },
		},
		-- Legendary Rock Bass
		[-195293808] = {
			{ item = "a_c_fishrockbass_01_sm", count = 1 },
		},
		-- Legendary Smallmouth Bass
		[980262866] = {
			{ item = "a_c_fishsmallmouthbass_01_ms", count = 1 },
		},
		-- Legendary Sockeye Salmon
		[1036517768] = {
			{ item = "a_c_fishsalmonsockeye_01_ms", count = 1 },
		},
		-- Legendary Bluegill
		[1867262572] = { -- placeholder hash, fix if needed
			{ item = "a_c_fishbluegil_01_ms", count = 1 },
			{ item = "gold_nugget", count = 1 },
			{ item = "p_finisdfishlurelegendary01x", count = 1 },
		},
		-- Legendary Bear pelt
		[-1631768462] = {
			{ item = "biggame", count = 3 },
			{ item = "leggbears", count = 1 },
	--		{ item = "bearc", count = 1 },
		},
		--Legendary Golden Spirit Bear pelt
		[98597207] = {
			{ item = "biggame", count = 3 },
			{ item = "legbears4", count = 1 },
			{ item = "bearc", count = 1 },
		},
		--Legendary Owiza Spirit Bear pelt
		[55897452] = {
			{ item = "biggame", count = 3 },
			{ item = "legbears2", count = 1 },
			{ item = "bearc", count = 1 },
		},
		--Legendary Ridgeback Spirit Bear pelt
		[499820607] = {
			{ item = "biggame", count = 3 },
			{ item = "legbears3", count = 1 },
			{ item = "bearc", count = 1 },
		},
		--Legendary Sun Alligator
		[-829337926] = {
			{ item = "legaligators2", count = 1 },
			{ item = "aligatorto", count = 1 },
		},
		--Legendary Banded Alligator
		[-1828919758] = {
			{ item = "legaligators3", count = 1 },
			{ item = "aligatorto", count = 2 },
		},
		--Legendary Teca Alligator
		[-1804478060] = {
			{ item = "legaligators1", count = 1 },
			{ item = "aligatorto", count = 2 },
		},

		----------------------------------------------------------------
		-- MUTTON-TYPE ANIMALS (Sheep, Ram)
		----------------------------------------------------------------
		-- Sierra Nevada Ram
		[-1568716381] = {
			{ item = "mutton", count = 4 },
		},
		-- Big Horn Ram
		[728314473] = {
			{ item = "mutton", count = 4 },
		},
		-- domestic Sheep
		[-166054593] = {
			{ item = "mutton", count = 3 },
		},
        ----------------------------------------------------------------
        -- STRINGY MEAT (RACCOON / MUSKRAT / SKUNK / BADGER)
        ----------------------------------------------------------------
		-- American Badger
		[-1170118274] = {
			{ item = "stringy", count = 1 },
			{ item = "badgers", count = 1 },
		},
			
		-- Striped Skunk ($2.25 -> Tier B -> 3)
        [-1211566332] = {
            { item = "stringy", count = 1 },
        },

        -- Striped Skunk ($2.25 -> Tier B -> 3)
        [-121266332] = {
            { item = "stringy", count = 1 },
        },

        -- North American Raccoon ($2.00 -> Tier C -> 2)
		[1458540991] = {
		{ item = "stringy", count = 1 },
		{ item = "raccoont", count = 1 },
		{ item = "raccoons", count = 1 },
		},
		
		        -- North American Raccoon ($2.00 -> Tier C -> 2)
		[1783710704] = {
		{ item = "stringy", count = 1 },
		{ item = "raccoont", count = 1 },
		{ item = "raccoons", count = 1 },
		},

        -- American Muskrat ($2.25 -> Tier B -> 3)
        [-1134449699] = {
            { item = "stringy", count = 1 },
			{ item = "muskrats", count = 1 },
        },

		----------------------------------------------------------------
		-- VENISON-TYPE ANIMALS (Deer, Pronghorn, Elk, etc.)
		----------------------------------------------------------------
		-- White Tail Deer
		[-1853957575] = {
			{ item = "venison", count = 4 },
		},
		        -- Whitetail Buck ($3.15 -> Tier B -> 3)
        [-1963605336] = {
            { item = "venison", count = 2 },
        },
		-- Black Tail Deer
		[1340914825] = {
			{ item = "venison", count = 4 },
		},
		-- Pronghorn Antelope
		[1584468323] = {
			{ item = "venison", count = 4 },
		},
		-- Rocky Mountain Elk
		[-18239340] = {
			{ item = "venison", count = 5 },
		},
		-- American Pronghorn
		[1466150167] = {
			{ item = "venison", count = 4 },
		},
		        -- American Pronghorn Doe ($3.75 -> Tier A -> 4)
        [1755643085] = {
            { item = "venison", count = 4 },
        },

  ----------------------------------------------------------------
        -- BIRD MEAT (ALL BIRDS THAT NORMALLY GIVE FEATHERS)
        ----------------------------------------------------------------

        -- Duck ($1.65 -> Tier C -> 2)
        [-1003616053] = {
            { item = "bird", count = 1 },
        },

        -- Eagles / Egrets (high-ish but still birds, keep 1)
        [1459778951] = {                    -- Eagle
            { item = "bird", count = 1 },
        },
        [831859211] = {                     -- Egret
            { item = "bird", count = 1 },
        },

        -- Vulture (~2.5–2.75 -> Tier B -> 3)
        [1104697660] = {
            { item = "bird", count = 1 },
			{ item = "condorf", count = 2 },
			{ item = "condorb", count = 1 },
        },

  --       Turkeys ($2.0 -> Tier C -> 2)
        [-466054788] = {                    -- Wild Turkey
            { item = "bird", count = 1 },
			{ item = "turkeyf", count = 1 },
			{ item = "turkeyb", count = 1 },
        },
        [-2011226991] = {                   -- Wild Turkey
            { item = "bird", count = 1 },
			{ item = "turkeyf", count = 1 },
			{ item = "turkeyb", count = 1 },
        },
        [-166054593] = {                    -- Wild Turkey
            { item = "bird", count = 1 },
			{ item = "turkeyf", count = 1 },
			{ item = "turkeyb", count = 1 },
        },

        -- Herring Seagull (~1.5 -> Tier C -> 2)
        [-164963696] = {
            { item = "bird", count = 1 },
			{ item = "seagullf", count = 1 },
			{ item = "seagullb", count = 1 },
        },

        -- Roseate Spoonbill (~2.5 -> Tier B -> 3)
        [-1076508705] = {
            { item = "bird", count = 1 },
			{ item = "rspoonf", count = 1 },
			{ item = "rspoonb", count =1 },
        },

        -- Dominique Rooster (small/cheap -> 1–2, we keep 2 for fun)
        [2023522846] = {
            { item = "bird", count = 1 },
			{ item = "cockf", count = 1 },
			{ item = "cockc", count = 1 },
        },

        -- Red-Footed Booby (~2.0+ -> 2)
        [-466687768] = {
            { item = "bird", count = 1 },
			{ item = "boobyf", count = 1 },
			{ item = "boobyb", count = 1 },
        },

        -- Raven ($1.75 -> Tier C -> 2)
        [-575340245] = {
            { item = "bird", count = 1 },
			{ item = "ravenf", count = 1 },
			{ item = "ravenc", count = 1 },
        },

        -- Greater Prairie Chicken ($1.0 -> Tier D -> 1)
        [2079703102] = {
            { item = "bird", count = 1 },
			{ item = "prairif", count = 1 },
			{ item = "prairib", count = 1 },
        },

        -- Ring-Necked Pheasant ($1.25 -> border C/D -> 2)
        [1416324601] = {
            { item = "bird", count = 1 },
			{ item = "peasantf", count = 1 },
			{ item = "peasantb", count = 1 },
        },
		-- California Condor
		[2105463796] = {
			{ item = "bird", count = 1 },
			{ item = "condorf", count = 2 },
		},
        -- American White Pelican ($1.5 -> Tier C -> 2)
        [1265966684] = {
            { item = "bird", count = 1 },
			{ item = "pelicanf", count = 1 },
			{ item = "pelicanb", count = 1 },
        },

        -- Blue And Yellow Macaw (exotic bird, treat as 2)
        [-1797450568] = {
            { item = "bird", count = 1 },
        },

        -- Californian Condor (~2.75 -> Tier B -> 3)
        [120598262] = {
            { item = "bird", count = 1 },
			{ item = "kcondorf", count = 1 },
			{ item = "kcondorb", count = 1 },
        },

        -- Dominique Chicken (similar to rooster)
        [-2063183075] = {
            { item = "bird", count = 1 },
			{ item = "chickenf", count = 1 },
			{ item = "chickenheart", count = 1 },
        },

        -- Double-Crested Cormorant (~2.0 -> Tier C -> 2)
        [-2073130256] = {
            { item = "bird", count = 1 },
			{ item = "bbirdf", count = 1},
			{ item = "bbirdb", count = 1},
        },

        -- Whooping Crane ($2.75 -> Tier B -> 3)
        [-564099192] = {
            { item = "bird", count = 1 },
			{ item = "daruf", count = 1 },
			{ item = "darub", count = 1 },
        },

        -- Canada Goose ($2.75 -> Tier B -> 3)
        [723190474] = {
            { item = "bird", count = 1 },
			{ item = "goosef", count = 1 },
			{ item = "gooseb", count = 1 },
        },

        -- Ferruginous Hawk (~2.5 -> Tier B -> 3)
        [-2145890973] = {
            { item = "bird", count = 1 },
			{ item = "hawkf", count = 1 },
			{ item = "hawkt", count = 1 },
        },

        -- Great Blue Heron (~2.5 -> Tier B -> 3)
        [1095117488] = {
            { item = "bird", count = 1 },
			{ item = "kbirdf", count = 1 },
			{ item = "kbirdb", count = 1 },
        },

        -- Common Loon (~2.0 -> Tier C -> 2)
        [386506078] = {
            { item = "bird", count = 1 },
			{ item = "loonf", count = 1 },
			{ itme = "loonb", count = 1 },
        },

        -- Great Horned Owl (~2.0 -> Tier C -> 2)
        [-86244272] = {
            { item = "bird", count = 1 },
			{ item = "owlf", count = 1 },
			{ item = "owlt", count = 1 },
        },
		----------------------------------------------------------------
		-- PORK-TYPE ANIMALS (Boar, Pig)
		----------------------------------------------------------------
		-- Wild Boar
		[-1003616053] = {
			{ item = "pork", count = 4 },
		},
		-- Domestic Pig
		[758696332] = {
			{ item = "pork", count = 4 },
		},

		----------------------------------------------------------------
		-- BEEF-TYPE ANIMALS (Cow, Bison, Bull, Ox)
		----------------------------------------------------------------
		-- Domestic Cow
		[1408051722] = {
			{ item = "beef", count = 6 },
			{ item = "cows", count = 1 },
		},
		-- Bison
		[1556473961] = {
			{ item = "beef", count = 6 },
			{ item = "bisons", count = 1 },
		},
		-- Bison Pelt American
		[213792403] = {
			{ item = "beef", count = 6 },
			{ item = "bisons", count = 1 },
		},
		-- Devon Bull
		[1043079683] = {
			{ item = "bullhorn", count = 2 },
			{ item = "beef", count = 6 },
			{ item = "bulls", count = 1},
		},
		-- Roanoke Ox
		[-685968821] = {
			{ item = "beef", count = 6 },
			{ item = "oxs", count = 1 },
		},

		----------------------------------------------------------------
		-- FISH (Standard non-legendary fish)
		----------------------------------------------------------------
		-- Chain Pickerel
		[-1841279810] = {
			{ item = "a_c_fishchainpickerel_01_sm", count = 1 },
		},
		-- Lake Sturgeon
		[889514592] = {
			{ item = "a_c_fishlakesturgeon_01_lg", count = 1 },
		},
		-- Steelhead Trout
		[-754462656] = {
			{ item = "a_c_fishrainbowtrout_01_ms", count = 1 },
		},
		-- Western Bullhead Catfish
		[2120184051] = {
			{ item = "a_c_fishbullheadcat_01_ms", count = 1 },
		},
		-- Channel Catfish
		[-997642591] = {
			{ item = "a_c_fishchannelcatfish_01_xl", count = 1 },
		},
		-- Largemouth Bass
		[-1755537850] = {
			{ item = "a_c_fishlargemouthbass_01_ms", count = 1 },
		},
		-- Northern Pike
		[1652270150] = {
			{ item = "a_c_fishnorthernpike_01_lg", count = 1 },
		},
		-- Longnose Gar
		[11906616] = {
			{ item = "a_c_fishlongnosegar_01_lg", count = 1 },
		},
		-- Muskie
		[-2018028915] = {
			{ item = "a_c_fishmuskie_01_lg", count = 1 },
		},
		-- Perch
		[1012644445] = {
			{ item = "a_c_fishperch_01_sm", count = 1 },
		},
		-- Redfin Pickerel
		[-1191697412] = {
			{ item = "a_c_fishredfinpickerel_01_sm", count = 1 },
		},
		-- Rock Bass
		[-195293808] = {
			{ item = "a_c_fishrockbass_01_sm", count = 1 },
		},
		-- Smallmouth Bass
		[980262866] = {
			{ item = "a_c_fishsmallmouthbass_01_ms", count = 1 },
		},
		-- Sockeye Salmon
		[1036517768] = {
			{ item = "a_c_fishsalmonsockeye_01_ms", count = 1 },
		},
    },

    requireDead   = true,
    requireCarried = true,
}


-- =====================================
--  SERVER-SIDE CODE (server_hunting.lua)
-- =====================================
if IsDuplicityVersion() then
    local Core          = exports.vorp_core:GetCore()
    local vorpInventory = exports.vorp_inventory:vorp_inventoryApi()

    -- Build a combined key "modelHash:outfitIndex"
    local function makeOutfitKey(model, outfitIndex)
        if not model or outfitIndex == nil then
            return nil
        end
        return tostring(model) .. ":" .. tostring(outfitIndex)
    end

    -- Look up rewards for a given model hash (+ optional outfit index)
    local function getRewardsForModel(model, outfitIndex)
        if not HuntingConfig or not HuntingConfig.rewards then
            return nil
        end

        local rewardsTable = HuntingConfig.rewards

        -- 1) Try model+outfit override if we have an outfit
        local key = makeOutfitKey(model, outfitIndex)
        if key and rewardsTable[key] then
            return rewardsTable[key]
        end

        -- 2) Fallback: plain model-only rewards
        return rewardsTable[model]
    end

    local function prettifyItemName(item)
        item = tostring(item or "")
        item = item:gsub("_", " ")
        return item:gsub("^%l", string.upper)
    end

    -- Try to get the VORP label from the DB; fall back to prettified name
    local function getItemLabel(itemName)
        itemName = tostring(itemName or "")

        -- 1) Newer vorp_inventory export: getServerItem
        local ok, data = pcall(function()
            if exports.vorp_inventory and exports.vorp_inventory.getServerItem then
                return exports.vorp_inventory:getServerItem(itemName)
            end
        end)

        if ok and data and data.label then
            return data.label
        end

        -- 2) Older API: vorpInventory.getDBItem, if present
        if vorpInventory and vorpInventory.getDBItem then
            local ok2, data2 = pcall(function()
                -- src isn't used for DB lookup, 0 is fine
                return vorpInventory.getDBItem(0, itemName)
            end)

            if ok2 and data2 and data2.label then
                return data2.label
            end
        end

        -- 3) Fallback: prettified item name
        return prettifyItemName(itemName)
    end

    -- Give items and build a readable summary string
    local function giveMeatToPlayer(source, rewards)
        local parts = {}

        for _, r in ipairs(rewards) do
            if r.item and r.count and r.count > 0 then
                vorpInventory.addItem(source, r.item, r.count)

                local itemName = tostring(r.item)
                local label    = r.display or getItemLabel(itemName)
                table.insert(parts, string.format("%dx %s", r.count, label))
            end
        end

        if #parts > 0 then
            return table.concat(parts, ", ")
        end

        return nil
    end

    -- Fired from client when a carcass/pelt is picked up
    RegisterNetEvent("coal_hunting:PickedUpCarcass")
    AddEventHandler("coal_hunting:PickedUpCarcass", function(netId, model, outfitIndex)
        local src = source
        model = tonumber(model) or model

        local rewards = getRewardsForModel(model, outfitIndex)

        if not rewards then
            local msg = ("[coal_hunting] No rewards configured for model hash: %s")
                :format(tostring(model))
            print(msg)
            TriggerClientEvent("vorp:TipRight", src,
                "No hunting rewards configured for this carcass (model " .. tostring(model) .. ")",
                4000
            )
            TriggerClientEvent("coal_debugger:rewardLog", src, msg)
            return
        end

        -- delete request goes out immediately (client already waits before actually deleting)
        if netId then
            TriggerClientEvent("coal_hunting:ClientDeleteCarcass", -1, netId)
        end

        -- now delay the reward / tip / debugger log by ~1 second
        CreateThread(function()
            Wait(1000)

            local summary = giveMeatToPlayer(src, rewards)

            local msg
            if summary then
                msg = ("[coal_hunting] Gave to %s from model %s: %s")
                    :format(tostring(src), tostring(model), tostring(summary))
                TriggerClientEvent("vorp:TipRight", src, "You collected: " .. summary, 4000)
            else
                msg = ("[coal_hunting] Gave nothing to %s from model %s")
                    :format(tostring(src), tostring(model))
                TriggerClientEvent("vorp:TipRight", src, "", 4000)
            end

            print(msg)
            TriggerClientEvent("coal_debugger:rewardLog", src, msg)
        end)
    end)

-- =====================================
--  CLIENT-SIDE CODE (client_hunting.lua)
-- =====================================
else
    local Core = exports.vorp_core:GetCore()

    local DECOR_OUTFIT       = "coal_outfitPreset"
    local lastCarriedEntity  = 0

    DecorRegister(DECOR_OUTFIT, 3) -- int

    local function isPedCarryingSomething(ped)
        -- IS_PED_CARRYING_SOMETHING
        return Citizen.InvokeNative(0xA911EE21EDF69DAF, ped)
    end

    local function getCarriedEntity(ped)
        -- GET_CARRIED_ATTACHED_ENTITY
        return Citizen.InvokeNative(0xD806CD2A4F2C2996, ped, 0)
    end

    CreateThread(function()
        while true do
            Wait(250)

            local ped = PlayerPedId()

            if isPedCarryingSomething(ped) then
                local ent = getCarriedEntity(ped)

                if ent ~= 0 and DoesEntityExist(ent) then
                    if ent ~= lastCarriedEntity then
                        lastCarriedEntity = ent

                        -- Only try to get a net ID if the entity is actually networked
                        local isNetworked = Citizen.InvokeNative(0xC7827959479DCC78, ent) -- NETWORK_GET_ENTITY_IS_NETWORKED
                        local netId = nil
                        if isNetworked then
                            netId = NetworkGetNetworkIdFromEntity(ent)
                        else
                            netId = 0 -- we'll use the fallback delete path for non-networked entities
                        end

                        local model = GetEntityModel(ent)

                        -- Try to read an outfit preset that was stored on the ped
                        local outfitIndex = nil
                        if DecorExistOn(ent, DECOR_OUTFIT) then
                            outfitIndex = DecorGetInt(ent, DECOR_OUTFIT)
                        end

                        TriggerEvent("coal_debugger:log",
                            ("[coal_hunting] Now carrying entity: netId=%s, model=%s, outfit=%s")
                            :format(tostring(netId), tostring(model), tostring(outfitIndex))
                        )

                        TriggerServerEvent("coal_hunting:PickedUpCarcass", netId, model, outfitIndex)
                    end
                end
            else
                -- Not carrying anything
                lastCarriedEntity = 0
            end
        end
    end)

    RegisterNetEvent("coal_hunting:ClientDeleteCarcass")
    AddEventHandler("coal_hunting:ClientDeleteCarcass", function(netId)
        -- capture current values so they don't change while we wait
        local thisNetId = netId
        local thisLast  = lastCarriedEntity

        CreateThread(function()
            -- wait 1 second before removing the body
            Wait(1000)

            local ent = nil

            -- Try via network ID first (works for networked props/peds)
            if thisNetId and thisNetId ~= 0 then
                ent = NetworkGetEntityFromNetworkId(thisNetId)
                if ent ~= 0 and DoesEntityExist(ent) then
                    TriggerEvent("coal_debugger:log",
                        ("[coal_hunting] Deleting carcass by netId=%s (entity=%s)")
                        :format(tostring(thisNetId), tostring(ent))
                    )

                    DeleteEntity(ent)
                    return
                end
            end

            -- Fallback: use the last carried entity (covers local-only entities like some animals)
            if thisLast ~= 0 and DoesEntityExist(thisLast) then
                TriggerEvent("coal_debugger:log",
                    ("[coal_hunting] Deleting carcass using fallback lastCarriedEntity=%s")
                    :format(tostring(thisLast))
                )

                DeleteEntity(thisLast)

                -- only clear if it's still the current one
                if thisLast == lastCarriedEntity then
                    lastCarriedEntity = 0
                end
            else
                TriggerEvent("coal_debugger:log",
                    ("[coal_hunting] Failed to delete carcass (netId=%s) – no valid entity found")
                    :format(tostring(thisNetId))
                )
            end
        end)
    end)
end
