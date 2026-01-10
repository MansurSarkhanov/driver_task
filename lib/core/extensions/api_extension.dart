extension ApiExtension on String {
  static const String baseUrl =
      "https://c312a5f6-de44-4bc5-97aa-81f381281317.mock.pstmn.io";
  static const String serverApi = "/api";
  String connectToService() {
    return baseUrl + serverApi + this;
  }
}
