class ApiConstant {
  static const String baseUrl = "http://127.0.0.1:8000";

  static const String signUp = "$baseUrl/new/user";
  static const String logIn = "$baseUrl/login";

  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJheWEiLCJleHAiOjE3MjU4NzI2MTJ9.iu-by_UFPStZRSbqrMbmiqYQ0Ud4JKnX3oUCCvac3oM";
  // static const String upload =
  //     "$baseUrl/users/me/documents/new/kmeans?document_name=ccc&document_typ=video&additional=false";

  static const String addNote1 = "$baseUrl/users/me/documents/";
  static const String addNote2 = "/notes/new";

  static const String delete = "/delete";

  static const String deleteDoc = "$baseUrl/users/me/documents/delete/";

  static const String getMyNote = "$baseUrl/users/me/documents/notes";
  static const String getMyDrive = "$baseUrl/users/me/documents";

  static const String saveDoc = "$baseUrl/users/me/documents/update";
}

String? upload(String algo, docName, docType) {
  return "${ApiConstant.baseUrl}/users/me/documents/new/$algo?document_name=$docName&document_typ=$docType&additional=false";
}
