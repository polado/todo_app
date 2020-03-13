import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class PasswordFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final TextAlign textAlign;
  final EdgeInsets padding;
  final double radius;

  const PasswordFieldWidget(
      {Key key,
      this.label,
      this.controller,
      this.enabled,
      this.textAlign = TextAlign.start,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      this.radius = Constants.textFiledRadius})
      : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: ThemeData(primaryColor: Colors.cyan),
        child: TextField(
          textAlign: widget.textAlign,
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: _obscureText,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: _obscureText ? Colors.grey : Colors.cyan,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                }),
            labelText: widget.label,
            contentPadding: widget.padding,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
                borderRadius: BorderRadius.circular(widget.radius)),
          ),
        ),
      ),
    );
  }
}
