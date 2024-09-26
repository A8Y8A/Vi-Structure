import 'package:equatable/equatable.dart';
import 'package:project2/domain/entitieas/note.dart';

class NoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteAdded extends NoteState {}

class NoteError extends NoteState {
  final String error;

  NoteError(this.error);

  @override
  List<Object?> get props => [error];
}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}
