import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:project2/core/success_message/message.dart';
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/repository/base_repository.dart';

class LoginUseCase extends BaseUseCase<Message, LoginParameters> {
  final BaseRepository baseRepository;
  LoginUseCase(this.baseRepository);

  @override
  Future<Message> call(LoginParameters parameters) async {
    return await baseRepository.login(parameters);
  }
}

class LoginParameters extends Equatable {
  final String name;
  final String password;
  final BuildContext context;
  const LoginParameters(this.name, this.password, this.context);

  @override
  List<Object?> get props => [name, password, context];
}
