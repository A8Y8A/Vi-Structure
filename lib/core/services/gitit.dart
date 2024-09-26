import 'package:get_it/get_it.dart';
import 'package:project2/data/datasource/remote_datasource.dart';
import 'package:project2/data/repository/repository.dart';
import 'package:project2/domain/repository/base_repository.dart';
import 'package:project2/domain/usecase/delete_document.dart';
import 'package:project2/domain/usecase/delete_note.dart';
import 'package:project2/domain/usecase/get_my_drive_usecase.dart';
import 'package:project2/domain/usecase/get_my_note_usecase.dart';
import 'package:project2/domain/usecase/login_usecase.dart';
import 'package:project2/domain/usecase/save_edited_document.dart';
import 'package:project2/domain/usecase/signup_uscase.dart';
import 'package:project2/domain/usecase/store_note.dart';
import 'package:project2/domain/usecase/upload_video_usecase.dart';
import 'package:project2/presentation/controller/authcubit/auth_cubit.dart';
import 'package:project2/presentation/controller/mydrivecubit/file_cubit.dart';
import 'package:project2/presentation/controller/notecubit/note_cubit.dart';
import 'package:project2/presentation/controller/uploadvideocubit/upload_video_cubit.dart';

final GetIt getit = GetIt.instance;

class ServicesLocator {
  void init() {
    //cubit
    getit.registerFactory(() => AuthCubit(getit(), getit()));
    getit.registerFactory(() => UploadCubit(getit()));
    getit.registerFactory(() => FileCubit(getit(), getit(), getit()));
    getit.registerFactory(() => NoteCubit(getit(), getit(), getit()));

    //usecase
    getit.registerLazySingleton(() => SignUpUseCase(getit()));
    getit.registerLazySingleton(() => LoginUseCase(getit()));
    getit.registerLazySingleton(() => UploadVideoUseCase(getit()));
    getit.registerLazySingleton(() => GetMyDriveUseCase(getit()));
    getit.registerLazySingleton(() => DeleteDocumentUseCase(getit()));
    getit.registerLazySingleton(() => StoreNoteUseCase(getit()));
    getit.registerLazySingleton(() => SaveDocumentUseCase(getit()));
    getit.registerLazySingleton(() => GetMyNoteUseCase(getit()));
    getit.registerLazySingleton(() => DeleteNoteUseCase(getit()));

    //repository
    getit.registerLazySingleton<BaseRepository>(() => Repository(getit()));

    // remot Data source
    getit.registerLazySingleton<BaseRemotDataSource>(() => RemotDataSource());
  }
}
