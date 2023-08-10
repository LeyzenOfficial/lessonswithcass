import { LightningElement } from 'lwc';

export default class CalcuBot extends LightningElement {

    valueOne = 0;
    valueTwo = 0;
    operation = 'add';
    result = 0;

    options = [
        { label: 'Addition', value: 'add' },
        { label: 'Subtraction', value: 'subtract' },
        { label: 'Multiplication', value: 'multiply' },
        { label: 'Division', value: 'divide' },
];

    handleInputChange(event) {
        this.valueOne = parseFloat(event.target.value);
    }

    handleInputChange2(event) {
        this.valueTwo = parseFloat(event.target.value);
    }

    handleOperationChange(event) {
        this.operation = event.target.value;
    }

    handleClick() {
        if (this.operation === 'add') {  
            this.result = this.valueOne + this.valueTwo;
            console.log(this.valueOne, this.valueTwo);
        } else if (this.operation === 'subtract') {
            this.result = this.valueOne - this.valueTwo;
        } else if (this.operation === 'multiply') {
            this.result = this.valueOne * this.valueTwo;
        } else if (this.operation === 'divide') {
            this.result = this.valueOne / this.valueTwo;
        }
        // this.dateToUnixEpoch();
    }

    // dateToUnixEpoch() {
    //     const inputDate = '2023-08-01';

    //     const epoch = new Date('1970-01-01');
    //     const inputDateTime = new Date(inputDate); // Replace 'inputDate' with your date format
    //     const timeDifference = inputDateTime - epoch;
    //     const unixEpochTime = Math.floor(timeDifference / 1000); // Convert milliseconds to seconds
        
    //     console.log(unixEpochTime);
    // }

    // {
    //     "data": {
    //       "info": {
    //         "Username": "Leyzen",
    //         "Country": "Brazil",
    //         "Game mode": 0,
    //         "Cb-3": 0,
    //         "F2p": 0,
    //         "Banned": 0,
    //         "Disqualified": 0,
    //         "Clan preference": null,
    //         "Last checked": "2023-08-02 00:13:51",
    //         "Last checked unix": 1690935231
    //       },
    //       "Date": "2023-07-31 10:29:03",
    //       "Overall": 1591808079,
    //       "Overall_rank": 545,
    //       "Overall_level": 2277,
    //       "Overall_ehp": 3955.146945686355,
    //       "Attack": 112650542,
    //       "Attack_rank": 806,
    //       "Attack_level": 99,
    //       "Attack_ehp": 0,
    //       "Defence": 38882808,
    //       "Defence_rank": 4486,
    //       "Defence_level": 99,
    //       "Defence_ehp": 52.99194067272406,
    //       "Strength": 42494911,
    //       "Strength_rank": 26708,
    //       "Strength_level": 99,
    //       "Strength_ehp": 0,
    //       "Hitpoints": 94372335,
    //       "Hitpoints_rank": 6752,
    //       "Hitpoints_level": 99,
    //       "Hitpoints_ehp": 0.471861675,
    //       "Ranged": 38401118,
    //       "Ranged_rank": 65146,
    //       "Ranged_level": 99,
    //       "Ranged_ehp": 33.27653206239168,
    //       "Prayer": 14832304,
    //       "Prayer_rank": 4287,
    //       "Prayer_level": 99,
    //       "Prayer_ehp": 8.240168888888888,
    //       "Magic": 39273233,
    //       "Magic_rank": 9603,
    //       "Magic_level": 99,
    //       "Magic_ehp": 0.196366165,
    //       "Cooking": 200000000,
    //       "Cooking_rank": 770,
    //       "Cooking_level": 99,
    //       "Cooking_ehp": 212.80862780643682,
    //       "Woodcutting": 28602845,
    //       "Woodcutting_rank": 7932,
    //       "Woodcutting_level": 99,
    //       "Woodcutting_ehp": 152.0091734021762,
    //       "Fletching": 19890323,
    //       "Fletching_rank": 6896,
    //       "Fletching_level": 99,
    //       "Fletching_ehp": 0.099451615,
    //       "Fishing": 14860637,
    //       "Fishing_rank": 30394,
    //       "Fishing_level": 99,
    //       "Fishing_ehp": 115.88864361909832,
    //       "Firemaking": 200000000,
    //       "Firemaking_rank": 291,
    //       "Firemaking_level": 99,
    //       "Firemaking_ehp": 202.3024722384661,
    //       "Crafting": 200000000,
    //       "Crafting_rank": 268,
    //       "Crafting_level": 99,
    //       "Crafting_ehp": 461.2236753980596,
    //       "Smithing": 15010285,
    //       "Smithing_rank": 12523,
    //       "Smithing_level": 99,
    //       "Smithing_ehp": 39.952932413350446,
    //       "Mining": 145295836,
    //       "Mining_rank": 174,
    //       "Mining_level": 99,
    //       "Mining_ehp": 1151.7328689303022,
    //       "Herblore": 14492184,
    //       "Herblore_rank": 9830,
    //       "Herblore_level": 99,
    //       "Herblore_ehp": 33.911814347898726,
    //       "Agility": 14644227,
    //       "Agility_rank": 9542,
    //       "Agility_level": 99,
    //       "Agility_ehp": 181.36672780214016,
    //       "Thieving": 200000000,
    //       "Thieving_rank": 433,
    //       "Thieving_level": 99,
    //       "Thieving_ehp": 717.4230491625987,
    //       "Slayer": 37519242,
    //       "Slayer_rank": 3389,
    //       "Slayer_level": 99,
    //       "Slayer_ehp": 381.88942988051383,
    //       "Farming": 59676879,
    //       "Farming_rank": 3688,
    //       "Farming_level": 99,
    //       "Farming_ehp": 35.92491488095239,
    //       "Runecraft": 23201848,
    //       "Runecraft_rank": 4053,
    //       "Runecraft_level": 99,
    //       "Runecraft_ehp": 97.12065416666667,
    //       "Hunter": 22402093,
    //       "Hunter_rank": 8407,
    //       "Hunter_level": 99,
    //       "Hunter_ehp": 61.2973239006188,
    //       "Construction": 15304429,
    //       "Construction_rank": 2143,
    //       "Construction_level": 99,
    //       "Construction_ehp": 15.01831665807232,
    //       "Ehp": 3955.1469,
    //       "Ehp_rank": 441,
    //       "Im_ehp": 0,
    //       "Lvl3_ehp": 0,
    //       "F2p_ehp": 0,
    //       "Uim_ehp": 0
    //     }
    //   }

