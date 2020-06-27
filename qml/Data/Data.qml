pragma Singleton
import QtQuick 2.9

QtObject {

    function findIndexMenuByCategory(category) {
        return menu.findIndex(function(item) {
            if(item.category === category)
                return true
        })
    }

    function getCategoriesMenu() {
        var cat = [];
        menu.forEach(function (item) {
           if(cat.indexOf(item.category) === -1)
               cat.push(item.category)
        })
        return cat
    }

    function filterMenuByName(str) {
        var reg = new RegExp(str, "i")
        return menu.filter(function(item) {
            if(reg.test(item.name))
                return true
        })
    }

    readonly property var menu: [
        {
            "name": "Лагман",
            "cost": 200,
            "description": "Вкуснейший суп из дикого оленя приготовленный талантом под литр водки. Покупайте наш суп не пожалеете!!! Вкуснейший суп из дикого оленя приготовленный талантом под литр водки. Покупайте наш суп не пожалеете!!! Вкуснейший суп из дикого оленя приготовленный талантом под литр водки. Покупайте наш суп не пожалеете!!!",
            "img": "",
            "category": "Первое"
        },
        {
            "name": "Борщ",
            "cost": 150,
            "description": "",
            "img": "",
            "category": "Первое"
        },
        {
            "name": "Суп с фрикадельками",
            "cost": 190,
            "description": "",
            "img": "",
            "category": "Первое"
        },
        {
            "name": "Пельмени",
            "cost": 190,
            "description": "",
            "img": "",
            "category": "Первое"
        },
        {
            "name": "Солянка",
            "cost": 190,
            "description": "",
            "img": "",
            "category": "Первое"
        },
        {
            "name": "Куриный суп",
            "cost": 190,
            "description": "",
            "img": "",
            "category": "Первое"
        },
        {
            "name": "Босо лагман",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Ганфан",
            "cost": 190,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Бифштекс",
            "cost": 190,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Манты с мясом",
            "cost": 180,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Манты жаренные",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Пельмени жаренные",
            "cost": 180,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Плов",
            "cost": 150,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Котлеты",
            "cost": 180,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Окорочка жаренные",
            "cost": 250,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Курдак с луком",
            "cost": 250,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Курдак с картошкой",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Курдак с олениной",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Гуляш",
            "cost": 160,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Сосики",
            "cost": 170,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Бризоль",
            "cost": 250,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Шаурма",
            "cost": 250,
            "description": "",
            "img": "",
            "category": "Второе"
        },
        {
            "name": "Картофельное пюре",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Гарниры"
        },
        {
            "name": "Картофель фри",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Гарниры"
        },
        {
            "name": "Макароны",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Гарниры"
        },
        {
            "name": "Рис",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Гарниры"
        },
        {
            "name": "Гречка",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Гарниры"
        },
        {
            "name": "Кофе 3 в 1",
            "cost": 30,
            "description": "",
            "img": "",
            "category": "Напитки"
        },
        {
            "name": "Рис",
            "cost": 200,
            "description": "",
            "img": "",
            "category": "Напитки"
        },
        {
            "name": "Чай с молоком",
            "cost": 30,
            "description": "",
            "img": "",
            "category": "Напитки"
        },
        {
            "name": "Чай черный",
            "cost": 30,
            "description": "",
            "img": "",
            "category": "Напитки"
        },
        {
            "name": "Компот",
            "cost": 30,
            "description": "",
            "img": "",
            "category": "Напитки"
        },
        {
            "name": "Фунчеза",
            "cost": 70,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Винигрет",
            "cost": 70,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Оливье",
            "cost": 70,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Куриный",
            "cost": 70,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Крабовый",
            "cost": 70,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Свекла с чесноком",
            "cost": 70,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Морковка по-корейски",
            "cost": 70,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Капуста по-корейски",
            "cost": 70,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Китайский острый",
            "cost": 120,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Изя языка",
            "cost": 120,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Из баклажана",
            "cost": 120,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Свежий из редиски",
            "cost": 120,
            "description": "",
            "img": "",
            "category": "Салаты"
        },
        {
            "name": "Пицца",
            "cost": 350,
            "description": "",
            "img": "",
            "category": "Разное"
        },
        {
            "name": "Самсы куриные",
            "cost": 60,
            "description": "",
            "img": "",
            "category": "Разное"
        },
        {
            "name": "Самсы с говядиной",
            "cost": 60,
            "description": "",
            "img": "",
            "category": "Разное"
        }
    ]

    property var activeOrder

    property var basket



    readonly property var history : [
        {
            "id": 546,
            "cost": "2456.50",
            "datetime": "2019-06-08T00:43:37.000Z",
            "status": "active",
            "content": [
                {

                }

            ]
        },
        {
            "id": 547,
            "cost": "10.25",
            "datetime": "2019-06-08T00:43:37.000Z",
            "status": "active",
            "content": [
                {
                    "id": 2,
                    "name": "Овощи запеченные",
                    "cost": 200
                }

            ]
        }
    ]
}


