import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/dimensions.dart';

class CustomDropdownWidget extends StatefulWidget {
  final List<String> items;
  final String? initialSelectedItem;
  final ValueChanged<String?>? onChanged;
  final String? textTitle;

  const CustomDropdownWidget({
    super.key,
    required this.items,
    this.initialSelectedItem,
    this.onChanged,
    this.textTitle = 'Select',
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownWidgetState createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  late String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialSelectedItem ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: dimensions.height5),
        Text(
          widget.textTitle!,
          style: TextStyle(
            fontSize: dimensions.fontSize15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: dimensions.height5),
        Container(
          height: dimensions.height20 * 2,
          width: dimensions.screenWidth,
          padding: EdgeInsets.symmetric(horizontal: dimensions.height10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              //isExpanded: true
              borderRadius: BorderRadius.circular(dimensions.radius15),
              value: _selectedItem,
              hint: Text(
                'Choose an item',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: dimensions.fontSize15,
                ),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
              ),
              iconSize: dimensions.iconsize16 * 2,
              //isExpanded: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: dimensions.fontSize15,
              ),
              items: widget.items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem = newValue;
                });

                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
