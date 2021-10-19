// import 'package:exercise/providers/course_starter_provider.dart';
// import 'package:exercise/providers/search_provider.dart';
// import 'package:exercise/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SeeAllCoursePage extends StatefulWidget {
//   const SeeAllCoursePage({ Key? key }) : super(key: key);

//   @override
//   _SeeAllCoursePageState createState() => _SeeAllCoursePageState();
// }

// class _SeeAllCoursePageState extends State<SeeAllCoursePage> {
//   final TextEditingController _queryTextController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     List mostWanted = [
//       'Flutter',
//       'Laravel',
//       'Adobe Premiere',
//       'React',
//       'React Native',
//       'JavaScript',
//       'Figma',
//       'Adobe XD',
//       'UI Design',
//       'UX Design',
//     ];
    
//     var courseStarterProvider = Provider.of<CourseStarterProvider>(context);

//     Widget suggestionItem(text) {
//       return GestureDetector(
//         onTap: () {
//           searchProvider.isSearch = false;
//           searchProvider.query = text;
//           _queryTextController.text = text;
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: secondaryButtonColor,
//             borderRadius: BorderRadius.circular(100),
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: 4,
//             horizontal: 12,
//           ),
//           margin: EdgeInsets.only(
//             right: 12,
//             top: 12,
//           ),
//           child: Text(
//             text,
//             style: primaryTextStyle.copyWith(
//               fontWeight: medium,
//               fontSize: 12,
//             ),
//           ),
//         ),
//       );
//     }

//     AppBar appBar(BuildContext context) {
//       return AppBar(
//         shadowColor: Color(0xffE1E6F3),
//         elevation: 1,
//         backgroundColor: backgroundColor,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             searchProvider.isSearch = true;
//             Navigator.pop(context);
//           },
//         ),
//         title: Container(
//           height: 38,
//           padding: EdgeInsets.only(right: 14),
//           child: TextField(
//             controller: _queryTextController,
//             onSubmitted: (String _) {
//               searchProvider.query = _queryTextController.text;
//               searchProvider.isSearch = false;
//             },
//             autofocus: true,
//             style: primaryTextStyle.copyWith(
//               fontWeight: medium,
//               fontSize: 12,
//             ),
//             decoration: InputDecoration(
//               hintText: 'Cari Kelas',
//               hintStyle: secondaryTextStyle.copyWith(
//                 fontWeight: regular,
//                 fontSize: 12,
//               ),
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: greyColor,
//               ),
//               contentPadding: EdgeInsets.only(top: 14),
//               isDense: true,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               filled: true,
//               fillColor: whiteColor,
//             ),
//           ),
//         ),
//       );
//     }

//     Widget suggestions() {
//       return Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: defaultMargin,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: defaultMargin,
//             ),
//             const Text(
//               'Paling Dicari:',
//             ),
//             Wrap(
//               children: <Widget>[
//                 for (String item in mostWanted) suggestionItem(item)
//               ],
//             ),
//           ],
//         ),
//       );
//     }

//     Widget result() {
//       return Container(
//         margin: EdgeInsets.only(
//           top: defaultMargin,
//           left: defaultMargin,
//           right: defaultMargin,
//         ),
//         child: FutureBuilder<dynamic>(
//           future: widget.isSearch
//               ? searchProvider.searchCourse()
//               : courseStarterProvider.getAllFreeCourse(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               var data = snapshot.data;
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Result (${data.length.toString()})',
//                     style: primaryTextStyle.copyWith(
//                       fontWeight: semiBold,
//                       fontSize: 14,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   Column(
//                     children: data
//                         .map<Widget>(
//                           (item) => SearchResultItem(
//                             course: item,
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ],
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       );
//     }

//     Widget body() {
//       if (!widget.isSearch ||
//           !searchProvider.isSearch ||
//           _queryTextController.text != '') {
//         return result();
//       }
//       return suggestions();
//     }

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: appBar(context),
//       body: SingleChildScrollView(
//         child: body(),
//       ),
//     );
//   }
// }