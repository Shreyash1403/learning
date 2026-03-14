String getStatusText(int status) {
  if (status == 1) {
    return "Pending";
  } else if (status == 2) {
    return "InProgress";
  } else if (status == 3) {
    return "Resolved";
  } else if (status == 5) {
    return "Rejected";
  } else {
    return "Unknown";
  }
}

String getTaskStatus(int task) {
  switch (task) {
    case 1:
      return "Pending";
    case 2:
      return "InProgress";
    case 3:
      return "Resolved";
    case 5:
      return "Rejected";
    default:
      return "Unknown";
  }
}

void main() {
  print(getStatusText(1));
  print(getTaskStatus(2));
}
