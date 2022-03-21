import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../domain/entities/user.dart';
import '../bloc/paginated_list_bloc.dart';

class SearchBar extends StatelessWidget {
  // final Future<void> Function(String city) onSubmitted;
  final List<User> users;
  final TextEditingController _typeAheadController = TextEditingController();

  SearchBar({
    // required this.onSubmitted,
    required this.users,
    Key? key,
  }) : super(key: key);

  List<String> _getSuggestions(List<User> users, String query) {
    List<String> matches = [];

    for (var user in users) {
      matches.add("${user.name.firstName} ${user.name.lastName}");
    }

    matches.retainWhere((s) => s.toLowerCase().startsWith(query.toLowerCase()));
    return matches.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.search,
          controller: _typeAheadController,
          decoration: InputDecoration(
            hintText: 'Search here',
            hintStyle: const TextStyle(fontSize: 16, color: Colors.white),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        suggestionsCallback: (pattern) {
          return pattern.trim().isNotEmpty
              ? _getSuggestions(users, pattern)
              : [];
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion as String),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          _typeAheadController.text = suggestion as String;
          BlocProvider.of<PaginatedListBloc>(context)
              .add(SearchResultsEvent(query: suggestion.toString()));
          //onSubmitted(suggestion);
        },
      ),
    );
  }
}
