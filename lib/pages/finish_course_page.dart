import 'package:exercise/pages/home_page.dart';
import 'package:exercise/providers/object_detail.dart';
import 'package:exercise/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishCoursePage extends StatelessWidget {
  const FinishCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image_finish.png',
                ),
                SizedBox(
                  height: 58,
                ),
                Text(
                  'What a Day!',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'kamu telah menyelesaikan kelas ${objectDetailProvider.objectDetail.namaKelas} dengan sangat baik',
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width:
                      MediaQuery.of(context).size.width - (defaultMargin * 2),
                  height: 45,
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: Text(
                      'My Dashboard',
                      style: whiteTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
