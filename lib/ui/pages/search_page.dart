import 'package:exercise/cubit/search/search_cubit.dart';
import 'package:exercise/cubit/searchCourse/search_course_cubit.dart';
import 'package:exercise/cubit/starterCourse/starter_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/search_result_item.dart';
import '../../shared/theme.dart';

class SearchPage extends StatefulWidget {
  final bool isNewFreeCourse;

  const SearchPage({
    Key? key,
    this.isNewFreeCourse = false,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _queryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List mostSearch = [
      'Flutter',
      'Laravel',
      'Adobe Premiere',
      'React',
      'React Native',
      'JavaScript',
      'Figma',
      'Adobe XD',
      'UI Design',
      'UX Design',
    ];

    Widget suggestionItem(text) {
      return GestureDetector(
        onTap: () {
          _queryTextController.text = text;
          context.read<SearchCourseCubit>().getSearchCourse(text);
        },
        child: Container(
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
        ),
      );
    }

    AppBar appBar() {
      return AppBar(
        shadowColor: Color(0xffE1E6F3),
        elevation: 1,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);

            // reset cubit to initialState
            context.read<SearchCourseCubit>().resetSearchCourse();
          },
        ),
        title: Container(
          height: 38,
          padding: EdgeInsets.only(right: 14),
          child: TextField(
            controller: _queryTextController,
            onSubmitted: (String _) {
              context.read<SearchCubit>().setSearch(0);
              context
                  .read<SearchCourseCubit>()
                  .getSearchCourse(_queryTextController.text);
            },
            // autofocus: searchProvider.isSearch,
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
              height: defaultMargin,
            ),
            const Text(
              'Paling Dicari:',
            ),
            Wrap(
              children: <Widget>[
                for (String item in mostSearch) suggestionItem(item)
              ],
            ),
          ],
        ),
      );
    }

    Widget result(data) {
      Widget titleText() {
        return BlocBuilder<SearchCubit, int>(
          builder: (context, currentIndex) {
            switch (currentIndex) {
              case 0:
                return Text(
                  'Result (${data.length.toString()})',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                );
              case 1:
                return Text(
                  'New Free Course (${data.length.toString()})',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                );
              case 2:
                return Text(
                  'Top Featured (${data.length.toString()})',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                );
              default:
                return Text('');
            }
          },
        );
      }

      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(),
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
        ),
      );
    }

    Widget body() {
      Widget searchBuilder(state) {
        if (state is SearchCourseInitial) {
          return suggestions();
        } else if (state is SearchCourseLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchCourseSuccess) {
          return result(state.course);
        }

        return SizedBox();
      }

      Widget builder(state) {
        if (state is StarterCourseInitial) {
          return suggestions();
        } else if (state is StarterCourseLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is StarterCourseSuccess) {
          return result(state.course);
        }

        return SizedBox();
      }

      return BlocBuilder<SearchCubit, int>(
        builder: (context, currentIndex) {
          switch (currentIndex) {
            case 0:
              return BlocBuilder<SearchCourseCubit, SearchCourseState>(
                  builder: (context, state) {
                return searchBuilder(state);
              });
            case 1:
              return BlocBuilder<FreeStarterCourseCubit, StarterCourseState>(
                  builder: (context, state) {
                return builder(state);
              });
            case 2:
              return BlocBuilder<TopStarterCourseCubit, StarterCourseState>(
                  builder: (context, state) {
                return builder(state);
              });

            default:
              return BlocBuilder<SearchCourseCubit, SearchCourseState>(
                  builder: (context, state) {
                return searchBuilder(state);
              });
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: body(),
      ),
    );
  }
}
