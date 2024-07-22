import 'dart:math';

class CommonUtils {
  static String generateRandomAlphabet() {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final randomIndex = Random().nextInt(alphabet.length);
    return alphabet[randomIndex];
  }

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
