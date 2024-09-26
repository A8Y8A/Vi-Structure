import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/entitieas/file.dart';
import 'package:project2/domain/repository/base_repository.dart';

class GetMyDriveUseCase extends BaseUseCase<List<Filee>, NoParameters> {
  final BaseRepository baseRepository;
  GetMyDriveUseCase(this.baseRepository);

  @override
  Future<List<Filee>> call(NoParameters parameters) async {
    return await baseRepository.getMyDrive();
  }
}
