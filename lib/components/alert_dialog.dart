import 'package:craft/components/color.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatefulWidget {
  final String? title;
  final VoidCallback? onTapYes;
  const AlertDialogWidget(
      {Key? key, required this.title, required this.onTapYes})
      : super(key: key);

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.white,
      content: Text(widget.title!,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColors.primaryColor,
          )),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('NO',
              style: TextStyle(
                color: AppColors.primaryColor,
              )),
        ),
        TextButton(
          onPressed: widget.onTapYes,
          child: Text('YES',
              style: TextStyle(
                color: AppColors.primaryColor,
              )),
        ),
      ],
    );
  }
}
