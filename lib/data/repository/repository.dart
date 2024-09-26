import 'package:project2/core/success_message/message.dart';
import 'package:project2/data/datasource/remote_datasource.dart';
import 'package:project2/domain/entitieas/file.dart';
import 'package:project2/domain/entitieas/note.dart';
import 'package:project2/domain/repository/base_repository.dart';
import 'package:project2/domain/usecase/delete_document.dart';
import 'package:project2/domain/usecase/login_usecase.dart';
import 'package:project2/domain/usecase/save_edited_document.dart';
import 'package:project2/domain/usecase/signup_uscase.dart';
import 'package:project2/domain/usecase/store_note.dart';
import 'package:project2/domain/usecase/upload_video_usecase.dart';

class Repository extends BaseRepository {
  final BaseRemotDataSource baseRemotDataSource;
  Repository(this.baseRemotDataSource);

  @override
  Future<Message> signUp(SignUpParameters parameters) async {
    final result = await baseRemotDataSource.signUp(parameters);
    return result;
    //throw UnimplementedError();
  }

  @override
  Future<Message> login(LoginParameters parameters) async {
    final result = await baseRemotDataSource.login(parameters);
    return result;
    //throw UnimplementedError();
  }

  @override
  Future<Message> uploadVideo(VideoParameters parameters) async {
    final result = await baseRemotDataSource.uploadVideo(parameters);
    return result;
  }

  @override
  Future<List<Filee>> getMyDrive() async {
    final result = await baseRemotDataSource.getMyDrive();
    print("rnnnnnnnn$result");
    return result;
    // throw UnimplementedError();
  }

  @override
  Future<Message> deleteDoc(IdParameters parameters) async {
    final result = await baseRemotDataSource.deleteDoc(parameters);
    return result;
    // throw UnimplementedError();
  }

  @override
  Future<Message> addNote(NoteParameters parameters) async {
    final result = await baseRemotDataSource.addNote(parameters);
    return result;
    // throw UnimplementedError();
  }

  @override
  Future<Message> saveDoc(NewFileParameters parameters) async {
    final result = await baseRemotDataSource.saveDoc(parameters);
    return result;
  }

  @override
  Future<Message> deleteNote(IdParameters parameters) async {
    final result = await baseRemotDataSource.deleteNote(parameters);
    return result;
  }

  @override
  Future<List<Note>> getMyNote() async {
    final result = await baseRemotDataSource.getMyNote();
    return result;
  }
}
