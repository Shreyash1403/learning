// Step 1: A simple class with fromJson
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});

  // Map → User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'] ?? '', age: json['age'] ?? 0);
  }

  // For printing
  @override
  String toString() => 'User(name: $name, age: $age)';
}

void main() {
  // Step 2: This is what API sends — a list of Maps
  List<dynamic> jsonFromApi = [
    {'name': 'Shreyash', 'age': 21},
    {'name': 'Rahul', 'age': 25},
    {'name': 'Priya', 'age': 22},
  ];

  print("--- Raw JSON (List of Maps) ---");
  print(jsonFromApi);
  // [{'name': 'Shreyash', 'age': 21}, ...]

  // Step 3: WITHOUT .map() — using for loop
  List<User> usersFromLoop = [];
  for (var item in jsonFromApi) {
    User u = User.fromJson(item);
    usersFromLoop.add(u);
  }
  print("\n--- Converted using for loop ---");
  print(usersFromLoop);

  // Step 4: WITH .map() — same thing, 1 line!
  List<User> usersFromMap = jsonFromApi.map((e) => User.fromJson(e)).toList();
  print("\n--- Converted using .map() ---");
  print(usersFromMap);

  // Step 5: Now you can access like proper objects
  print("\n--- Accessing object fields ---");
  print(usersFromMap[0].name); // Shreyash  (not map['name'] anymore!)
  print(usersFromMap[0].age); // 21
  print(usersFromMap[1].name); // Rahul
}
