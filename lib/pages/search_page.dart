import 'package:exercise/providers/course_starter_provider.dart';
import 'package:exercise/theme.dart';
import 'package:exercise/widgets/search_result_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _queryTextController = TextEditingController();

  bool isSearch = true;

  @override
  Widget build(BuildContext context) {
    var courseStarterProvider = Provider.of<CourseStarterProvider>(context);
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

    AppBar appBar(BuildContext context) {
      return AppBar(
        shadowColor: Color(0xffE1E6F3),
        elevation: 1,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 38,
          padding: EdgeInsets.only(right: 14),
          child: TextField(
            controller: _queryTextController,
            onSubmitted: (String _) {
              print(_queryTextController.text);
              setState(() {
                isSearch = false;
              });
            },
            autofocus: true,
            style: primaryTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 12,
            ),
            decoration: InputDecoration(
              hintText: 'Cari Kelas',
              hintStyle: secondaryTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 12,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: greyColor,
              ),
              contentPadding: EdgeInsets.only(top: 14),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: whiteColor,
            ),
          ),
        ),
      );
    }

    Widget suggestions() {
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

    Widget result() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: FutureBuilder<dynamic>(
          future: courseStarterProvider.getAllCourseStarter(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.sublist(0, 7);
              print(data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Result (${data.length.toString()})',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: data
                        .map<Widget>(
                          (item) => SearchResultItem(
                            course: item,
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    }

    Widget body() {
      if (!isSearch) {
        return result();
      }
      return suggestions();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: body(),
      ),
    );
  }
}
