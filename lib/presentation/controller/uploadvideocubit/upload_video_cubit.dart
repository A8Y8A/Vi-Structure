import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project2/domain/usecase/upload_video_usecase.dart';
import 'package:project2/presentation/controller/uploadvideocubit/upload_video_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final UploadVideoUseCase _uploadVideoUseCase;
  UploadCubit(this._uploadVideoUseCase)
      : super(UploadState(isLoading: false, isSuccess: false));

  Future<void> uploadVideo({
    required String documentName,
    required String documentType,
    required String algorithm,
    String? numberOfTopic,
    required PlatformFile file,
  }) async {
    emit(UploadState(isLoading: true, isSuccess: false));

    try {
      print(
          "doc:   $documentName    doc type:$documentType,     fil.name:${file.name}  algo:$algorithm  number:$numberOfTopic");
      final result = await _uploadVideoUseCase(VideoParameters(
          documentName, documentType, algorithm, numberOfTopic!, file));
      emit(UploadState(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(UploadState(
          isLoading: false, isSuccess: false, errorMessage: e.toString()));
    }
  }
}
