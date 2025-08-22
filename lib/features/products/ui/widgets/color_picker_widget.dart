import 'package:flutter/material.dart';
import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/app/app_constants.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    super.key,
    this.colors = const ["Green", "Red", "Blue", "Yellow"],
    this.onChangeColor,
  });

  final List<String> colors;
  final void Function(String)? onChangeColor;
  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late Color _selectedColor;
  final Map<String, Color> _colors = {};

  @override
  void initState() {
    for (String color in widget.colors) {
      _colors[color] = AppConstants.colors[color] ?? Colors.black;
    }
    if (widget.colors.isNotEmpty) {
      _selectedColor = _colors[widget.colors.first] ?? AppColors.themeColor;
    } else {
      _selectedColor = AppColors.themeColor;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: _colors.entries.map((entry) {
        return GestureDetector(
          onTap: () {
            _selectedColor = entry.value;
            widget.onChangeColor?.call(entry.key);
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: entry.value,
              shape: BoxShape.circle,
              border: Border.all(
                color: entry.value == Colors.white
                    ? AppColors.themeColor
                    : Colors.transparent,
              ),
            ),
            width: 28,
            height: 28,
            child: Icon(
              Icons.check,
              color: _selectedColor != entry.value
                  ? Colors.transparent
                  : entry.value == Colors.white
                      ? AppColors.themeColor
                      : Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}
