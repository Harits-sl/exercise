import 'package:html/parser.dart';

class StringHelper {
  static htmlToString(String input) {
    // var document = parse(input);

    // print('html to string: ${document.text}');

    // //declaring a list of String to hold all the data.
    // List<String> data = [];

    // data.add(document.getElementsByClassName("p")[0].innerHtml);

    // //declaring variable for temp since we will be using it multiple places
    // var temp = document.getElementsByClassName("p")[0];
    // data.add(temp.innerHtml.substring(0, temp.innerHtml.indexOf("<span>")));
    // data.add(temp
    //     .getElementsByTagName("p")[0]
    //     .innerHtml
    //     .replaceAll(RegExp("[(|)|℃]"), ""));

    // //We can also do document.getElementsByTagName("td") but I am just being more specific here.
    // var rows = document.getElementsByTagName("p")[0].getElementsByTagName("td");

    // //Map elememt to its innerHtml,  because we gonna need it.
    // //Iterate over all the table-data and store it in the data list
    // rows.map((e) => e.innerHtml).forEach((element) {
    //   if (element != "-") {
    //     data.add(element);
    //   }
    // });

    // print(data);
    // return data;
  }
}
