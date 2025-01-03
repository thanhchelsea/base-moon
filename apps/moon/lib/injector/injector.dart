import 'package:auth/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:moon/app/cubit/app_cubit.dart';
import 'package:moon/core/constants.dart';
import 'package:network/network.dart';
import 'modules/bloc_modules.dart';

class Injector {
  Injector._();
  static GetIt instance = GetIt.instance;

  static void init() {
    NetworkPackage().init(
      baseUrl: ApiConfig.baseUrl,
      getGetAccessToken: () => instance<AppCubit>().state.accestoken,
    );
    Auth().init();
    BlocModule.init();
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
