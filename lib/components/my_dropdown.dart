import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;

  const MyDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      style: TextStyle(
        color: Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      underline: const SizedBox(),
      dropdownColor: Colors.grey.shade900,
      focusColor: Colors.grey.shade900,
      elevation: 0,
      items: items,
      onChanged: onChanged,
    );
  }
}
