import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/widgets.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return (!context.watch<UserCubit>().state.isLoading)
        ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: userCubit.state.users.length,
                  itemBuilder: (context, index) {
                    return CustomUserCard(user: userCubit.state.users[index]);
                  },
                ),
              ),
            ],
          )
        : const CustomLoadingWidget();
  }
}
