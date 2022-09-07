import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/users_model.dart';
import '../../logic/cubit/user_cubit/user_cubit.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.user,
    required this.usersCubit,
  }) : super(key: key);

  final UserModel user;
  final UserCubit usersCubit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${user.firstName} ${user.lastName}'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.image),
        backgroundColor: Colors.grey.shade300,
        radius: 25.r,
      ),
      trailing: TextButton(
        onPressed: () {
          if (user.isAdded) {
            usersCubit.removePlayer(user);
          } else {
            usersCubit.addPlayer(user);
          }
        },
        style: ButtonStyle(
          backgroundColor: user.isAdded
              ? MaterialStateProperty.all(Colors.red)
              : MaterialStateProperty.all(Colors.blue),
        ),
        child: user.isAdded
            ? const Text("Remove", style: TextStyle(color: Colors.white))
            : const Text("Add", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
