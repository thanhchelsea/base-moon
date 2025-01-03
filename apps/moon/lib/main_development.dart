import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/app/view/app.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:moon/bootstrap.dart';
import 'package:moon/injector/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  Injector.init();
  //thêm đoạn này nếu back về muốn giữ trạng thái khi push và thay đổi đường dẫn
  GoRouter.optionURLReflectsImperativeAPIs = true;
  bootstrap(() => const App());
}
