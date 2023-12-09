String formatDate(int unixTimestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
  // Format the date as you prefer
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}
