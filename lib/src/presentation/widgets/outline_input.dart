import 'package:flutter/material.dart';

class OutlineInputDecoration {
  InputDecoration _decoration;
  InputDecoration get decoration => _decoration;
  set decoration(InputDecoration decoration) => _decoration = decoration;
  
  OutlineInputDecoration({Color fillColor = Colors.blue, Text hintText = const Text(""), Color hintColor = Colors.grey, Color borderColor = Colors.grey, bool bordered = false, Icon suffixIcon}) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: bordered ? borderColor : Colors.transparent,
        width: bordered ? 1 : 0.0,
        style: bordered ? BorderStyle.solid : BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(50.0),
    );
    _decoration = InputDecoration(
      filled: true,
      fillColor: fillColor,
      enabledBorder: outlineInputBorder,
      border: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      labelText: hintText.data,
      labelStyle: hintText.style,
      errorStyle: TextStyle(height: 0.0),
      suffixIcon: suffixIcon
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.keyboard_arrow_down),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

Widget customTextField({@required String text, @required BuildContext context, TextEditingController controller, TextInputType keyboardType = TextInputType.text, bool bordered = true, void Function(String) onChanged, Color fill = Colors.transparent, bool enabled = true, bool enableInteraction = true, void Function() onTap, String Function(String) validator, FocusNode focusNode, void Function() onEditingComplete, Icon suffixIcon, bool readOnly = false, TextStyle textStyle}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: TextFormField(
        style: TextStyle(color: Colors.black87, fontSize: 12.0),
        readOnly: readOnly,
        enabled: enabled,
        controller: controller,
        enableInteractiveSelection: enableInteraction,
        textInputAction: TextInputAction.done,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        validator: validator,
        decoration: OutlineInputDecoration(
          fillColor: fill,
          hintText: Text(text, style: textStyle),
          hintColor: Colors.grey,
          bordered: bordered,
          borderColor: Colors.grey,
          suffixIcon: suffixIcon,
        ).decoration,
        onChanged: onChanged,
        onTap: onTap,
        keyboardType: keyboardType,
      ),
    );
  }