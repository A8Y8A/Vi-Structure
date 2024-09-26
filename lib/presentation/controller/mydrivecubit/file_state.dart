import 'package:equatable/equatable.dart';
import 'package:project2/domain/entitieas/file.dart';

// States for FileCubit
abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object?> get props => [];
}

class FileInitial extends FileState {}

class FileLoading extends FileState {}

class FileSaved extends FileState {}

class FileLoaded extends FileState {
  final List<Filee> files;

  const FileLoaded(this.files);

  @override
  List<Object?> get props => [files];
}

class FileError extends FileState {
  final String message;

  const FileError(this.message);

  @override
  List<Object?> get props => [message];
}

class FileDownloadSuccess extends FileState {
  final String fileName;

  const FileDownloadSuccess(this.fileName);

  @override
  List<Object?> get props => [fileName];
}
