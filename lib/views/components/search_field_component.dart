part of 'components.dart';

class SearchFieldComponents extends StatefulWidget {
  const SearchFieldComponents({
    Key? key,
    required this.searchController,
  }) : super(key: key);
  final TextEditingController searchController;

  @override
  _SearchFieldComponentsState createState() => _SearchFieldComponentsState();
}

class _SearchFieldComponentsState extends State<SearchFieldComponents> {
  String? keyword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 8,
        left: 23,
        right: 23,
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            keyword = value;
          });
        },
        controller: widget.searchController,
        cursorColor: cBlue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Cari Resi",
          prefixIcon: Icon(
            Icons.search,
            color: cBlue,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
