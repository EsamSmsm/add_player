import 'dart:developer';

import 'package:add_player/config.dart';
import 'package:add_player/data/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/cubit/user_cubit/user_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/player_tile.dart';
import '../widgets/user_tile.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({Key? key}) : super(key: key);

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  var scrollController = ScrollController();
  late List<UserModel> searchedUsers;
  late List<UserModel> users;
  late List<UserModel?> players;
  final searchController = TextEditingController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        Future.delayed(const Duration(microseconds: 500));
        UserCubit.get(context).loadMoreUsers(limit: AppConfig.usersPageLimit);
        log('loading more...');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void addSearchedItemToSearchedList(String searchedItem) {
    searchedUsers = users
        .where((character) =>
            character.firstName.toLowerCase().startsWith(searchedItem))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Players',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          UserCubit usersCubit = UserCubit.get(context);
          users = usersCubit.users;
          players = usersCubit.players;
          return usersCubit.users.isEmpty && state is GetUsersLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 120.h,
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: players.length + 1,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16.w),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return const CurrentUserTile();
                            } else {
                              return players[index - 1] == null
                                  ? const PlaceHolderTile()
                                  : PlayerTile(player: players[index - 1]!);
                            }
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: SizedBox(
                        height: 50.h,
                        child: buildSearchBar(context),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => UserTile(
                                  user: searchController.text.isEmpty
                                      ? users[index]
                                      : searchedUsers[index],
                                  usersCubit: usersCubit),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20.h),
                              itemCount: searchController.text.isEmpty
                                  ? users.length
                                  : searchedUsers.length,
                            ),
                            if (state is LoadMoreUsersLoading) ...[
                              Positioned(
                                  bottom: 10.h,
                                  child: const CircularProgressIndicator())
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 100.h,
        width: double.infinity,
        child: const Material(
          elevation: 10,
          child: Center(
            child: CustomButton(color: Colors.blue, text: 'Continue'),
          ),
        ),
      ),
    );
  }

  TextField buildSearchBar(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: (searchedItem) {
        addSearchedItemToSearchedList(searchedItem);
      },
      decoration: InputDecoration(
        labelText: 'Search by player name',
        isDense: true,
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: const Icon(CupertinoIcons.search),
        suffix: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            searchController.clear();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              CupertinoIcons.clear,
              size: 20.w,
              color: Colors.black45,
            ),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
      ),
    );
  }
}
