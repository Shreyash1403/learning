// Removed Flutter import — can't use with `dart run`
// In real Flutter app, you'd return Color and use Colors.yellow etc.

String getStatusColor(String status) {
  switch (status) {
    case "pending":
      return "Yellow";
    case "completed":
      return "Green";
    case "cancelled":
      return "Red";
    default:
      return "Grey";
  }
}

bool isActive(int status) => status == 1;

void createUser({required String name, int? age}) {}

void greet(String name, [String greeting = 'Hello']) {}

// void main() {
//   print(getStatusColor("pending"));
//   print(isActive(1));
//   createUser(name: "Shreyash");
//   greet("Shreyash");
// }

void main() {
  // Test regular function
  print(getStatusColor("pending")); // Colors.yellow

  // Test arrow function
  print(isActive(1)); // true
  print(isActive(0)); // false

  // Test named parameters
  createUser(name: "Shreyash", age: 21);
  createUser(name: "Rahul"); // age is optional (int?)

  // Test optional parameters
  greet("Shreyash"); // Uses default 'Hello'
  greet("Shreyash", "Hey"); // Uses custom greeting
}

//Named Constructor are constructor which is used when there are multiple variables and we need not think much of passing data sequential instead we can pass it using the key name