    // {
    //     "results": [
    //       {
    //         "gender": "female",
    //         "name": {
    //           "title": "Mrs",
    //           "first": "Dolores",
    //           "last": "Gutiérrez"
    //         },
    //         "location": {
    //           "street": {
    //             "number": 3728,
    //             "name": "Calle de Bravo Murillo"
    //           },
    //           "city": "Zaragoza",
    //           "state": "País Vasco",
    //           "country": "Spain",
    //           "postcode": 85807,
    //           "coordinates": {
    //             "latitude": "-38.5085",
    //             "longitude": "22.5056"
    //           },
    //           "timezone": {
    //             "offset": "-2:00",
    //             "description": "Mid-Atlantic"
    //           }
    //         },
    //         "email": "dolores.gutierrez@example.com",
    //         "login": {
    //           "uuid": "46a557fe-ddb0-4ec5-91a9-16e613e82f10",
    //           "username": "organicbird438",
    //           "password": "palmer",
    //           "salt": "YTc6Xvge",
    //           "md5": "50ab5d91ea9d812e8f58dcaea456c54d",
    //           "sha1": "c22c176dbdc412ebdc0013554fa1d66030104d29",
    //           "sha256": "90e0f481ab65ce772fe7c09e8fbfb7e99b4decb0919cdb38345ad2b75b4c62c7"
    //         },
    //         "dob": {
    //           "date": "1994-06-15T02:11:57.706Z",
    //           "age": 29
    //         },
    //         "registered": {
    //           "date": "2010-05-01T00:47:15.522Z",
    //           "age": 13
    //         },
    //         "phone": "929-519-104",
    //         "cell": "620-347-760",
    //         "id": {
    //           "name": "DNI",
    //           "value": "97867784-X"
    //         },
    //         "picture": {
    //           "large": "https://randomuser.me/api/portraits/women/6.jpg",
    //           "medium": "https://randomuser.me/api/portraits/med/women/6.jpg",
    //           "thumbnail": "https://randomuser.me/api/portraits/thumb/women/6.jpg"
    //         },
    //         "nat": "ES"
    //       }
    //     ],
    //     "info": {
    //       "seed": "783fc8f35088ae53",
    //       "results": 1,
    //       "page": 1,
    //       "version": "1.4"
    //     }
    //   }
}


