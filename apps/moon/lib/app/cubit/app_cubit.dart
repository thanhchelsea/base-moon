import 'package:flutter/material.dart';
import 'package:moon/app/cubit/app_state.dart';
import 'package:moon/base/base_cubit.dart';

class AppCubit extends BaseCubit<AppState> {
  AppCubit()
      : super(
          AppState(),
        ) {}
  bool get isAuth => state.accestoken != null && state.accestoken!.isNotEmpty;
  Map<String, Color> transactionTypeColors = {};

  Future<void> onLoaded(BuildContext context) async {
    //get theme, language, user, token,...
  }
}
