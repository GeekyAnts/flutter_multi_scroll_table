import 'dart:math';

class CommonUtils {
  static final List<int> numbers = List.generate(20, (index) => index + 1)
    ..shuffle();

  static final List<String> randomAlphabets =
      List.generate(20, (_) => CommonUtils.generateRandomAlphabet());
  static String generateRandomAlphabet() {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final randomIndex = Random().nextInt(alphabet.length);
    return alphabet[randomIndex];
  }

  static final List<List<dynamic>> dataList = [
    [
      1,
      'John Doe',
      'New York',
      'Apple',
      'Tesla',
      'USA',
      '+1',
      'X',
      'Y',
      'Z',
      'W'
    ],
    [
      2,
      'Jane Smith',
      'London',
      'Banana',
      'BMW',
      'UK',
      '+44',
      'M',
      'N',
      'O',
      'P'
    ],
    [
      3,
      'Alice Johnson',
      'Sydney',
      'Orange',
      'Mercedes',
      'Australia',
      '+61',
      'A1',
      'B1',
      'C1',
      'D1'
    ],
    [
      4,
      'Michael Brown',
      'Paris',
      'Grapes',
      'Audi',
      'France',
      '+33',
      'E',
      'F',
      'G',
      'H'
    ],
    [
      5,
      'Emily Davis',
      'Berlin',
      'Strawberry',
      'Porsche',
      'Germany',
      '+49',
      'I',
      'J',
      'K',
      'L'
    ],
    [
      6,
      'Chris Wilson',
      'Rome',
      'Peach',
      'Ferrari',
      'Italy',
      '+39',
      'M',
      'N',
      'O',
      'P'
    ],
    [
      7,
      'Jessica Lee',
      'Madrid',
      'Blueberry',
      'Seat',
      'Spain',
      '+34',
      'Q',
      'R',
      'S',
      'T'
    ],
    [
      8,
      'David Martinez',
      'Amsterdam',
      'Pineapple',
      'Volvo',
      'Netherlands',
      '+31',
      'U',
      'V',
      'W',
      'X'
    ],
    [
      9,
      'Sophia Clark',
      'Vienna',
      'Cherry',
      'Skoda',
      'Austria',
      '+43',
      'Y',
      'Z',
      'A2',
      'B2'
    ],
    [
      10,
      'Daniel Lewis',
      'Zurich',
      'Mango',
      'BMW',
      'Switzerland',
      '+41',
      'C2',
      'D2',
      'E2',
      'F2'
    ],
    [
      11,
      'Olivia Walker',
      'Brussels',
      'Melon',
      'Audi',
      'Belgium',
      '+32',
      'G2',
      'H2',
      'I2',
      'J2'
    ],
    [
      12,
      'James Allen',
      'Prague',
      'Kiwi',
      'Tesla',
      'Czech Republic',
      '+420',
      'K2',
      'L2',
      'M2',
      'N2'
    ],
  ];

