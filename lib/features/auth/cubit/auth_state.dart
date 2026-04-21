part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}
class AuthInitial extends AuthState {}

class AuthUserNotFound extends AuthState {}

class AuthEmailAlreadyExists extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCanceled extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}



class AuthFormUpdated extends AuthState {
  final int timestamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [timestamp];
}