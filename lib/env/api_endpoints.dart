abstract interface class ApiEndpoints {
  String get tasksList;
  String get taskDetail;
  String taskStart(String id);
}
