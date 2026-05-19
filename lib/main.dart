import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
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
  int initialSeconds = 1500;

  Timer? timer;

  // true = pokazuje TextField
  // false = pokazuje zwykly Text
  bool isEditing = false;

  String formatTime() {

    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String formattedMinutes =
    minutes.toString().padLeft(2, '0');

    String formattedSeconds =
    seconds.toString().padLeft(2, '0');

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

                controller.text = formatTime();

                setState(() {

                  isEditing = true;

                });

              },

              child: isEditing

                  ? SizedBox(

                width: 220,

                child: TextField(

                  controller: controller,

                  textAlign: TextAlign.center,

                  keyboardType: TextInputType.datetime,

                  style: TextStyle(
                    fontSize: 50,
                    color: Color(0xFFE896C1),
                    fontFamily: 'Pixelify',
                  ),

                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),

                  onSubmitted: (value) {

                    List<String> parts =
                    value.split(":");

                    int minutes =
                    int.parse(parts[0]);

                    int seconds =
                    int.parse(parts[1]);

                    setState(() {

                      totalSeconds =
                          (minutes * 60) + seconds;

                      initialSeconds =
                          totalSeconds;

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

                // timer odpala sie tylko raz
                if (timer == null) {
                  timer = Timer.periodic(
                    Duration(seconds: 1),

                        (currentTimer) {

                      setState(() {

                        if (totalSeconds > 0) {

                          totalSeconds--;

                        } else {

                          currentTimer.cancel();

                          timer = null;

                        }

                      });

                    },
                  );
                }

              },

              child: Text("START"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {

                timer?.cancel();

                timer = null;

              },

              child: Text("STOP"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {

                timer?.cancel();

                timer = null;

                setState(() {

                  totalSeconds = initialSeconds;

                });

              },

              child: Text("RESET"),
            ),

          ],
        ),
      ),
    );
  }
}