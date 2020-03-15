import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/models/category_model.dart';
import 'package:todo_app/ui/pages/categories/category_bloc.dart';
import 'package:todo_app/ui/widgets/flat_button_widget.dart';

class AddEditCategoryPage extends StatefulWidget {
  final CategoryModel category;
  final bool isEdit;

  const AddEditCategoryPage({Key key, this.category, this.isEdit})
      : super(key: key);

  @override
  _AddEditCategoryPageState createState() => _AddEditCategoryPageState();
}

class _AddEditCategoryPageState extends BaseState<AddEditCategoryPage> {
  TextEditingController _nameController = new TextEditingController();
  Color _color = Colors.green;

  CategoriesBloc bloc;

  @override
  void initState() {
    bloc = new CategoriesBloc(this);
    super.initState();
    if (widget.isEdit) {
      _color = widget.category.color;
      _nameController.text = widget.category.name;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit Category" : "Add New Category"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Category name",
                ),
              ),
            ),
            Divider(indent: 16, endIndent: 16),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                "Category Color",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 21,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: MaterialColorPicker(
                physics: NeverScrollableScrollPhysics(),
                selectedColor: _color,
                shrinkWrap: true,
                elevation: 0,
                allowShades: false,
                onMainColorChange: (color) => _color = color,
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: FlatButtonWidget(
                callback: _addCategory,
                textStyle: TextStyle(fontSize: 16),
                text: widget.isEdit ? "Edit" : "Add",
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _addCategory() async {
    if (_nameController.text.trim().isEmpty) {
      showErrorMsg("Please enter category name");
      return;
    } else if (_color == null) {
      showErrorMsg("Please select category color");
      return;
    } else {
      showLoading();
      if (widget.isEdit)
        await bloc.editCategory(widget.category,
            new CategoryModel(_nameController.text.trim(), _color));
      else
        await bloc.addCategory(
            new CategoryModel(_nameController.text.trim(), _color));
      hideLoading();
      Navigator.pop(context);
    }
  }
}
