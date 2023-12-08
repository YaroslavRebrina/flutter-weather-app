import 'package:flutter/material.dart';

class SearchBarWeather extends StatelessWidget {
  const SearchBarWeather({super.key, required this.onSearch});

  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return SearchBar(
      controller: textController,
      onSubmitted: (value) => onSearch(value),
      hintText: 'Enter city name',
      trailing: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            onSearch(textController.text, );
          },
        )
      ],
    );
  }
}
