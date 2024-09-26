import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/entitieas/note.dart';
import 'package:project2/domain/usecase/delete_document.dart';
import 'package:project2/domain/usecase/delete_note.dart';
import 'package:project2/domain/usecase/get_my_note_usecase.dart';
import 'package:project2/domain/usecase/store_note.dart';
import 'package:project2/presentation/controller/notecubit/note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final StoreNoteUseCase _storeNoteUseCase;
  final GetMyNoteUseCase _getMyNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  NoteCubit(
      this._storeNoteUseCase, this._getMyNoteUseCase, this._deleteNoteUseCase)
      : super(NoteInitial());

  Future<void> addNote({
    required String noteName,
    required String noteContent,
    required int documentId,
  }) async {
    // emit(NoteLoading());
    try {
      final result = await _storeNoteUseCase(
          NoteParameters(documentId, noteName, noteContent));
      // Perform the note addition logic here
      // e.g., Send the note data to the server via a repository
      // await repository.addNote(noteName, noteContent, documentId);

      emit(NoteAdded());
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  void fetchNotes() async {
    try {
      emit(NoteLoading());
      final result = await _getMyNoteUseCase(NoParameters());
      // await Future.delayed(Duration(seconds: 5));
      // final notes = [
      //   Note(
      //       id: 1,
      //       noteName: "Note 1",
      //       noteContent: "This is the content of Note 1.",
      //       createdAt: "203453",
      //       updatedAt: "35634",
      //       documentName: "namett"),
      //   Note(
      //       id: 2,
      //       noteName: "Note 2",
      //       noteContent: "This is the content of Note 1.",
      //       createdAt: "203453",
      //       updatedAt: "35634",
      //       documentName: "namett"),
      // ];
      emit(NoteLoaded(result));
    } catch (e) {
      emit(NoteError("Failed to load notes."));
    }
  }

  void deleteNoteById(int noteId) async {
    final result = await _deleteNoteUseCase(IdParameters(noteId));
    if (state is NoteLoaded) {
      final currentNotes = (state as NoteLoaded).notes;
      final updatedNotes =
          currentNotes.where((note) => note.id != noteId).toList();
      emit(NoteLoaded(updatedNotes));
    }
  }
}
