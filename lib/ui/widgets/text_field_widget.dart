import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class TextFieldWidget extends Container {
  TextFieldWidget({
    @required TextEditingController controller,
    @required String label,
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    IconData prefixIcon,
    double radius = Constants.textFiledRadius,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          child: Theme(
            data: ThemeData(primaryColor: Colors.cyan),
            child: TextField(
              textAlign: textAlign,
              controller: controller,
              enabled: enabled,
              autofocus: false,
              keyboardType: keyboardType,
              maxLines: maxLines,
              decoration: InputDecoration(
                prefixIcon: Icon(prefixIcon),
                labelText: label,
                contentPadding: padding,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                    borderRadius: BorderRadius.circular(radius)),
              ),
            ),
          ),
        );
}
