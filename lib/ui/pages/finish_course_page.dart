import 'package:exercise/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exercise/providers/object_detail.dart';

import './home_page.dart';
import '../../../shared/theme.dart';

class FinishCoursePage extends StatelessWidget {
  const FinishCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var objectDetailProvider = Provider.of<ObjectDetailProvider>(context);

    void method() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }

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
                CustomButton(
                  title: 'My Dashboard',
                  method: method,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
