import 'package:flutter/material.dart';

class RoundedCornerCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final bool tristate;
  final MaterialTapTargetSize materialTapTargetSize;
  final double radius;

  RoundedCornerCheckbox({
    Key key,
    @required this.value,
    this.tristate = false,
    @required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.materialTapTargetSize,
    @required this.radius,
  })  : assert(tristate != null),
        assert(tristate || value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: Checkbox.width,
        height: Checkbox.width,
        child: Container(
          decoration: new BoxDecoration(
            border: Border.all(
                width: 2,
                color: Theme.of(context).unselectedWidgetColor ??
                    Theme.of(context).disabledColor),
            borderRadius: new BorderRadius.circular(radius),
          ),
          child: Checkbox(
            value: value,
            tristate: tristate,
            onChanged: onChanged,
            activeColor: activeColor,
            checkColor: checkColor,
            materialTapTargetSize: materialTapTargetSize,
          ),
        ),
      ),
    );
  }
}
