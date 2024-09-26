import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/entitieas/file.dart';
import 'package:project2/domain/entitieas/note.dart';
import 'package:project2/domain/repository/base_repository.dart';

class GetMyNoteUseCase extends BaseUseCase<List<Note>, NoParameters> {
  final BaseRepository baseRepository;
  GetMyNoteUseCase(this.baseRepository);

  @override
  Future<List<Note>> call(NoParameters parameters) async {
    return await baseRepository.getMyNote();
  }
}
