import 'package:add_player/data/models/users_model.dart';
import 'package:add_player/data/services/users_services.dart';

class UsersRepo {
  final UsersServices _usersServices;

  UsersRepo(this._usersServices);

  Future<List<UserModel>> getUsers(
      {required int limit, required int skip}) async {
    try {
      List<UserModel> usersList = [];
      final result = await _usersServices.getUsers(limit: limit, skip: skip);
      usersList =
          result["users"].map<UserModel>((e) => UserModel.fromJson(e)).toList();
      return usersList;
    } catch (e) {
      rethrow;
    }
  }
}
