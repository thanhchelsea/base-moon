import 'package:moon/base/base_state.dart';

class AppState extends BaseState {
  AppState({
    super.pageState,
    super.message,
    super.errorType,
    this.locale = 'vi',
    this.accestoken,
  });
  final String locale;
  final String? accestoken;
  @override
  AppState copyWith({
    PageState? pageState,
    String? message,
    ErrorType? errorType,
    String? locale,
    String? accestoken,
    bool? isLoaded,
    // List<SidebarXItemModel>? sidebarMenu,
    List<String>? sizes,
  }) {
    return AppState(
      pageState: pageState ?? this.pageState,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
      locale: locale ?? this.locale,
      accestoken: accestoken ?? this.accestoken,
    );
  }

  @override
  List<Object?> get props => [
        pageState,
        message,
        errorType,
        locale,
        accestoken,
      ];
}
