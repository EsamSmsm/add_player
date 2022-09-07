import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/users_model.dart';
import '../../logic/cubit/user_cubit/user_cubit.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    Key? key,
    required this.player,
    this.isRemovable = true,
  }) : super(key: key);

  final UserModel player;
  final bool isRemovable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(player.image),
              backgroundColor: Colors.grey.shade300,
              radius: 30.r,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              '${player.firstName} ${player.lastName}',
              style: TextStyle(color: Colors.black54, fontSize: 12.sp),
            ),
          ],
        ),
        Positioned(
            top: -15.h,
            right: -5.w,
            child: Center(
              child: IconButton(
                onPressed: () {
                  UserCubit.get(context).removePlayer(player);
                },
                icon: const Icon(Icons.remove_circle),
                color: Colors.red,
              ),
            )),
      ],
    );
  }
}

class CurrentUserTile extends StatelessWidget {
  const CurrentUserTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          radius: 30.r,
          child: const Icon(CupertinoIcons.person_alt),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          'Esam Smesm',
          style: TextStyle(color: Colors.black54, fontSize: 12.sp),
        ),
      ],
    );
  }
}
