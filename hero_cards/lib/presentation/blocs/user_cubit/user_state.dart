part of 'user_cubit.dart';

class UserState extends Equatable {
  final List<Object> users;
  final bool isLoading;

  const UserState({
    this.users = const [],
    this.isLoading = false,
  });

  UserState copyWith({
    List<Object>? users,
    bool? isLoading,
  }) =>
      UserState(
        users: users ?? this.users,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [
        users,
        isLoading,
      ];
}