  static final List<Map<String, dynamic>> jsonDataList = [
    {
      "Sr. No": 1,
      "Random": "A",
      "Members": "John Doe",
      "Cities": "New York",
      "Fruits": "Apple",
      "Cars": "Tesla",
      "Countries": "USA",
      "Codes": "+1",
      "Random 1": "X",
      "Random 2": "Y",
      "Random 3": "Z",
      "Random 4": "W",
    },
    {
      "Sr. No": 2,
      "Random": "B",
      "Members": "Jane Smith",
      "Cities": "London",
      "Fruits": "Banana",
      "Cars": "BMW",
      "Countries": "UK",
      "Codes": "+44",
      "Random 1": "M",
      "Random 2": "N",
      "Random 3": "O",
      "Random 4": "P",
    },
    {
      "Sr. No": 3,
      "Random": "C",
      "Members": "Alice Johnson",
      "Cities": "Sydney",
      "Fruits": "Orange",
      "Cars": "Mercedes",
      "Countries": "Australia",
      "Codes": "+61",
      "Random 1": "A1",
      "Random 2": "B1",
      "Random 3": "C1",
      "Random 4": "D1",
    },
    {
      "Sr. No": 4,
      "Random": "D",
      "Members": "Michael Brown",
      "Cities": "Paris",
      "Fruits": "Grapes",
      "Cars": "Audi",
      "Countries": "France",
      "Codes": "+33",
      "Random 1": "E",
      "Random 2": "F",
      "Random 3": "G",
      "Random 4": "H",
    },
    {
      "Sr. No": 5,
      "Random": "E",
      "Members": "Emily Davis",
      "Cities": "Berlin",
      "Fruits": "Strawberry",
      "Cars": "Porsche",
      "Countries": "Germany",
      "Codes": "+49",
      "Random 1": "I",
      "Random 2": "J",
      "Random 3": "K",
      "Random 4": "L",
    },
    {
      "Sr. No": 6,
      "Random": "F",
      "Members": "Chris Wilson",
      "Cities": "Rome",
      "Fruits": "Peach",
      "Cars": "Ferrari",
      "Countries": "Italy",
      "Codes": "+39",
      "Random 1": "M",
      "Random 2": "N",
      "Random 3": "O",
      "Random 4": "P",
    },
    {
      "Sr. No": 7,
      "Random": "G",
      "Members": "Jessica Lee",
      "Cities": "Madrid",
      "Fruits": "Blueberry",
      "Cars": "Seat",
      "Countries": "Spain",
      "Codes": "+34",
      "Random 1": "Q",
      "Random 2": "R",
      "Random 3": "S",
      "Random 4": "T",
    },
    {
      "Sr. No": 8,
      "Random": "H",
      "Members": "David Martinez",
      "Cities": "Amsterdam",
      "Fruits": "Pineapple",
      "Cars": "Volvo",
      "Countries": "Netherlands",
      "Codes": "+31",
      "Random 1": "U",
      "Random 2": "V",
      "Random 3": "W",
      "Random 4": "X",
    },
    {
      "Sr. No": 9,
      "Random": "I",
      "Members": "Sophia Clark",
      "Cities": "Vienna",
      "Fruits": "Cherry",
      "Cars": "Skoda",
      "Countries": "Austria",
      "Codes": "+43",
      "Random 1": "Y",
      "Random 2": "Z",
      "Random 3": "A2",
      "Random 4": "B2",
    },
    {
      "Sr. No": 10,
      "Random": "J",
      "Members": "Daniel Lewis",
      "Cities": "Zurich",
      "Fruits": "Mango",
      "Cars": "BMW",
      "Countries": "Switzerland",
      "Codes": "+41",
      "Random 1": "C2",
      "Random 2": "D2",
      "Random 3": "E2",
      "Random 4": "F2",
    },
    {
      "Sr. No": 11,
      "Random": "K",
      "Members": "Olivia Walker",
      "Cities": "Brussels",
      "Fruits": "Melon",
      "Cars": "Audi",
      "Countries": "Belgium",
      "Codes": "+32",
      "Random 1": "G2",
      "Random 2": "H2",
      "Random 3": "I2",
      "Random 4": "J2",
    },
    {
      "Sr. No": 12,
      "Random": "L",
      "Members": "James Allen",
      "Cities": "Prague",
      "Fruits": "Kiwi",
      "Cars": "Tesla",
      "Countries": "Czech Republic",
      "Codes": "+420",
      "Random 1": "K2",
      "Random 2": "L2",
      "Random 3": "M2",
      "Random 4": "N2",
    },
  ];

  static final List<String> names = [
    "Alex Martin",
    "John Doe",
    "Jane Smith",
    "Emily Johnson",
    "Michael Brown",
    "Jessy Williams",
    "David Jones",
    "Sarah Davis",
    "Daniel Wilson",
    "Laura Moore",
    "Chris Taylor",
    "Hannah Monte",
    "James Thomas",
    "Sophia John",
    "Robert White",
    "Emma Harris",
    "Brian Martin",
    "Olivia Jones",
    "Kevin Lee",
    "Isa Martin"
  ];

  static final List<String> cities = [
    "New York",
    "Los Angeles",
    "Chicago",
    "Houston",
    "Phoenix",
    "Philadelphia",
    "San Antonio",
    "San Diego",
    "Dallas",
    "San Jose",
    "Austin",
    "Jacksonville",
    "Fort Worth",
    "Columbus",
    "Charlotte",
    "Japan",
    "Delhi",
    "Seattle",
    "Denver",
    "Washington"
  ];

  static final List<String> fruits = [
    "Apple",
    "Banana",
    "Orange",
    "Grapes",
    "Mango",
    "Pineapple",
    "Strawberry",
    "Blueberry",
    "Cherry",
    "Watermelon",
    "Peach",
    "Plum",
    "Kiwi",
    "Lemon",
    "Lime",
    "Pear",
    "Apricot",
    "Pomegranate",
    "Papaya",
    "Fig"
  ];

  static final List<String> carBrands = [
    "Toyota",
    "Ford",
    "Chevrolet",
    "Honda",
    "Nissan",
    "BMW",
    "Mercedes",
    "Volkswagen",
    "Audi",
    "Hyundai",
    "Kia",
    "Subaru",
    "Mazda",
    "Tesla",
    "Lexus",
    "Jaguar",
    "Porsche",
    "Volvo",
    "Land Rover",
    "Ferrari"
  ];

  static final List<String> countries = [
    "United States",
    "Canada",
    "Mexico",
    "Brazil",
    "Argentina",
    "United Kingdom",
    "France",
    "Germany",
    "Italy",
    "Spain",
    "Australia",
    "New Zealand",
    "China",
    "Japan",
    "South Korea",
    "India",
    "Russia",
    "South Africa",
    "Egypt",
    "Nigeria"
  ];

  static final List<String> countryCodes = [
    "US", // United States
    "CA", // Canada
    "MX", // Mexico
    "BR", // Brazil
    "AR", // Argentina
    "GB", // United Kingdom
    "FR", // France
    "DE", // Germany
    "IT", // Italy
    "ES", // Spain
    "AU", // Australia
    "NZ", // New Zealand
    "CN", // China
    "JP", // Japan
    "KR", // South Korea
    "IN", // India
    "RU", // Russia
    "ZA", // South Africa
    "EG", // Egypt
    "NG" // Nigeria
  ];
}
