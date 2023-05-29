import 'package:food_xyz_project/repositories.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    this.displayText = 'Cari',
    required this.onChanged,
    required this.searchController,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;
  final String displayText;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: searchBarDecoration(),
      onChanged: widget.onChanged,
      controller: widget.searchController,
    );
  }

  InputDecoration searchBarDecoration() {
    return InputDecoration(
      labelText: widget.displayText,
      filled: true,
      fillColor: const Color.fromARGB(199, 221, 221, 221),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      suffixIcon: const Icon(Icons.search),
    );
  }
}
