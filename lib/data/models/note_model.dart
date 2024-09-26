import 'package:project2/domain/entitieas/note.dart';

class NoteModel extends Note {
  NoteModel(
      {required super.id,
      required super.noteName,
      required super.createdAt,
      // required super.updatedAt,
      required super.noteContent,
      required super.documentName});

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
      id: json['id'],
      noteName: json['note_name'],
      createdAt: json['created_at'],
      // updatedAt: json['updated_t'],
      noteContent: json['note_content'],
      documentName: json['document_name']);
}
