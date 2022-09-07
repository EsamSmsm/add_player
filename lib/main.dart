import 'package:add_player/config.dart';
import 'package:add_player/data/repositories/user_repo.dart';
import 'package:add_player/data/services/users_services.dart';
import 'package:add_player/logic/cubit/user_cubit/user_cubit.dart';
import 'package:add_player/presentation/screens/add_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic/debug/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(ScreenUtilInit(
      designSize: const Size(428, 926), builder: (_, __) => MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UsersServices usersServices = UsersServices();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UsersRepo>(
          create: (context) => UsersRepo(usersServices),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(
              RepositoryProvider.of<UsersRepo>(context),
            )..getUsers(limit: AppConfig.usersPageLimit),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const AddPlayerScreen(),
        ),
      ),
    );
  }
}
