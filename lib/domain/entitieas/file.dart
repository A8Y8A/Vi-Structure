import 'package:equatable/equatable.dart';

class Filee extends Equatable {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String content;

  const Filee(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt,
      required this.content});

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt, content];
}
