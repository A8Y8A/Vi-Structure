import 'package:project2/core/success_message/message.dart';
import 'package:project2/domain/entitieas/file.dart';
import 'package:project2/domain/entitieas/note.dart';
import 'package:project2/domain/usecase/delete_document.dart';
import 'package:project2/domain/usecase/login_usecase.dart';
import 'package:project2/domain/usecase/save_edited_document.dart';
import 'package:project2/domain/usecase/signup_uscase.dart';
import 'package:project2/domain/usecase/store_note.dart';
import 'package:project2/domain/usecase/upload_video_usecase.dart';

abstract class BaseRepository {
  Future<Message> signUp(SignUpParameters parameters);
  Future<Message> login(LoginParameters parameters);
  Future<Message> uploadVideo(VideoParameters parameters);
  Future<List<Filee>> getMyDrive();
  Future<Message> deleteDoc(IdParameters parameters);
  Future<Message> addNote(NoteParameters parameters);
  Future<Message> saveDoc(NewFileParameters parameters);
  Future<Message> deleteNote(IdParameters parameters);
  Future<List<Note>> getMyNote();
}
