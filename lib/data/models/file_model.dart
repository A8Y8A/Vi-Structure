import 'package:project2/domain/entitieas/file.dart';

class FileModel extends Filee {
  FileModel(
      {required super.id,
      required super.name,
      required super.createdAt,
      required super.updatedAt,
      required super.content});

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      content: json['Content']);
}
