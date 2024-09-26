import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project2/core/success_message/message.dart';
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/repository/base_repository.dart';

class SaveDocumentUseCase extends BaseUseCase<Message, NewFileParameters> {
  final BaseRepository baseRepository;
  SaveDocumentUseCase(this.baseRepository);

  @override
  Future<Message> call(NewFileParameters parameters) async {
    return await baseRepository.saveDoc(parameters);
  }
}

class NewFileParameters extends Equatable {
  final String fileName;

  final List<int> pdfBytes;

  const NewFileParameters(this.fileName, this.pdfBytes);

  @override
  List<Object?> get props => [fileName, pdfBytes];
}
