import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project2/core/success_message/message.dart';
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/repository/base_repository.dart';

class DeleteDocumentUseCase extends BaseUseCase<Message, IdParameters> {
  final BaseRepository baseRepository;
  DeleteDocumentUseCase(this.baseRepository);

  @override
  Future<Message> call(IdParameters parameters) async {
    return await baseRepository.deleteDoc(parameters);
  }
}

class IdParameters extends Equatable {
  final int id;

  const IdParameters(this.id);

  @override
  List<Object?> get props => [id];
}
