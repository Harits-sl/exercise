import 'package:exercise/pages/home_page.dart';
import 'package:exercise/theme.dart';
import 'package:flutter/material.dart';

class FinishCoursePage extends StatelessWidget {
  const FinishCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 30,
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'Kelas Selesai',
                style: titleTextStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Semoga bermanfaat dan ikuti kelas online kami lainnya',
                textAlign: TextAlign.center,
                style: subTitleTextStyle,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text(
                  'Back to Home',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
