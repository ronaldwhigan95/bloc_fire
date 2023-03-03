import 'package:user_repo/src/models/models.dart';
import 'package:uuid/uuid.dart';

class UserRepo {
  UserModel? _userModel;

  Future<UserModel?> getUserDetails() async {
    if (_userModel != null) return _userModel;
    return Future.delayed(
        const Duration(milliseconds: 500),
        //Generation of RFC4122 UUIDs for placeholders
        () => _userModel = UserModel(const Uuid().v4(), const Uuid().v4(),
            const Uuid().v4(), const Uuid().v4()));
  }
}
