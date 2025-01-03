import 'package:moon/app/cubit/app_cubit.dart';
import 'package:moon/injector/injector.dart';

class BlocModule {
  BlocModule._();

  static void init() {
    final injector = Injector.instance;

    injector
          ..registerLazySingleton<AppCubit>(
            () => AppCubit(),
          )
        // ..registerLazySingleton<SignInCubit>(
        //   () => SignInCubit(
        //     authUsecase: injector(),
        //   ),
        // )
        ;
  }
}
