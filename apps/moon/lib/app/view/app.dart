import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon/app/cubit/app_cubit.dart';
import 'package:moon/app/cubit/app_state.dart';
import 'package:moon/injector/injector.dart';
import 'package:moon/router/app_router.dart';
import 'package:overlay_support/overlay_support.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppCubit _appCubit = Injector.instance();
  @override
  void initState() {
    _appCubit.onLoaded(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: BlocProvider<AppCubit>.value(
        value: _appCubit,
        child: BlocConsumer<AppCubit, AppState>(
          bloc: _appCubit,
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              locale: Locale(state.locale),
              // themeMode: state.themeData == ThemeSetting.dark ? ThemeMode.dark : ThemeMode.light,
              // theme: state.themeData.getTheme(context),
              // // AppThemes.lightTheme,
              // darkTheme: AppTheme.themeDark,
              routerConfig: appRouter,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                },
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
