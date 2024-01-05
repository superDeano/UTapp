//
//  Clubs.swift
//  UT
//
//  Created by Dean Chong San on 2024-01-04.
//

import Foundation

struct Clubs {
    
    static let teams = [
        "1": "Arsenal",
        "2": "Aston Villa",
        "3": "Blackburn Rovers",
        "4": "Bolton Wanderers",
        "5": "Chelsea",
        "7": "Everton",
        "8": "Leeds United",
        "9": "Liverpool",
        "10": "Manchester City",
        "11": "Manchester United",
        "12": "Middlesbrough",
        "13": "Newcastle United",
        "14": "Nottingham Forest",
        "15": "Queens Park Rangers",
        "17": "Southampton",
        "18": "Tottenham Hotspur",
        "19": "West Ham United",
        "21": "Bayern München",
        "22": "Borussia Dortmund",
        "23": "Borussia M'gladbach",
        "25": "SC Freiburg",
        "27": "Hansa Rostock",
        "28": "Hamburger SV",
        "29": "1. FC Kaiserslautern",
        "31": "1. FC Köln",
        "32": "Bayer 04 Leverkusen",
        "33": "TSV 1860 München",
        "34": "FC Schalke 04",
        "36": "VfB Stuttgart",
        "38": "Werder Bremen",
        "44": "Inter",
        "47": "Milan",
        "48": "Napoli",
        "50": "Parma",
        "54": "Torino",
        "55": "Udinese",
        "57": "AJ Auxerre",
        "58": "Sporting Club de Bastia",
        "59": "Girondins de Bordeaux",
        "62": "En Avant Guingamp",
        "64": "RC Lens",
        "65": "LOSC Lille",
        "66": "Olympique Lyonnais",
        "68": "FC Metz",
        "69": "AS Monaco",
        "70": "Montpellier HSC",
        "71": "FC Nantes",
        "72": "OGC Nice",
        "73": "Paris Saint-Germain",
        "74": "Stade Rennais",
        "76": "RC Strasbourg",
        "77": "Aberdeen",
        "78": "Celtic",
        "80": "Heart of Midlothian",
        "81": "Hibernian",
        "83": "Motherwell",
        "86": "Rangers",
        "88": "Birmingham City",
        "89": "Charlton Athletic",
        "91": "Derby County",
        "94": "Ipswich Town",
        "95": "Leicester City",
        "97": "Millwall",
        "106": "Sunderland",
        "109": "West Bromwich Albion",
        "110": "Wolverhampton Wanderers",
        "121": "Crewe Alexandra",
        "127": "Shrewsbury Town",
        "142": "Doncaster Rovers",
        "143": "Exeter City",
        "144": "Fulham",
        "149": "Lincoln City",
        "159": "Arminia Bielefeld",
        "160": "VfL Bochum",
        "165": "SpVgg Greuther Fürth",
        "166": "Hertha BSC",
        "169": "1. FSV Mainz 05",
        "171": "1. FC Nürnberg",
        "175": "VfL Wolfsburg",
        "180": "Dundee FC",
        "181": "Dundee United",
        "189": "Bologna",
        "191": "RB Salzburg",
        "205": "Venezia",
        "206": "Hellas Verona",
        "209": "Sturm Graz",
        "210": "SM Caen",
        "211": "Dinamo Zagreb",
        "217": "FC Lorient",
        "219": "Olympique de Marseille",
        "224": "Nîmes Olympique",
        "226": "FC Sochaux",
        "229": "Anderlecht",
        "230": "Antwerp",
        "231": "Club Brugge",
        "232": "Standard Liège",
        "234": "SL Benfica",
        "236": "FC Porto",
        "237": "Sporting CP",
        "240": "Atlético de Madrid",
        "241": "FC Barcelona",
        "243": "Real Madrid",
        "244": "Real Zaragoza",
        "245": "Ajax",
        "246": "Feyenoord",
        "247": "PSV",
        "252": "LASK",
        "254": "Rapid Wien",
        "256": "Austria Wien",
        "260": "CD Tenerife",
        "263": "Hajduk Split",
        "266": "Slavia Praha",
        "267": "Sparta Praha",
        "271": "Aarhus GF",
        "272": "Odense Boldklub",
        "278": "AEK",
        "280": "Olympiacos",
        "294": "ESTAC Troyes",
        "298": "Rosenborg BK",
        "299": "Lillestrom SK",
        "300": "Viking FK",
        "305": "Bohemians",
        "306": "Shamrock Rovers",
        "308": "Universitatea Craiova",
        "310": "FC Rapid",
        "315": "CSKA Moskva",
        "319": "IFK Göteborg",
        "320": "Malmö FF",
        "321": "Halmstads BK",
        "322": "Grasshopper Club Zurich",
        "324": "Servette FC",
        "325": "Galatasaray",
        "326": "Fenerbahçe",
        "327": "Beşiktaş",
        "347": "Lecce",
        "357": "Morecambe",
        "361": "Stevenage",
        "378": "Stade Brestois 29",
        "379": "Stade de Reims",
        "381": "Barrow",
        "383": "Palmeiras",
        "393": "PAOK",
        "417": "Molde FK",
        "418": "Tromso IL",
        "420": "Górnik Zabrze",
        "423": "St. Patrick's Athletic",
        "433": "AIK",
        "436": "Trabzonspor",
        "445": "Derry City",
        "448": "Athletic Club de Bilbao",
        "449": "Real Betis Balompié",
        "450": "RC Celta de Vigo",
        "452": "RCD Espanyol",
        "453": "RCD Mallorca",
        "457": "Real Sociedad",
        "459": "Real Sporting de Gijón",
        "461": "Valencia CF",
        "462": "Real Valladolid",
        "463": "Deportivo Alavés",
        "467": "SD Eibar",
        "468": "Elche CF",
        "472": "UD Las Palmas",
        "479": "CA Osasuna",
        "480": "Rayo Vallecano",
        "481": "Sevilla FC",
        "483": "Villarreal CF",
        "485": "Hannover 96",
        "487": "VfL Osnabrück",
        "492": "SV Wehen Wiesbaden",
        "503": "Dynamo Dresden",
        "506": "Erzgebirge Aue",
        "523": "1. FC Saarbrücken",
        "543": "Jahn Regensburg",
        "561": "Forest Green Rovers",
        "563": "Sligo Rovers",
        "567": "Fluminense",
        "573": "Málaga CF",
        "576": "Holstein Kiel",
        "598": "Sao Paulo",
        "605": "Al Hilal",
        "607": "Al Ittihad",
        "614": "AC Ajaccio",
        "621": "Livingston",
        "631": "Ross County",
        "634": "Fortuna Sittard",
        "647": "SC Cambuur",
        "670": "Charleroi",
        "673": "Genk",
        "674": "Gent",
        "675": "Beerschot",
        "680": "Sint-Truiden",
        "682": "Oostende",
        "687": "Columbus Crew SC",
        "688": "D.C. United",
        "689": "New York Red Bulls",
        "691": "New England Revolution",
        "693": "Chicago Fire FC",
        "694": "Colorado Rapids",
        "695": "FC Dallas",
        "696": "Sporting KC",
        "697": "Los Angeles Galaxy",
        "698": "Houston Dynamo",
        "700": "IF Elfsborg",
        "702": "IFK Norrköping",
        "705": "Örebro SK",
        "708": "Hammarby IF",
        "710": "Djurgårdens IF",
        "711": "BK Häcken",
        "741": "Antalyaspor",
        "753": "Waterford FC",
        "780": "SV Ried",
        "819": "FC København",
        "820": "Aalborg BK",
        "822": "Vejle BK",
        "837": "Dundalk FC",
        "873": "Lech Poznań",
        "894": "FC Zürich",
        "896": "FC Basel",
        "897": "FC Luzern",
        "898": "FC St. Gallen",
        "900": "BSC Young Boys",
        "917": "Stabæk Fotball",
        "918": "FK Bodø/Glimt",
        "919": "SK Brann",
        "920": "Vålerenga Fotball",
        "922": "Strømsgodset Toppfotball",
        "981": "Seongnam FC",
        "982": "FC Seoul",
        "983": "Suwon Bluewings",
        "1013": "San Lorenzo de Almagro",
        "1032": "Monterrey",
        "1035": "Atlético Mineiro",
        "1039": "Club Athletico Paranaense",
        "1041": "Sport Club Corinthians Paulista",
        "1043": "Flamengo",
        "1048": "Internacional",
        "1053": "Santos",
        "1438": "Santa Clara",
        "1439": "Kalmar FF",
        "1443": "Viborg FF",
        "1447": "SønderjyskE",
        "1456": "Odds Ballklubb",
        "1463": "FK Haugesund",
        "1473": "Ulsan Hyundai",
        "1474": "Pohang Steelers",
        "1477": "Jeonbuk Hyundai Motors",
        "1478": "Jeju United FC",
        "1480": "Carlisle United",
        "1516": "FC Midtjylland",
        "1530": "Angers SCO",
        "1569": "Wisła Płock",
        "1572": "Drogheda United",
        "1586": "Longford Town",
        "1598": "Bahia",
        "1629": "Gremio",
        "1738": "Le Havre AC",
        "1746": "Empoli",
        "1750": "Cercle Brugge",
        "1757": "Sandefjord Fotball",
        "1786": "Randers FC",
        "1787": "SK Austria Klagenfurt",
        "1788": "FC Nordsjælland",
        "1790": "Portsmouth",
        "1792": "Norwich City",
        "1793": "Reading",
        "1794": "Sheffield United",
        "1795": "Watford",
        "1796": "Burnley",
        "1797": "Rotherham United",
        "1798": "Milton Keynes Dons",
        "1799": "Crystal Palace",
        "1800": "Coventry City",
        "1801": "Preston North End",
        "1802": "Gillingham",
        "1803": "Walsall",
        "1804": "Bradford City",
        "1805": "Grenoble Foot 38",
        "1806": "Stoke City",
        "1807": "Sheffield Wednesday",
        "1808": "Brighton & Hove Albion",
        "1809": "Toulouse FC",
        "1813": "Chamois Niortais FC",
        "1815": "Clermont Foot",
        "1816": "Amiens SC",
        "1819": "AS Saint-Étienne",
        "1823": "AS Nancy",
        "1824": "Eintracht Frankfurt",
        "1825": "MSV Duisburg",
        "1831": "1. FC Union Berlin",
        "1832": "Karlsruher SC",
        "1837": "Sampdoria",
        "1842": "Cagliari",
        "1853": "Levante UD",
        "1860": "Getafe CF",
        "1861": "UD Almería",
        "1862": "FC Lausanne-Sport",
        "1871": "Legia Warszawa",
        "1873": "Wisła Kraków",
        "1874": "Ferencvarosi TC",
        "1876": "River Plate",
        "1877": "Boca Juniors",
        "1878": "Cruz Azul",
        "1879": "América",
        "1880": "Guadalajara",
        "1881": "Pumas U.N.A.M.",
        "1882": "Toluca",
        "1884": "Panathinaikos",
        "1887": "Vitória Guimarães",
        "1888": "Gil Vicente FC",
        "1889": "Belenenses",
        "1892": "Paços de Ferreira",
        "1893": "Marítimo",
        "1896": "Braga",
        "1898": "Boavista",
        "1900": "Moreirense",
        "1903": "FC Utrecht",
        "1905": "RKC Waalwijk",
        "1906": "AZ",
        "1907": "Willem II",
        "1908": "FC Twente",
        "1909": "Vitesse",
        "1910": "N.E.C. Nijmegen",
        "1913": "sc Heerenveen",
        "1914": "PEC Zwolle",
        "1915": "FC Groningen",
        "1917": "Wigan Athletic",
        "1919": "Bristol City",
        "1920": "Oldham Athletic",
        "1923": "Luton Town",
        "1925": "Brentford",
        "1926": "Blackpool",
        "1928": "Port Vale",
        "1929": "Plymouth Argyle",
        "1930": "Northampton Town",
        "1932": "Barnsley",
        "1933": "Wycombe Wanderers",
        "1934": "Swindon Town",
        "1935": "Colchester United",
        "1936": "Cheltenham Town",
        "1938": "Peterborough United",
        "1939": "Huddersfield Town",
        "1940": "Mansfield Town",
        "1941": "Hartlepool United",
        "1943": "Bournemouth",
        "1944": "Cambridge United",
        "1947": "Wrexham AFC",
        "1949": "Scunthorpe United",
        "1951": "Oxford United",
        "1952": "Hull City",
        "1955": "Rochdale",
        "1958": "Leyton Orient",
        "1960": "Swansea City",
        "1961": "Cardiff City",
        "1962": "Bristol Rovers",
        "1968": "Cádiz CF",
        "1970": "Tigres U.A.N.L.",
        "2013": "Eupen",
        "2014": "Royale Union Saint-Gilloise",
        "2017": "Hartberg",
        "2023": "SD Ponferradina",
        "2056": "Daegu FC",
        "10020": "Estoril Praia",
        "10029": "TSG 1899 Hoffenheim",
        "10030": "SC Paderborn 07",
        "10031": "Portimonense",
        "10032": "FC Lugano",
        "10846": "Burgos CF",
        "15005": "Zulte Waregem",
        "15009": "Altach",
        "15015": "Burton Albion",
        "15040": "WSG Tirol",
        "15048": "Tranmere Rovers",
        "100081": "Kortrijk",
        "100087": "OH Leuven",
        "100135": "Apoel FC",
        "100325": "HJK Helsinki",
        "100409": "FC Augsburg",
        "100632": "Go Ahead Eagles",
        "100634": "Heracles Almelo",
        "100646": "Sparta Rotterdam",
        "100757": "Dinamo București",
        "100759": "FC Argeș",
        "100761": "FCSB",
        "100765": "Lokomotiv Moskva",
        "100767": "Spartak Moskva",
        "100804": "St. Johnstone",
        "100805": "St. Mirren",
        "100831": "AD Alcorcón",
        "100851": "FC Cartagena",
        "100888": "CD Leganés",
        "101006": "Altay SK",
        "101014": "Istanbul Başakşehir FK",
        "101016": "Adana Demirspor",
        "101020": "Kayserispor",
        "101026": "Göztepe",
        "101028": "Hatayspor",
        "101033": "Konyaspor",
        "101037": "Çaykur Rizespor",
        "101041": "Sivasspor",
        "101047": "Dynamo Kyiv",
        "101059": "Shakhtar Donetsk",
        "101083": "Estudiantes de La Plata",
        "101084": "Gimnasia y Esgrima La Plata",
        "101085": "Racing Club de Avellaneda",
        "101088": "Vélez Sarsfield",
        "101099": "América de Cali",
        "101100": "Atlético Nacional",
        "101101": "Junior de Barranquilla",
        "101102": "Deportivo Cali",
        "101104": "Club Independiente Santa Fe",
        "101108": "Olimpia Asunción",
        "101110": "Peñarol",
        "101112": "Vancouver Whitecaps",
        "101114": "Atlas",
        "101121": "Necaxa",
        "101145": "Kashiwa Reysol",
        "101146": "Vissel Kobe",
        "101147": "Kashima Antlers",
        "101148": "Cerezo Osaka",
        "101149": "Shimizu S-Pulse",
        "101150": "FC Tokyo",
        "101151": "Yokohama F·Marinos",
        "110062": "Girona FC",
        "110065": "CF Fuenlabrada",
        "110069": "CD Mirandés",
        "110075": "FC Farul Constanta",
        "110093": "Independiente",
        "110144": "Santos Laguna",
        "110147": "Pachuca",
        "110150": "Gallos Blancos de Querétaro",
        "110152": "Puebla",
        "110178": "SV Sandhausen",
        "110197": "Würzburger Kickers",
        "110313": "Accrington Stanley",
        "110321": "Pau FC",
        "110329": "FC St. Pauli",
        "110373": "Salernitana",
        "110374": "Fiorentina",
        "110394": "Arsenal de Sarandí",
        "110395": "Lanús",
        "110396": "Newell's Old Boys",
        "110404": "Banfield",
        "110406": "Colón",
        "110456": "Valenciennes FC",
        "110468": "Viktoria Plzeň",
        "110482": "Hallescher FC",
        "110500": "Eintracht Braunschweig",
        "110501": "SC Verl",
        "110502": "SV Darmstadt 98",
        "110532": "SV Waldhof Mannheim",
        "110556": "Genoa",
        "110565": "Gornik Leczna",
        "110569": "Dijon FCO",
        "110580": "Rosario Central",
        "110581": "Patronato",
        "110588": "1. FC Magdeburg",
        "110592": "FSV Zwickau",
        "110597": "SV Meppen",
        "110636": "Fortuna Düsseldorf",
        "110645": "Viktoria Köln",
        "110676": "Borussia Dortmund II",
        "110678": "TSV Havelse",
        "110691": "SC Freiburg II",
        "110711": "Real Sociedad B",
        "110724": "KV Mechelen",
        "110734": "Crotone",
        "110745": "Jagiellonia Białystok",
        "110746": "Pogoń Szczecin",
        "110747": "Cracovia Kraków",
        "110749": "Zagłębie Lubin",
        "110750": "UTA Arad",
        "110752": "FC Botoșani",
        "110765": "Incheon United",
        "110770": "FC Sion",
        "110776": "Gaziantep FK",
        "110781": "León",
        "110799": "Sutton United",
        "110827": "Real Oviedo",
        "110831": "CD Lugo",
        "110832": "Granada CF",
        "110839": "SD Huesca",
        "110890": "Crawley Town",
        "110929": "Kaizer Chiefs",
        "110930": "Orlando Pirates",
        "110955": "Shanghai Greenland Shenhua",
        "110968": "Club Bolívar",
        "110969": "Club The Strongest",
        "110974": "Jorge Wilstermann",
        "110975": "Universidad Católica",
        "110978": "Club de Deportes Cobresal",
        "110981": "Barcelona Guayaquil",
        "110984": "Emelec",
        "110986": "LDU Quito",
        "110987": "SD Aucas",
        "110990": "Deportivo Tachira FC",
        "110992": "AC Mineros de Guayana",
        "111002": "Centro Atlético Fénix",
        "111007": "12 de Octubre FC",
        "111008": "Club Libertad",
        "111013": "Club Sporting Cristal",
        "111014": "Club Universitario de Deportes",
        "111019": "Argentinos Juniors",
        "111041": "Juventude",
        "111052": "Fortaleza",
        "111059": "Ceara Sporting Club",
        "111065": "Real Salt Lake",
        "111086": "Piast Gliwice",
        "111088": "Radomiak Radom",
        "111091": "Lechia Gdańsk",
        "111092": "Śląsk Wrocław",
        "111117": "Fatih Karagümrük S.K.",
        "111131": "Finn Harps",
        "111138": "Minnesota United FC",
        "111139": "Montreal Impact",
        "111140": "Portland Timbers",
        "111144": "Seattle Sounders",
        "111235": "1. FC Heidenheim",
        "111239": "FC Ingolstadt 04",
        "111276": "USL Dunkerque",
        "111325": "Nacional de Montevideo",
        "111327": "Huachipato",
        "111328": "Club Deportivo Palestino",
        "111334": "Melgar FBC",
        "111339": "Kasımpaşa",
        "111393": "Adelaide United",
        "111395": "Brisbane Roar",
        "111396": "Central Coast Mariners",
        "111397": "Melbourne Victory",
        "111398": "Newcastle Jets",
        "111399": "Perth Glory",
        "111400": "Sydney FC",
        "111539": "FC Vizela",
        "111575": "Urawa Reds",
        "111629": "SC East Bengal",
        "111651": "Toronto FC",
        "111659": "Rodez Aveyron Football",
        "111674": "Al Shabab",
        "111678": "Club Tijuana",
        "111701": "Al Ain FC",
        "111706": "Godoy Cruz",
        "111707": "Aldosivi",
        "111708": "Atlético Tucumán",
        "111710": "Defensa y Justicia",
        "111711": "Huracán",
        "111716": "Unión de Santa Fé",
        "111722": "Club Deportes Tolima",
        "111723": "Deportivo Pasto",
        "111724": "Shandong Luneng Taishan",
        "111730": "Kawasaki Frontale",
        "111766": "Wellington Phoenix",
        "111768": "Beijing Sinobo Guoan",
        "111769": "Changchun Yatai FC",
        "111773": "Shenzhen Kaisa FC",
        "111774": "Tianjin TEDA F.C.",
        "111779": "Henan Jianye F.C.",
        "111811": "AC Monza",
        "111817": "Paris FC",
        "111821": "Admira Wacker",
        "111822": "Wolfsberger AC",
        "111839": "Guangzhou Evergrande Taobao",
        "111928": "San Jose Earthquakes",
        "111974": "Sassuolo",
        "112026": "Benevento",
        "112072": "Mjällby AIF",
        "112092": "Nagoya Grampus",
        "112093": "Gamba Osaka",
        "112096": "Al Ettifaq",
        "112115": "Gangwon FC",
        "112119": "Atlético Goianiense",
        "112120": "GZT Giresunspor",
        "112134": "Philadelphia Union",
        "112139": "Al Nassr",
        "112165": "Chongqing SWM F.C.",
        "112172": "RB Leipzig",
        "112199": "Sarpsborg 08",
        "112222": "Harrogate Town",
        "112224": "Melbourne City",
        "112254": "Newport County",
        "112258": "Gwangju FC",
        "112259": "AFC Wimbledon",
        "112260": "Fleetwood Town",
        "112378": "Dalian Professional",
        "112387": "Al Ahli",
        "112389": "Al Faisaly",
        "112390": "Al Fateh",
        "112392": "Al Raed",
        "112393": "Al Taawoun",
        "112420": "Mjøndalen IF",
        "112427": "Western Sydney Wanderers",
        "112429": "Guangzhou R&F",
        "112444": "Hokkaido Consadole Sapporo",
        "112472": "Red Bull Bragantino",
        "112476": "Chapecoense",
        "112510": "Bruk-Bet Termalica Nieciecza",
        "112511": "Warta Poznań",
        "112513": "FC Arouca",
        "112516": "Tondela",
        "112523": "Club Deportivo La Equidad Seguros",
        "112533": "Club de Deportes Antofagasta",
        "112535": "Unión La Calera",
        "112540": "Shanghai SIPG",
        "112541": "Wuhan Zall",
        "112552": "US Quevilly Rouen Metropole",
        "112558": "Suwon FC",
        "112572": "Al Tai",
        "112606": "Orlando City SC",
        "112637": "Gaz Metan Mediaș",
        "112658": "Icons",
        "112667": "Nacional Potosí",
        "112670": "Talleres de Córdoba",
        "112671": "Nacional Asunción",
        "112678": "Atlético de San Luis",
        "112689": "Club Atletico Platense",
        "112695": "RFC Seraing",
        "112713": "Club Atletico Sarmiento",
        "112716": "Club Cerro Porteno",
        "112783": "Tokushima Vortis",
        "112809": "Famalicão",
        "112828": "New York City FC",
        "112836": "Vegalta Sendai",
        "112853": "Deportivo La Guaira FC",
        "112885": "Atlanta United FC",
        "112893": "Inter Miami",
        "112908": "Independiente del Valle",
        "112914": "Metropolitanos de Caracas FC",
        "112916": "Aragua FC",
        "112961": "Qingdao Huanghai F.C.",
        "112965": "Central Córdoba",
        "112978": "Hebei China Fortune",
        "112985": "Shijiazhuang Ever Bright F.C.",
        "112990": "Al Batin",
        "112996": "Los Angeles FC",
        "113040": "NorthEast United FC",
        "113057": "Al Fayha",
        "113058": "Abha Club",
        "113134": "FC Juárez",
        "113142": "Alanyaspor",
        "113143": "Montevideo City Torque",
        "113146": "ATK Mohun Bagan FC",
        "113149": "FC Cincinnati",
        "113157": "Sanfrecce Hiroshima",
        "113160": "Sagan Tosu",
        "113161": "Shonan Bellmare",
        "113173": "Östersunds FK",
        "113182": "FC Voluntari",
        "113183": "Oita Trinita",
        "113186": "Avispa Fukuoka",
        "113197": "Yokohama FC",
        "113217": "Damac FC",
        "113222": "Al Hazem",
        "113257": "Odisha FC",
        "113259": "Yeni Malatyaspor",
        "113297": "Chennaiyin FC",
        "113298": "FC Goa",
        "113299": "Kerala Blasters FC",
        "113300": "Mumbai City FC",
        "113301": "Hyderabad FC",
        "113302": "Bengaluru FC",
        "113356": "SD Amorebieta",
        "113378": "Sepsi OSK",
        "113380": "CS Mioveni",
        "113387": "Chindia Târgoviște",
        "113391": "Academica Clinceni",
        "113458": "IK Sirius",
        "113459": "Kristiansund BK",
        "113723": "Guayaquil City FC",
        "113743": "Varbergs BoIS",
        "113892": "Degerfors IF",
        "113926": "Salford City",
        "113974": "Spezia",
        "113981": "UD Ibiza",
        "114004": "Stal Mielec",
        "114023": "Western United FC",
        "114153": "Piemonte Calcio",
        "114161": "Austin FC",
        "114162": "Nashville SC",
        "114168": "Jamshedpur FC",
        "114326": "Raków Częstochowa",
        "114385": "CFR Cluj",
        "114398": "Türkgücü München",
        "114511": "Sport Huancayo",
        "114575": "River Plate Asunción",
        "114577": "Always Ready",
        "114578": "Club Social y Deportivo Macara",
        "114600": "Club Deportivo Guabira",
        "114604": "Macarthur FC",
        "114611": "Academia Puerto Cabello",
        "114617": "Universidad Tecnica de Cajamarca",
        "114619": "Carlos A. Mannucci",
        "114640": "Charlotte FC",
        "114688": "Guairena FC",
        "114899": "Mazatlán FC",
        "114912": "Roma FC",
        "115358": "Club Atletico Palmaflor",
        "115530": "Cuiaba Esporte Clube",
        "115535": "Club Atletico Rentistas",
        "115536": "Cerro Largo Futbol Club",
        "115716": "FC U Craiova",
        "115820": "FC Viktoria 1889 Berlin",
        "115841": "Latium",
        "115845": "Bergamo Calcio"
    ]
}
