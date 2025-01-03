import 'package:equatable/equatable.dart';

enum PageState { INITIAL, LOADING, FAIL, SUCCESS }

extension PageStateExtension on PageState {
  Map<String, dynamic> toMap() {
    return {
      'value': toString().split('.').last,
    };
  }

  static PageState fromMap(Map<String, dynamic> map) {
    switch (map['value']) {
      case 'INITIAL':
        return PageState.INITIAL;
      case 'LOADING':
        return PageState.LOADING;
      case 'FAIL':
        return PageState.FAIL;
      case 'SUCCESS':
        return PageState.SUCCESS;
      default:
        throw Exception('Invalid PageState');
    }
  }
}

enum ErrorType {
  network,
  api,
  badRequest,
  internalServerError,
  unauthorized,
  unknown,
  none,
}

class BaseState extends Equatable {
  const BaseState({
    this.pageState = PageState.INITIAL,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  final PageState pageState;
  final String message;
  final ErrorType errorType;
  BaseState copyWith({
    PageState? pageState,
    String? message,
    ErrorType? errorType,
  }) {
    return BaseState(
      pageState: pageState ?? this.pageState,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }

  @override
  String toString() {
    return 'BaseStateTest{pageState: $pageState, message: $message, errorType: $errorType}';
  }

  @override
  List<Object?> get props => [pageState, message, errorType];
}
