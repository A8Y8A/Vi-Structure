import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int id;
  final String noteName;
  final String noteContent;
  final String documentName;
  final String createdAt;
  // final String updatedAt;

  const Note(
      {required this.id,
      required this.noteName,
      required this.createdAt,
      // required this.updatedAt,
      required this.noteContent,
      required this.documentName});

  @override
  List<Object?> get props => [
        id,
        noteName,
        noteContent,
        documentName,
        createdAt,
      ];
}
