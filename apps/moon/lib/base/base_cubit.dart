import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon/core/utils.dart';
import 'package:network/network.dart';
import 'package:template/template.dart';

import 'base_state.dart';

enum CallDataServiceStatus {
  success,
  fail,
}

abstract class BaseCubit<Y extends BaseState> extends Cubit<Y> {
  BaseCubit(super.initialState);

  // void updatePageState(PageState x) {
  //   emit(state.copyWith(pageState: x) as Y);
  // }

  // List<CallDataServiceFunction> _failedRequests = [];
  List<Future<dynamic> Function()> _failedRequests = [];

  void showLoading() {
    emit(state.copyWith(pageState: PageState.LOADING) as Y);
  }

  void hideLoading(PageState status) {
    emit(
      state.copyWith(
        pageState: status,
        errorType: status == PageState.SUCCESS ? ErrorType.none : null,
      ) as Y,
    );
  }

  void showErrorMessage(String msg, {bool isHasTrailing = true}) {
    _showErrorToast(msg, isHasTrailing);
  }

  void showSuccessToast(String message) {
    Utils.showToast(
      toastType: ToastType.success,
      message: message,
      isHasTrailing: true,
    );
  }

  void _showErrorToast(String message, bool isHasTrailing) {
    Utils.showToast(
      toastType: ToastType.error,
      message: message,
      isHasTrailing: isHasTrailing,
    );
  }

  //======call hàm bất đồng bộ=======
  Future<CallDataServiceStatus> callDataService<T>(
    Future<T> future, {
    required Function(T response) onSuccess,
    Function(dynamic exception)? onError,
    VoidCallback? onStart,
    VoidCallback? onComplete,
    bool isShowError = true,
    bool isShowLoading = true,
    bool isHasTrailingErrToast = true,
  }) async {
    var exception;
    if (onStart != null) onStart.call();
    if (isShowLoading) showLoading();

    // try {
    await future
        .then((value) {
          onSuccess(value);
        })
        .onApiError
        .catchError(
          (e) {
            exception = e;
            print(
              '===== error type: ${exception.runtimeType}  $exception',
            );
            ErrorType errorType = ErrorType.unknown;

            if (isShowError) {
              ExceptionHelper.handleBaseException(
                e: e,
                onApiException: (apiException) {
                  errorType = ErrorType.api;
                  _showErrorToast(
                    apiException.errors?.join(', ') ?? '',
                    isHasTrailingErrToast,
                  );
                  //todo access token expried
                },
                onNetworkException: (exception) {
                  errorType = ErrorType.network;
                  _showErrorToast(
                    'Lỗi kết nối tới máy chủ',
                    isHasTrailingErrToast,
                  );
                },
                onBadRequest: (badRequest) {
                  errorType = ErrorType.badRequest;
                  _showErrorToast(
                    badRequest.reason ?? '',
                    isHasTrailingErrToast,
                  );
                },
                onInternalServerError: (error) {
                  errorType = ErrorType.internalServerError;
                  _showErrorToast(
                    'Máy chủ bận. Vui lòng thử lại sau',
                    isHasTrailingErrToast,
                  );
                },
                onUnKnowException: (exception) {
                  errorType = ErrorType.unknown;
                  _showErrorToast(
                    'Có lỗi xảy ra vui lòng thử lại sau',
                    isHasTrailingErrToast,
                  );
                },
              );
            }
            emit(state.copyWith(errorType: errorType) as Y);
          },
        );
    // } catch (error) {
    //   exception = AppException(message: '$error');
    //   _showErrorToast(
    //     "Có lỗi xảy ra vui lòng thử lại sau",
    //     isHasTrailingErrToast,
    //   );
    //   if (onError != null) onError(exception);
    // }
    if (isShowLoading) {
      hideLoading(exception != null ? PageState.FAIL : PageState.SUCCESS);
    }
    if (onError != null && exception != null) onError(exception);

    onComplete?.call();
    //trả về trạng thái khi call api nhé.
    return exception != null ? CallDataServiceStatus.fail : CallDataServiceStatus.success;
  }

  void insertFailedRequest(Function request) {
    _failedRequests.add(request as Future Function());
  }

  //hàm xử lý recall api ...
  Future<void> retryFailedRequests() async {
    if (_failedRequests.isEmpty) return;
    var failedRequestsCopy = [..._failedRequests];
    //clear mảng  api call lỗi
    _failedRequests = [];
    // chạy hết vòng lặp để recall lại api lỗi
    await Future.forEach(failedRequestsCopy, (request) async {
      await request.call();
    });
  }
}

class CustomBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    // Do nothing to disable event logging
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // Do nothing to disable transition logging
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Do nothing to disable error logging
    super.onError(bloc, error, stackTrace);
  }
}
