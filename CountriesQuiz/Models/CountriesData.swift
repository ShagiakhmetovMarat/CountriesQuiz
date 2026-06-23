//
//  CountriesData.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 18.06.2026.
//

import Foundation

struct Country {
    let name: String
    let flag: String
    let capital: String
    let continent: Continent
}

enum Continent: String, CaseIterable {
    case europe = "Европа"
    case asia = "Азия"
    case africa = "Африка"
    case america = "Америка"
    case oceania = "Океания"
}

enum CountriesData {
    // MARK: - America (35 countries)
    static let america: [Country] = [
        Country(name: "Антигуа и Барбуда", flag: "ag", capital: "Сент-Джонс", continent: .america),
        Country(name: "Аргентина", flag: "ar", capital: "Буэнос-Айрес", continent: .america),
        Country(name: "Багамские Острова", flag: "bs", capital: "Нассау", continent: .america),
        Country(name: "Барбадос", flag: "bb", capital: "Бриджтаун", continent: .america),
        Country(name: "Белиз", flag: "bz", capital: "Бельмопан", continent: .america),
        Country(name: "Боливия", flag: "bo", capital: "Сукре", continent: .america),
        Country(name: "Бразилия", flag: "br", capital: "Бразилиа", continent: .america),
        Country(name: "Венесуэла", flag: "ve", capital: "Каракас", continent: .america),
        Country(name: "Гаити", flag: "ht", capital: "Порт-о-Пренс", continent: .america),
        Country(name: "Гайана", flag: "gy", capital: "Джорджтаун", continent: .america),
        Country(name: "Гватемала", flag: "gt", capital: "Гватемала", continent: .america),
        Country(name: "Гондурас", flag: "hn", capital: "Тегусигальпа", continent: .america),
        Country(name: "Гренада", flag: "gd", capital: "Сент-Джорджес", continent: .america),
        Country(name: "Доминика", flag: "dm", capital: "Розо", continent: .america),
        Country(name: "Доминиканская Республика", flag: "do", capital: "Санто-Доминго", continent: .america),
        Country(name: "Канада", flag: "ca", capital: "Оттава", continent: .america),
        Country(name: "Колумбия", flag: "co", capital: "Богота", continent: .america),
        Country(name: "Коста-Рика", flag: "cr", capital: "Сан-Хосе", continent: .america),
        Country(name: "Куба", flag: "cu", capital: "Гавана", continent: .america),
        Country(name: "Мексика", flag: "mx", capital: "Мехико", continent: .america),
        Country(name: "Никарагуа", flag: "ni", capital: "Манагуа", continent: .america),
        Country(name: "Панама", flag: "pa", capital: "Панама", continent: .america),
        Country(name: "Парагвай", flag: "py", capital: "Асунсьон", continent: .america),
        Country(name: "Перу", flag: "pe", capital: "Лима", continent: .america),
        Country(name: "Сальвадор", flag: "sv", capital: "Сан-Сальвадор", continent: .america),
        Country(name: "Сент-Винсент и Гренадины", flag: "vc", capital: "Кингстаун", continent: .america),
        Country(name: "Сент-Китс и Невис", flag: "kn", capital: "Бастер", continent: .america),
        Country(name: "Сент-Люсия", flag: "lc", capital: "Кастри", continent: .america),
        Country(name: "США", flag: "us", capital: "Вашингтон", continent: .america),
        Country(name: "Суринам", flag: "sr", capital: "Парамарибо", continent: .america),
        Country(name: "Тринидад и Тобаго", flag: "tt", capital: "Порт-оф-Спейн", continent: .america),
        Country(name: "Уругвай", flag: "uy", capital: "Монтевидео", continent: .america),
        Country(name: "Чили", flag: "cl", capital: "Сантьяго", continent: .america),
        Country(name: "Эквадор", flag: "ec", capital: "Кито", continent: .america),
        Country(name: "Ямайка", flag: "jm", capital: "Кингстон", continent: .america)
    ]
    // MARK: - Europe (44 countries)
    static let europe: [Country] = [
        Country(name: "Австрия", flag: "at", capital: "Вена", continent: .europe),
        Country(name: "Албания", flag: "al", capital: "Тирана", continent: .europe),
        Country(name: "Андорра", flag: "ad", capital: "Андорра-ла-Велья", continent: .europe),
        Country(name: "Беларусь", flag: "by", capital: "Минск", continent: .europe),
        Country(name: "Бельгия", flag: "be", capital: "Брюссель", continent: .europe),
        Country(name: "Болгария", flag: "bg", capital: "София", continent: .europe),
        Country(name: "Босния и Герцеговина", flag: "ba", capital: "Сараево", continent: .europe),
        Country(name: "Ватикан", flag: "va", capital: "Ватикан", continent: .europe),
        Country(name: "Великобритания", flag: "gb", capital: "Лондон", continent: .europe),
        Country(name: "Венгрия", flag: "hu", capital: "Будапешт", continent: .europe),
        Country(name: "Германия", flag: "de", capital: "Берлин", continent: .europe),
        Country(name: "Греция", flag: "gr", capital: "Афины", continent: .europe),
        Country(name: "Дания", flag: "dk", capital: "Копенгаген", continent: .europe),
        Country(name: "Ирландия", flag: "ie", capital: "Дублин", continent: .europe),
        Country(name: "Исландия", flag: "is", capital: "Рейкьявик", continent: .europe),
        Country(name: "Испания", flag: "es", capital: "Мадрид", continent: .europe),
        Country(name: "Италия", flag: "it", capital: "Рим", continent: .europe),
        Country(name: "Кипр", flag: "cy", capital: "Никоссия", continent: .europe),
        Country(name: "Латвия", flag: "lv", capital: "Рига", continent: .europe),
        Country(name: "Литва", flag: "lt", capital: "Вильнюс", continent: .europe),
        Country(name: "Лихтенштейн", flag: "li", capital: "Вадуц", continent: .europe),
        Country(name: "Люксембург", flag: "lu", capital: "Люксембург", continent: .europe),
        Country(name: "Мальта", flag: "mt", capital: "Валлетта", continent: .europe),
        Country(name: "Молдова", flag: "md", capital: "Кишинёв", continent: .europe),
        Country(name: "Монако", flag: "mc", capital: "Монако", continent: .europe),
        Country(name: "Нидерланды", flag: "nl", capital: "Амстердам", continent: .europe),
        Country(name: "Норвегия", flag: "no", capital: "Стокгольм", continent: .europe),
        Country(name: "Польша", flag: "pl", capital: "Варшава", continent: .europe),
        Country(name: "Португалия", flag: "pt", capital: "Лиссабон", continent: .europe),
        Country(name: "Россия", flag: "ru", capital: "Москва", continent: .europe),
        Country(name: "Румыния", flag: "ro", capital: "Бухарест", continent: .europe),
        Country(name: "Сан-Марино", flag: "sm", capital: "Сан-Марино", continent: .europe),
        Country(name: "Северная Македония", flag: "mk", capital: "Скопье", continent: .europe),
        Country(name: "Сербия", flag: "rs", capital: "Белград", continent: .europe),
        Country(name: "Словакия", flag: "sk", capital: "Братислава", continent: .europe),
        Country(name: "Слования", flag: "si", capital: "Любляна", continent: .europe),
        Country(name: "Украина", flag: "ua", capital: "Киев", continent: .europe),
        Country(name: "Финляндия", flag: "fi", capital: "Хельсинки", continent: .europe),
        Country(name: "Франция", flag: "fr", capital: "Париж", continent: .europe),
        Country(name: "Хорватия", flag: "hr", capital: "Загреб", continent: .europe),
        Country(name: "Черногория", flag: "me", capital: "Подгорица", continent: .europe),
        Country(name: "Чехия", flag: "cz", capital: "Прага", continent: .europe),
        Country(name: "Швейцария", flag: "ch", capital: "Берн", continent: .europe),
        Country(name: "Швеция", flag: "se", capital: "Стокгольм", continent: .europe),
        Country(name: "Эстония", flag: "ee", capital: "Таллин", continent: .europe)
    ]
    // MARK: - Asia (47 countries)
    static let asia: [Country] = [
        Country(name: "Азербайджан", flag: "az", capital: "Баку", continent: .asia),
        Country(name: "Армения", flag: "am", capital: "Ереван", continent: .asia),
        Country(name: "Афганистан", flag: "af", capital: "Кабул", continent: .asia),
        Country(name: "Бангладеш", flag: "bd", capital: "Дакка", continent: .asia),
        Country(name: "Бахрейн", flag: "bh", capital: "Манама", continent: .asia),
        Country(name: "Бруней", flag: "bn", capital: "Бандар-Сери-Бегаван", continent: .asia),
        Country(name: "Бутан", flag: "bt", capital: "Тхимпху", continent: .asia),
        Country(name: "Восточный Тимор", flag: "tl", capital: "Дили", continent: .asia),
        Country(name: "Вьетнам", flag: "vn", capital: "Ханой", continent: .asia),
        Country(name: "Грузия", flag: "ge", capital: "Тбилиси", continent: .asia),
        Country(name: "Израиль", flag: "il", capital: "Иерусалим", continent: .asia),
        Country(name: "Индия", flag: "in", capital: "Нью-Дели", continent: .asia),
        Country(name: "Индонезия", flag: "id", capital: "Джакарта", continent: .asia),
        Country(name: "Иордания", flag: "jo", capital: "Амман", continent: .asia),
        Country(name: "Ирак", flag: "iq", capital: "Багдад", continent: .asia),
        Country(name: "Иран", flag: "ir", capital: "Тегеран", continent: .asia),
        Country(name: "Йемен", flag: "ye", capital: "Сана", continent: .asia),
        Country(name: "Казахстан", flag: "kz", capital: "Астана", continent: .asia),
        Country(name: "Камбоджа", flag: "kh", capital: "Пномпень", continent: .asia),
        Country(name: "Катар", flag: "qa", capital: "Доха", continent: .asia),
        Country(name: "Кыргызстан", flag: "kg", capital: "Бишкек", continent: .asia),
        Country(name: "Китай", flag: "cn", capital: "Пекин", continent: .asia),
        Country(name: "Кувейт", flag: "kw", capital: "Эль-Кувейт", continent: .asia),
        Country(name: "Лаос", flag: "la", capital: "Вьентьян", continent: .asia),
        Country(name: "Ливан", flag: "lb", capital: "Бейрут", continent: .asia),
        Country(name: "Малайзия", flag: "my", capital: "Куала-Лумпур", continent: .asia),
        Country(name: "Мальдивы", flag: "mv", capital: "Мале", continent: .asia),
        Country(name: "Монголия", flag: "mn", capital: "Улан-Батор", continent: .asia),
        Country(name: "Мьянма", flag: "mm", capital: "Нейпьидо", continent: .asia),
        Country(name: "Непал", flag: "np", capital: "Катманду", continent: .asia),
        Country(name: "Объединённые Арабские Эмираты", flag: "ae", capital: "Абу-Даби", continent: .asia),
        Country(name: "Оман", flag: "om", capital: "Маскат", continent: .asia),
        Country(name: "Пакистан", flag: "pk", capital: "Исламабад", continent: .asia),
        Country(name: "Палестина", flag: "ps", capital: "Рамалла", continent: .asia),
        Country(name: "Саудовская Аравия", flag: "sa", capital: "Эр-Рияд", continent: .asia),
        Country(name: "Северная Корея", flag: "kp", capital: "Пхеньян", continent: .asia),
        Country(name: "Сингапур", flag: "sg", capital: "Сингапур", continent: .asia),
        Country(name: "Сирия", flag: "sy", capital: "Дамаск", continent: .asia),
        Country(name: "Таджикистан", flag: "tj", capital: "Душанбе", continent: .asia),
        Country(name: "Таиланд", flag: "th", capital: "Бангкок", continent: .asia),
        Country(name: "Туркменистан", flag: "tm", capital: "Ашхабад", continent: .asia),
        Country(name: "Турция", flag: "tr", capital: "Анкара", continent: .asia),
        Country(name: "Узбекистан", flag: "uz", capital: "Ташкент", continent: .asia),
        Country(name: "Филиппины", flag: "ph", capital: "Манила", continent: .asia),
        Country(name: "Шри-Ланка", flag: "lk", capital: "Коломбо", continent: .asia),
        Country(name: "Южная Корея", flag: "kr", capital: "Сеул", continent: .asia),
        Country(name: "Япония", flag: "jp", capital: "Токио", continent: .asia)
    ]
    // MARK: - Africa (54 countries)
    static let africa: [Country] = [
        Country(name: "Алжир", flag: "dz", capital: "Алжир", continent: .africa),
        Country(name: "Ангола", flag: "ao", capital: "Луанда", continent: .africa),
        Country(name: "Бенин", flag: "bj", capital: "Порто-Ново", continent: .africa),
        Country(name: "Ботсвана", flag: "bw", capital: "Габороне", continent: .africa),
        Country(name: "Буркина-Фасо", flag: "bf", capital: "Уагадугу", continent: .africa),
        Country(name: "Бурунди", flag: "bi", capital: "Гитега", continent: .africa),
        Country(name: "Габон", flag: "ga", capital: "Либревиль", continent: .africa),
        Country(name: "Гамбия", flag: "gm", capital: "Банжул", continent: .africa),
        Country(name: "Гана", flag: "gh", capital: "Аккра", continent: .africa),
        Country(name: "Гвинея", flag: "gn", capital: "Конакри", continent: .africa),
        Country(name: "Гвинея-Бисау", flag: "gw", capital: "Бисау", continent: .africa),
        Country(name: "Джибути", flag: "dj", capital: "Джибути", continent: .africa),
        Country(name: "Демократическая Республика Конго", flag: "cd", capital: "Киншаса", continent: .africa),
        Country(name: "Египет", flag: "eg", capital: "Каир", continent: .africa),
        Country(name: "Замбия", flag: "zm", capital: "Лусака", continent: .africa),
        Country(name: "Зимбабве", flag: "zw", capital: "Хараре", continent: .africa),
        Country(name: "Кабо-Верде", flag: "cv", capital: "Прая", continent: .africa),
        Country(name: "Камерун", flag: "cm", capital: "Яунде", continent: .africa),
        Country(name: "Кения", flag: "ke", capital: "Найроби", continent: .africa),
        Country(name: "Коморы", flag: "km", capital: "Морони", continent: .africa),
        Country(name: "Республика Конго", flag: "cg", capital: "Браззавиль", continent: .africa),
        Country(name: "Кот-д'Ивуар", flag: "ci", capital: "Ямусукро", continent: .africa),
        Country(name: "Лесото", flag: "ls", capital: "Масеру", continent: .africa),
        Country(name: "Либерия", flag: "lr", capital: "Монровия", continent: .africa),
        Country(name: "Ливия", flag: "ly", capital: "Триполи", continent: .africa),
        Country(name: "Маврикий", flag: "mu", capital: "Порт-Луи", continent: .africa),
        Country(name: "Мавритания", flag: "mr", capital: "Нуакшот", continent: .africa),
        Country(name: "Мадагаскар", flag: "mg", capital: "Антананариву", continent: .africa),
        Country(name: "Малави", flag: "mw", capital: "Лилонгве", continent: .africa),
        Country(name: "Мали", flag: "ml", capital: "Бамако", continent: .africa),
        Country(name: "Марокко", flag: "ma", capital: "Рабат", continent: .africa),
        Country(name: "Мозамбик", flag: "mz", capital: "Мапуту", continent: .africa),
        Country(name: "Намибия", flag: "na", capital: "Виндхук", continent: .africa),
        Country(name: "Нигер", flag: "ne", capital: "Ниамей", continent: .africa),
        Country(name: "Нигерия", flag: "ng", capital: "Абуджа", continent: .africa),
        Country(name: "Руанда", flag: "rw", capital: "Кигали", continent: .africa),
        Country(name: "Сан-Томе и Принсипи", flag: "st", capital: "Сан-Томе", continent: .africa),
        Country(name: "Сейшельские Острова", flag: "sc", capital: "Виктория", continent: .africa),
        Country(name: "Сенегал", flag: "sn", capital: "Дакар", continent: .africa),
        Country(name: "Сомали", flag: "so", capital: "Могадишо", continent: .africa),
        Country(name: "Судан", flag: "sd", capital: "Хартум", continent: .africa),
        Country(name: "Сьерра-Леоне", flag: "sl", capital: "Фритаун", continent: .africa),
        Country(name: "Танзания", flag: "tz", capital: "Додома", continent: .africa),
        Country(name: "Того", flag: "tg", capital: "Ломе", continent: .africa),
        Country(name: "Тунис", flag: "tn", capital: "Тунис", continent: .africa),
        Country(name: "Уганда", flag: "ug", capital: "Кампала", continent: .africa),
        Country(name: "Центральноафриканская Республика", flag: "cf", capital: "Банги", continent: .africa),
        Country(name: "Чад", flag: "td", capital: "Нджамена", continent: .africa),
        Country(name: "Экваториальная Гвинея", flag: "gq", capital: "Малабо", continent: .africa),
        Country(name: "Эритрея", flag: "er", capital: "Асмэра", continent: .africa),
        Country(name: "Эсватини", flag: "sz", capital: "Мбабане", continent: .africa),
        Country(name: "Эфиопия", flag: "et", capital: "Аддис-Абеба", continent: .africa),
        Country(name: "Южно-Африканская Республика", flag: "za", capital: "Претория", continent: .africa),
        Country(name: "Южный Судан", flag: "ss", capital: "Джуба", continent: .africa)
    ]
    // MARK: - Oceania (14 countries)
    static let oceania: [Country] = [
        Country(name: "Австралия", flag: "au", capital: "Канберра", continent: .oceania),
        Country(name: "Вануату", flag: "vu", capital: "Порт-Вила", continent: .oceania),
        Country(name: "Кирибати", flag: "ki", capital: "Южная Тарава", continent: .oceania),
        Country(name: "Маршалловы Острова", flag: "mh", capital: "Маджуро", continent: .oceania),
        Country(name: "Микронезия", flag: "fm", capital: "Паликир", continent: .oceania),
        Country(name: "Науру", flag: "nr", capital: "Ярен", continent: .oceania),
        Country(name: "Новая Зеландия", flag: "nz", capital: "Веллингтон", continent: .oceania),
        Country(name: "Палау", flag: "pw", capital: "Нгерулмуд", continent: .oceania),
        Country(name: "Папуа — Новая Гвинея", flag: "pg", capital: "Порт-Морсби", continent: .oceania),
        Country(name: "Самоа", flag: "ws", capital: "Апиа", continent: .oceania),
        Country(name: "Соломоновы Острова", flag: "sb", capital: "Хониара", continent: .oceania),
        Country(name: "Тонга", flag: "to", capital: "Нукуалофа", continent: .oceania),
        Country(name: "Тувалу", flag: "tv", capital: "Фунафути", continent: .oceania),
        Country(name: "Фиджи", flag: "fj", capital: "Сува", continent: .oceania)
    ]
    // MARK: - All countries and countries by continent
    static let allCountries: [Country] = {
        america + europe + asia + africa + oceania
    }()
    
    static func countries(by continent: Continent) -> [Country] {
        switch continent {
        case .america: return america
        case .europe: return europe
        case .asia: return asia
        case .africa: return africa
        case .oceania: return oceania
        }
    }
}
