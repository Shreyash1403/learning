Map<String, dynamic> user = {
  'name': "Shreyash",
  'age': 21,
  'is_active': true,
  'skills': ['dart', 'flutter'],
};

void main() {
  print(user['name']);
  print(user['age']);
  print(user['is_active']);
  print(user['skills'][0]);

  print(user.containsKey('name'));
  print(user.containsKey('is_deleted'));
  print("user entries: ${user.entries}");
  print("user values: ${user.values}");

  user.forEach((key, value) => print("$key: $value"));

  print(user['is_deleted'] ?? 'Not Deleted');

  print("-----------------");

  print(user.map((key, value) => value));
}
