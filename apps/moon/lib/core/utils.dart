import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:template/template.dart';

import '../../generated/assets.gen.dart';

class Utils {
  Utils._();

  static void showToast({
    required ToastType toastType,
    required String message,
    String? buttonTitle,
    bool isHasTrailing = true,
    bool isHasAction = false,
    Duration? duration,
    Function()? onActionButtonClick,
  }) {
    showOverlay(
      (_, t) {
        return Opacity(
          opacity: t,
          child: SafeArea(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Row(
                children: [
                  BaseToast(
                    toastType: toastType,
                    message: message,
                    buttonTitle: buttonTitle,
                    isHasTrailing: isHasTrailing,
                    isHasAction: isHasAction,
                    onActionButtonClick: onActionButtonClick,
                    onTrailingClick: (context) => OverlaySupportEntry.of(context)?.dismiss(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      duration: duration ?? Duration(milliseconds: message.length < 40 ? 4000 : 7000),
      key: const ValueKey('toast'),
    );
  }

  static void showBaseDialog({
    required BuildContext context,
    required DialogType dialogType,
    required String title,
    required String content,
    String? leftButtonTitle,
    String? rightButtonTitle,
    Function()? onLeftButtonClick,
    Function()? onRightButtonClick,
    Widget? customContent,
    bool showIconDialog = true,
    Widget? customTitle,
    bool showPopIcon = true,
    EdgeInsetsGeometry? paddingAction,
    Function? then,
    bool showLeftButton = true,
    bool showRightButton = true,
    double? width,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return BaseDialog(
          dialogType: DialogType.confirm,
          title: title,
          width: width,
          iconDialog: showIconDialog ? getIconDialog(dialogType) : null,
          content: content,
          leftButtonTitle: leftButtonTitle,
          rightButtonTitle: rightButtonTitle,
          onLeftButtonClick: onLeftButtonClick,
          onRightButtonClick: onRightButtonClick,
          customContent: customContent,
          customTitle: customTitle,
          showPopIcon: showPopIcon,
          paddingAction: paddingAction,
          showLeftButton: showLeftButton,
          showRightButton: showRightButton,
        );
      },
    ).then((value) => then?.call());
  }

  static Widget getIconDialog(DialogType dialogType) {
    switch (dialogType) {
      case DialogType.info:
        return SvgPicture.asset(
          Assets.icons.icDialogInfo.path,
          width: 40,
        );
      case DialogType.success:
        return SvgPicture.asset(
          Assets.icons.icDialogSuccess.path,
          width: 40,
        );
      case DialogType.question:
        return Assets.icons.icDialogConfirm.svg(
          width: 40,
        );
      case DialogType.warning:
        return SvgPicture.asset(
          Assets.icons.icDialogWarning.path,
          width: 40,
        );
      case DialogType.error:
        return SvgPicture.asset(
          Assets.icons.icDialogError.path,
          width: 40,
        );
      case DialogType.confirm:
        return SvgPicture.asset(
          Assets.icons.icDialogConfirm.path,
          width: 40,
        );
    }
  }

  static Color colorDirectionName(String direction) {
    if (direction == 'I') {
      return Colors.green;
    }
    return Colors.redAccent;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static int getDaysInMonth(int year, int month) {
    // Tạo ngày đầu tiên của tháng tiếp theo
    DateTime nextMonth = (month == 12)
        ? DateTime(year + 1, 1, 1) // Nếu tháng là 12, chuyển sang tháng 1 của năm sau
        : DateTime(year, month + 1, 1);

    // Lấy ra ngày cuối cùng của tháng hiện tại bằng cách trừ 1 ngày từ ngày đầu tiên của tháng tiếp theo
    DateTime lastDayOfMonth = nextMonth.subtract(Duration(days: 1));

    return lastDayOfMonth.day; // Trả về số ngày trong tháng
  }

  static Color getColor(int index) {
    List<Color> defaultColor = const [
      Color(0xFFFF6F61), // Đỏ cam
      Color(0xFFEFC050), // Vàng nắng
      Color(0xFF92A8D1), // Xanh da trời nhạt
      Color(0xFF009B77), // Xanh lá cây đậm
      Color(0xFF5B5EA6), // Xanh chàm
      Color(0xFFD65076), // Hồng đậm
      Color(0xFF45B8AC), // Xanh ngọc
      Color(0xFFDFCFBE), // Be nhạt
      Color(0xFFBC243C), // Đỏ rượu
      Color(0xFF955251), // Nâu đỏ
      Color(0xFF88B04B), // Xanh lá cây nhạt
      Color(0xFF98B4D4), // Xanh dương pastel
      Color(0xFFB565A7), // Tím oải hương
      Color(0xFF6B5B95), // Tím đậm
      Color(0xFFF7CAC9), // Hồng nhạt
    ];
    if (index < defaultColor.length) {
      return defaultColor[index];
    } else {
      int r = (index * 50) % 256; // Đỏ
      int g = (index * 100) % 256; // Xanh lá
      int b = (index * 150) % 256; // Xanh dương
      // Tối ưu hóa màu sắc
      r = (r + 50) % 256; // Thêm 50 để làm cho màu sáng hơn
      g = (g + 50) % 256; // Thêm 50 để làm cho màu sáng hơn
      b = (b + 50) % 256; // Thêm 50 để làm cho màu sáng hơn
      return Color.fromARGB(255, r, g, b); // Màu RGBA
    }
  }
}
