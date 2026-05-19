import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController controller = TextEditingController();

  int totalSeconds = 1500;
  Timer? timer;
  // ? oznacza, ze zmienna moze byc nullable, czyli moze byc pusta

  bool isEditing = false;

  String formatTime() {

    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    return "$formattedMinutes:$formattedSeconds";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFACDDE),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            GestureDetector(
              onTap: () {

                setState(() {

                  isEditing = true;

                });

              },

              child: isEditing

                  ? SizedBox(

                width: 150,

                child: TextField(

                  controller: controller,

                  style: TextStyle(
                    fontSize: 50,
                    color: Color(0xFFE896C1),
                    fontFamily: 'Pixelify',
                  ),

                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),

                  onSubmitted: (value) {

                    List<String> parts = value.split(":");

                    int minutes = int.parse(parts[0]);
                    int seconds = int.parse(parts[1]);

                    setState(() {

                      totalSeconds = (minutes * 60) + seconds;

                      isEditing = false;

                    });

                  },

                ),

              )

                  : Text(
                formatTime(),
                style: TextStyle(
                  fontSize: 50,
                  color: Color(0xFFE896C1),
                  fontFamily: 'Pixelify',
                ),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                // sprawia, ze timer odpali sie tylko raz
                if (timer == null) {
                    timer = Timer.periodic(
                      Duration(seconds: 1),

                          (timer) {

                        setState(() {

                          if (totalSeconds >0) {
                            totalSeconds--;
                          } else {
                            timer?.cancel();
                          }
                        });
                      },
                    );
                }



              },

              child: Text("START"),
            ),

            // przycisk stop
            ElevatedButton(
              onPressed: () {
                timer?.cancel();
                timer = null;
              },
              child: Text("STOP"),
            ),

          ],
        ),
      ),
    );
  }
}