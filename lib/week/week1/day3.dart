List<String> compTitles = [
  "Parking",
  "InProgress",
  "Resolved",
  "Rejected",
  "Completed",
];

void main() {
  print(compTitles);
  for (int i = 0; i < compTitles.length; i++) {
    print(compTitles[i]);
  }

  for (var title in compTitles) {
    print(title);
  }

  compTitles.forEach((title) => print(title));

  print(compTitles.where((title) => title.contains("Parking")));
  print(compTitles.map((title) => title.toUpperCase()));
}
