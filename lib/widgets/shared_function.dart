import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_svg/svg.dart';

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}


alertNotification({@required String message, @required BuildContext context}) {
  return BotToast.showSimpleNotification(
      title: message,
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor.withOpacity(.3),
      borderRadius: 10,
      duration: Duration(seconds: 4),
      align: Alignment.topCenter);
}



void actionAlertWidget(
    {@required BuildContext context, @required String alertType}) {
  YYDialog yyDialog = YYDialog();
  yyDialog.build(context)
    ..width = 120
    ..height = 110
    ..backgroundColor = Colors.black.withOpacity(0.8)
    ..borderRadius = 10.0
    ..useRootNavigator = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 21),
      child: SvgPicture.asset(
        alertType == 'error'
            ? 'assets/images/error.svg'
            : alertType == 'info'
            ? 'assets/images/info.svg'
            : 'assets/images/success.svg',
        width: 38,
        height: 38,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        alertType == 'error'
            ? 'Failed'
            : alertType == 'info'
            ? 'Info'
            : 'Success',
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    };
  yyDialog.show();
  Future.delayed(Duration(seconds: 2), () {
    yyDialog.dismiss();
  });
}

Future<void> showProgressDialog({
  @required BuildContext context,
  @required String message,
}) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.green,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 6.0,
                    ),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    SizedBox(
                      width: 26.0,
                    ),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
