import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/constants.dart';

class FlatButtonWidget extends Container {
  FlatButtonWidget(
      {@required callback,
      double radius = Constants.btnRadius,
      String text,
      TextStyle textStyle,
      EdgeInsets childPadding = const EdgeInsets.all(16),
      Color color = Colors.cyan,
      double width = double.infinity})
      : super(
          width: width,
          child: FlatButton(
              onPressed: callback,
              color: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius)),
              child: Padding(
                padding: childPadding,
                child: Text(text, style: textStyle),
              )),
        );
}
