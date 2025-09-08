import 'package:flutter/material.dart';

class CitySearchBar extends StatefulWidget{
  final void Function(String) onSearched;
  const CitySearchBar({super.key, required this.onSearched});

  @override
  State<CitySearchBar> createState() => _CitySearchBarState();
}
class _CitySearchBarState extends State<CitySearchBar> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Expanded(child: TextField(
          controller: controller,
          onSubmitted: widget.onSearched,
          decoration: InputDecoration(
            hintText: 'Search City',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              onPressed: (){
                widget.onSearched(controller.text);
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ),
        )
      ],
    );
  }
}