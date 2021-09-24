import 'package:exercise/theme.dart';
import 'package:exercise/widgets/search_result_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchDelegate extends SearchDelegate {
  final String searchFieldLabel = 'Cari Kelas';
  final TextStyle searchFieldStyle = GoogleFonts.poppins(
    color: Color(0xff34364A),
    fontWeight: regular,
    fontSize: 12,
  );

  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.only(
          top: 7,
          bottom: 7,
          left: 12,
        ),
        hintStyle: searchFieldStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
          gapPadding: 0,
        ),
        filled: true,
        fillColor: whiteColor,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
        // IconButton(
        //   icon: Icon(Icons.clear),
        //   onPressed: () {
        //     if (query.isEmpty) {
        //       close(context, null);
        //     } else {
        //       query = '';
        //       showSuggestions(context);
        //     }
        //   },
        // )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: defaultMargin,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Result (5)',
                style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 14,
                ),
              ),
              SearchResultItem(),
              SearchResultItem(),
              SearchResultItem(),
              SearchResultItem(),
              SearchResultItem(),
            ],
          ),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    Widget suggestionItem(text) {
      return Container(
        decoration: BoxDecoration(
          color: secondaryButtonColor,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        margin: EdgeInsets.only(
          right: 12,
          top: 12,
        ),
        child: Text(
          text,
          style: primaryTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 12,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 28,
          ),
          Text(
            'Paling Dicari:',
          ),
          Row(
            children: [
              suggestionItem('Flutter'),
              suggestionItem('Laravel'),
              suggestionItem('Adobe Premiere'),
            ],
          ),
          Row(
            children: [
              suggestionItem('React'),
              suggestionItem('React Native'),
              suggestionItem('Javascript'),
            ],
          ),
          Row(
            children: [
              suggestionItem('Figma'),
              suggestionItem('Adobe XD'),
              suggestionItem('UI Design'),
            ],
          ),
          Row(
            children: [
              suggestionItem('UX Design'),
            ],
          ),
        ],
      ),
    );
  }

  // final suggestions = query.isEmpty
  //     ? recentCities
  //     : cities.where((city) {
  //         final cityLower = city.toLowerCase();
  //         final queryLower = query.toLowerCase();

  //         return cityLower.startsWith(queryLower);
  //       }).toList();

  // return buildSuggestionsSuccess(suggestions);
}

  // Widget buildSuggestionsSuccess(List<String> suggestions) =>

      // return ListTile(
      //   onTap: () {
      //     query = suggestion;

      //     // 1. Show Results
      //     showResults(context);

      //     // 2. Close Search & Return Result
      //     // close(context, suggestion);

      //     // 3. Navigate to Result Page
      //     //  Navigator.push(
      //     //   context,
      //     //   MaterialPageRoute(
      //     //     builder: (BuildContext context) => ResultPage(suggestion),
      //     //   ),
      //     // );
      //   },
      //   leading: Icon(Icons.location_city),
      //   // title: Text(suggestion),
      //   title: RichText(
      //     text: TextSpan(
      //       text: queryText,
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 18,
      //       ),
      //       children: [
      //         TextSpan(
      //           text: remainingText,
      //           style: TextStyle(
      //             color: Colors.grey,
      //             fontSize: 18,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // );
      // Column(
      //   children: [
      //     SizedBox(
      //       height: 28,
      //     ),
      //     Text(
      //       'Paling Dicari:',
      //     ),
      //     ListView.builder(
      //       itemCount: suggestions.length,
      //       itemBuilder: (context, index) {
      //         final suggestion = suggestions[index];
      //         final queryText = suggestion.substring(0, query.length);
      //         final remainingText = suggestion.substring(query.length);
      //         return Row(
      //           children: [
      //             Container(
      //               decoration: BoxDecoration(
      //                 color: secondaryButtonColor,
      //                 borderRadius: BorderRadius.circular(100),
      //               ),
      //               padding: EdgeInsets.symmetric(
      //                 vertical: 4,
      //                 horizontal: 12,
      //               ),
      //               margin: EdgeInsets.only(
      //                 left: 12,
      //                 top: 12,
      //               ),
      //               child: Text('Flutter'),
      //             ),
      //           ],
      //         );
      //       },
      //     ),
      //   ],
      // );
// }
