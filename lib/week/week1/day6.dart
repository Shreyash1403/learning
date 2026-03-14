String? name;
String? name2 = null;
String? name3 = "";
List<int>? numbers = [1, 2, 3, 4, 5];

Map<String, dynamic> user = {
  'name': 'Shreyash',
  'age': null,
  'isStudent': false,
};

void main() {
  print(name ?? "No name");
  print(numbers ?? []);
  print(name2?.length ?? 0);
  print(name3?.length);

  print(user['name']?.toString() ?? '');
  print(user['age']?.toString() ?? 0);
}
