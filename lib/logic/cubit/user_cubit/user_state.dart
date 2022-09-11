part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetUsersLoading extends UserState {}

class GetUsersSuccess extends UserState {}

class GetUsersFailed extends UserState {
  final String error;
  GetUsersFailed({required this.error});
}

class LoadMoreUsersLoading extends UserState {}

class LoadMoreUsersSuccess extends UserState {}

class LoadMoreUsersFailed extends UserState {
  final String error;
  LoadMoreUsersFailed({required this.error});
}

class AddPlayerLoading extends UserState {}

class AddPlayerSuccess extends UserState {}

class AddPlayerFailed extends UserState {}
