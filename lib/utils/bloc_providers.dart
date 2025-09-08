import 'package:bloctodolist/core/widgets/features/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/features/auth/logic/bloc/auth_bloc.dart';
import '../core/widgets/features/auth/logic/bloc/auth_event.dart';
import '../core/widgets/features/task/logic/bloc/task_bloc.dart';

class AppProviders {
  static List<BlocProvider> get allProviders => [
    BlocProvider<AuthBloc>(
      create: (_) =>
          AuthBloc(authRepository: AuthRepository())..add(AppStarts()),
    ),
    BlocProvider<TaskBloc>(create: (_) => TaskBloc()),
    // add more blocs here
  ];
}
