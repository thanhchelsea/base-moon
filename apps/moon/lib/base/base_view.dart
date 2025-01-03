import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moon/app/cubit/app_cubit.dart';
import 'package:moon/app/cubit/app_state.dart';
import 'package:moon/router/app_routes.dart';
import 'package:template/template.dart';
import 'base_cubit.dart';
import 'base_state.dart';

class BaseView<C extends BaseCubit<S>, S extends BaseState> extends StatelessWidget {
  BaseView({
    required this.cubit,
    required this.builder,
    this.loadingWidget,
    this.colorBarrier,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    super.key,
    this.centerWidgetAppbar,
    this.appBarActions = const [],
    this.showBoxSearchCenterAppBar = false,
    this.onChangeBoxSearchCenterAppBar,
    this.showAppbar = true,
    this.isShowSideBar = false,
  });

  final Widget Function(BuildContext context, S state) builder;
  final C cubit;
  final Widget? loadingWidget;
  final Color? colorBarrier;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool isShowSideBar;
//appbar
  bool showAppbar;
  Widget? centerWidgetAppbar;
  List<Widget> appBarActions;
  bool showBoxSearchCenterAppBar;
  Function? onChangeBoxSearchCenterAppBar;

  ThemeColorExtension? themeColorExt;
  late TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    themeColorExt = Theme.of(context).extension<ThemeColorExtension>();
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      backgroundColor: backgroundColor ?? const Color.fromARGB(255, 246, 249, 255),
      body: SelectableRegion(
        focusNode: FocusNode(),
        selectionControls: emptyTextSelectionControls,
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(child: builder(context, cubit.state)),
                        ],
                      ),
                      BlocConsumer<C, S>(
                        bloc: cubit,
                        buildWhen: (previous, current) {
                          return previous.pageState != current.pageState;
                        },
                        builder: (context, state) {
                          if (state.pageState == PageState.LOADING) {
                            return _showLoading(context);
                          }
                          return Container();
                        },
                        listenWhen: (previous, current) {
                          return previous.errorType != current.errorType;
                        },
                        listener: (BuildContext context, S state) {
                          if (state.errorType == ErrorType.unauthorized) {
                            //todo dieu huong man hinh sang man hinh dang nhap
                            context.go(AppRoutes.signInPath);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _showLoading(BuildContext context) {
    return Stack(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        ModalBarrier(
          color: colorBarrier, // Colors.black12.withOpacity(0.05),
          dismissible: false,
        ),
        Center(
          child: loadingWidget ??
              LoadingAnimationWidget.inkDrop(
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
        ),
      ],
    );
  }
}
