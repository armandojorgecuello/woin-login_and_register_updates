import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';

import 'outline_input.dart';

class SearchDropdown<T> extends StatefulWidget {
      // Widget findDropdown<T>({@required T entity, void Function(T) onChanged, List<T> items, T other})
  final List<T> items;
  final void Function(T) onChanged;
  final T entity;
  final T other;
  final InputDecoration searchBoxDecoration;

  const SearchDropdown({@required this.onChanged, @required this.items, @required this.entity, this.other, this.searchBoxDecoration});

  @override
  _SearchDropdownState<T> createState() => _SearchDropdownState<T>();
}

class _SearchDropdownState<T> extends State<SearchDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return FindDropdown<T>(
      items: widget.items,
      selectedItem: widget.entity,
      onChanged: widget.onChanged,
      onFind: (String filter) async {
        if (widget.items == null) return [];
        return widget.items.where((sub) => sub.toString().toLowerCase().contains(filter.toLowerCase()) && sub.toString() != widget.other.toString()).toList();
      },
      dropdownBuilder: (BuildContext context, T item) {
        return AbsorbPointer(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: customTextField(
              context: context,
              text: widget.entity?.toString() ?? widget.searchBoxDecoration?.labelText ?? "",
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              readOnly: true,
              textStyle: widget.entity == null ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.black87)
            ),
          ),
        );
      },
      dropdownItemBuilder: (BuildContext context, T item, bool isSelected) {
        if (isSelected)
        {
          return Container(
            child: Text("${item.toString()}", style: TextStyle(color: Colors.white, fontSize: 14.0)),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(   
              color: Colors.blue[600],         
              borderRadius: BorderRadius.circular(0.0),
              border: Border.all(
                color: Colors.grey.withOpacity(0.4), style: BorderStyle.solid, width: 0.5,
              ),
            ),
          );
        } else {
          return Container(
            child: Text("${item.toString()}", style: TextStyle(color: Colors.black54, fontSize: 14.0)),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            margin: EdgeInsets.symmetric(vertical: 0.0),
            decoration: BoxDecoration(            
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(
                color: Colors.grey.withOpacity(0.4), style: BorderStyle.solid, width: 1,
              ),
            ),
          );
        }
      },
      searchBoxDecoration: widget.searchBoxDecoration,
    );
  }
}