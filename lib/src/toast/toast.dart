import 'package:flutter/material.dart';
import 'package:overlay_support/src/overlay.dart';
import 'package:overlay_support/src/theme.dart';

class Toast {
  Toast._private();

  ///Show the view or text notification for a short period of time.  This time
  ///could be user-definable.  This is the default.
  static const LENGTH_SHORT = const Duration(milliseconds: 2000);

  ///Show the view or text notification for a long period of time.  This time
  ///could be user-definable.
  static const LENGTH_LONG = const Duration(milliseconds: 3500);
}

///popup a message in front of screen
///
/// [duration] the duration to show a toast,
/// for most situation, you can use [Toast.LENGTH_SHORT] and [Toast.LENGTH_LONG]
///
void toast(String message, {Duration duration = Toast.LENGTH_SHORT}) {
  if (duration <= Duration.zero) {
    //fast fail
    return;
  }

  showOverlay((context, animation) {
    return FadeTransition(
      opacity: CurveTween(curve: Curves.ease).animate(animation),
      child: _Toast(content: Text(message)),
    );
  }, key: const ValueKey('overlay_toast'), duration: duration);
}

class _Toast extends StatelessWidget {
  final Widget content;

  const _Toast({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toastTheme = OverlaySupportTheme.toast(context);
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DefaultTextStyle(
          style: TextStyle(color: toastTheme.textColor),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: toastTheme.alignment,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: toastTheme?.background,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
