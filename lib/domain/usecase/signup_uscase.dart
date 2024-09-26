import 'package:equatable/equatable.dart';
import 'package:project2/core/success_message/message.dart';
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/repository/base_repository.dart';

class SignUpUseCase extends BaseUseCase<Message, SignUpParameters> {
  final BaseRepository baseRepository;
  SignUpUseCase(this.baseRepository);

  @override
  Future<Message> call(SignUpParameters parameters) async {
    return await baseRepository.signUp(parameters);
  }
}

class SignUpParameters extends Equatable {
  final String name;
  final String email;
  final String password;
  const SignUpParameters(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}
