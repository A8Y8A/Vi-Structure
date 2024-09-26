import 'package:project2/core/success_message/message.dart';
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/repository/base_repository.dart';
import 'package:project2/domain/usecase/delete_document.dart';

class DeleteNoteUseCase extends BaseUseCase<Message, IdParameters> {
  final BaseRepository baseRepository;
  DeleteNoteUseCase(this.baseRepository);

  @override
  Future<Message> call(IdParameters parameters) async {
    return await baseRepository.deleteNote(parameters);
  }
}
