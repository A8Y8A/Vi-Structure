import 'package:equatable/equatable.dart';
import 'package:project2/core/success_message/message.dart';
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/repository/base_repository.dart';

class StoreNoteUseCase extends BaseUseCase<Message, NoteParameters> {
  final BaseRepository baseRepository;
  StoreNoteUseCase(this.baseRepository);

  @override
  Future<Message> call(NoteParameters parameters) async {
    return await baseRepository.addNote(parameters);
  }
}

class NoteParameters extends Equatable {
  final int documentId;
  final String noteName;
  final String note;

  const NoteParameters(this.documentId, this.noteName, this.note);

  @override
  List<Object?> get props => [documentId, noteName, note];
}
