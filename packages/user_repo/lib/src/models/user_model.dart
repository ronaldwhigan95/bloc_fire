import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel(this.user_id, this.firstName, this.lastName, this.email);

  final String user_id;
  final String firstName;
  final String lastName;
  final String email;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  static const emptyUser =
      UserModel("user_id", "firstName", "lastName", "email");
}
