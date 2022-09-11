import 'dart:developer';

import 'package:add_player/config.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/users_model.dart';
import '../../../data/repositories/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UsersRepo _usersRepo;
  UserCubit(this._usersRepo) : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];
  List<UserModel?> players = List.generate(10, (index) => null);

  Future<void> getUsers({required int limit}) async {
    emit(GetUsersLoading());
    try {
      users = await _usersRepo.getUsers(limit: limit, skip: 0);
      emit(GetUsersSuccess());
    } catch (e) {
      emit(GetUsersFailed(error: e.toString()));
      log('error: $e');
    }
  }

  int skip = 0;
  Future<void> loadMoreUsers({
    required int limit,
  }) async {
    emit(LoadMoreUsersLoading());
    skip += AppConfig.usersPageLimit;
    try {
      final moreUsers = await _usersRepo.getUsers(limit: limit, skip: skip);
      if (moreUsers.isNotEmpty) {
        users.addAll(moreUsers);
      }
      emit(LoadMoreUsersSuccess());
    } catch (e) {
      emit(LoadMoreUsersFailed(error: e.toString()));
    }
  }

  int currentIndex = 0;
  Future<void> addPlayer(UserModel user) async {
    emit(AddPlayerLoading());
    if (currentIndex < players.length) {
      user.isAdded = true;
      players.insert(currentIndex, user);
      players.removeLast();
      currentIndex++;
      emit(AddPlayerSuccess());
    } else {
      emit(AddPlayerFailed());
    }
  }

  Future<void> removePlayer(UserModel user) async {
    emit(AddPlayerLoading());
    if (currentIndex > 0) {
      user.isAdded = false;
      players.remove(user);
      players.add(null);
      currentIndex--;
      emit(AddPlayerSuccess());
    }
  }
}
