import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project2/core/success_message/message.dart';
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/repository/base_repository.dart';

class UploadVideoUseCase extends BaseUseCase<Message, VideoParameters> {
  final BaseRepository baseRepository;
  UploadVideoUseCase(this.baseRepository);

  @override
  Future<Message> call(VideoParameters parameters) async {
    return await baseRepository.uploadVideo(parameters);
  }
}

class VideoParameters extends Equatable {
  final String docName;
  final String docType;
  final String algorithm;
  final String numberOfTopic;
  final PlatformFile file;
  const VideoParameters(this.docName, this.docType, this.algorithm,
      this.numberOfTopic, this.file);

  @override
  List<Object?> get props => [docName, docType, file, algorithm, numberOfTopic];
}
