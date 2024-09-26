import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String message;
  const Message({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessageModel extends Message {
  const MessageModel({required super.message});
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      MessageModel(message: json["Message"]);
}
