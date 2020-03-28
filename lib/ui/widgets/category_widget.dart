import 'package:flutter/material.dart';
import 'package:todo_app/core/models/category_model.dart';

class CategoryWidget extends StatefulWidget {
  final CategoryModel category;
  final callback;

  const CategoryWidget({Key key, this.category, this.callback})
      : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 12, left: 16, right: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: widget.callback,
        child: Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: 8),
              Expanded(child: Text(widget.category.name)),
              IconButton(
                  icon: Icon(Icons.brightness_1, color: widget.category.color),
                  onPressed: null)
            ],
          ),
        ),
      ),
    );
  }
}
