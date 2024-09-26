class UploadState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  UploadState(
      {required this.isLoading, required this.isSuccess, this.errorMessage});
}
