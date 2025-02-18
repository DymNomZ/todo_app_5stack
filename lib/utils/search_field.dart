import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {

  final void Function(String) onChanged;

  const SearchField({super.key, required this.onChanged});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      style: TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.black),
        prefixIcon:  Icon(
          Icons.search,
          color: Colors.black,
          size: 20
        ),
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}