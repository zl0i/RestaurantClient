pragma Singleton
import QtQuick 2.12
import Qt.labs.settings 1.0

Item {
    id: _root

    property string firstName: ""
    property string phoneNumber: ""
    property var address: {
        "street": "Морская",
        "house": 46,
        "flat": 18
    }

    property var activeOrder:
    {
        "datetime": "2020-08-06T00:43:37.000Z",
        "total": "560.00",
        "status": "access"
    }

    property var history: [
        {
            "datetime": "2020-08-05T00:43:00.000Z",
            "total": "560.00",
            "status": "access"
        },
        {
            "datetime": "2020-07-23T13:51:00.000Z",
            "total": "25.00",
            "status": "access"
        },
        {
            "datetime": "2020-04-18T16:56:00.000Z",
            "total": "113.00",
            "status": "canceled"
        },
        {
            "datetime": "2019-12-03T17:43:00.000Z",
            "total": "2560.00",
            "status": "access"
        },
    ]

    Settings {
        id: _settings
        property alias firstName: _root.firstName
        property alias phoneNumber: _root.phoneNumber

        //property alias menu: _root.menu
        //property alias activeOrder: _root.activeOrder
        //property alias basket: _root.basket
        //property alias history: _root.history

    }

    function clearCash() {

    }



    /*readonly property var menu: [
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
    ]*/





    /*readonly property var history : [
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
    ]*/
}


