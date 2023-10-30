import "package:flutter/material.dart";

class DynamicCheckboxComponent extends StatefulWidget {

  const DynamicCheckboxComponent({ super.key, required this.onChangedAction });

  final Function onChangedAction;

  @override
  State<DynamicCheckboxComponent> createState() => _DynamicCheckboxComponentState();
}

class _DynamicCheckboxComponentState extends State<DynamicCheckboxComponent> {
  var isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked, 
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
        widget.onChangedAction(value);
      }
    );
  }
}