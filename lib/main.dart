import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';
import 'trivia.dart'; // Import the TriviaPage or the relevant page you want to navigate to

void main() {
  runApp(MyBirthdayApp());
}

class MyBirthdayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Happy Birthday!'),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BirthdayCountdown(),
            ),
          ],
        ),
      ),
    );
  }
}

class BirthdayCountdown extends StatefulWidget {
  @override
  _BirthdayCountdownState createState() => _BirthdayCountdownState();
}

class _BirthdayCountdownState extends State<BirthdayCountdown> {
  late DateTime birthday;
  late Duration timeRemaining;
  late Timer timer;
  late ConfettiController _confettiController;
  late ConfettiController _confettiController2;
  late ConfettiController _confettiController3;
  bool showBirthdayMessage = false;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _confettiController2 =
        ConfettiController(duration: const Duration(seconds: 10));
    _confettiController3 =
        ConfettiController(duration: const Duration(seconds: 10));

    DateTime now = DateTime.now();
    birthday = DateTime(now.year, 7, 10);
    if (now.isAfter(birthday)) {
      birthday = DateTime(now.year + 1, 7, 10);
    }

    timeRemaining = birthday.difference(DateTime.now());
    timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => _updateCountdown());
  }

  void _updateCountdown() {
    setState(() {
      timeRemaining = birthday.difference(DateTime.now());
      if (timeRemaining.isNegative || timeRemaining == Duration.zero) {
        showBirthdayMessage = true;
        _confettiController.play();
        _confettiController2.play();
        _confettiController3.play();
        timer.cancel(); // Stop the timer as it's no longer needed
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _confettiController.dispose();
    _confettiController2.dispose();
    _confettiController3.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return '$days days, $hours hours, $minutes minutes, $seconds seconds';
  }

  List<String> splitMessageIntoLines(String message, int wordsPerLine) {
    List<String> words = message.split(' ');
    List<String> lines = [];
    for (int i = 0; i < words.length; i += wordsPerLine) {
      lines.add(words.skip(i).take(wordsPerLine).join(' '));
    }
    return lines;
  }

  @override
  Widget build(BuildContext context) {
    bool isBirthday = DateTime.now().month == 7 && DateTime.now().day == 10;

    return Stack(
      children: <Widget>[
        if (showBirthdayMessage || isBirthday) ..._buildBirthdayMessages(),
        if (!showBirthdayMessage && !isBirthday)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Birthday Countdown!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 121, 170,
                      210), // Change text color to white, for example
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  _formatDuration(timeRemaining),
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 121, 170,
                        210), // Change text color to white, for example
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        Positioned(
          top: 500,
          right: 20,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
          ),
        ),
        Positioned(
          top: 500,
          left: 20,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
          ),
        ),
        Positioned(
          bottom: 500,
          right: 20,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TriviaPage()),
              );
            },
            child: Text('Start Trivia'),
          ),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
          colors: [Colors.red, Colors.blue, Colors.green],
        ),
        ConfettiWidget(
          confettiController: _confettiController2,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
          colors: [Colors.purple, Colors.orange, Colors.pink],
        ),
        ConfettiWidget(
          confettiController: _confettiController3,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
          colors: [Colors.yellow, Colors.teal, Colors.lime],
        ),
      ],
    );
  }

  List<Widget> _buildBirthdayMessages() {
    return [
      Positioned(
        top: 20,
        left: 0,
        right: 0,
        child: Center(
          child: Text(
            'Happy 21st Birthday Babe ❤️',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 121, 170,
                  210), // Change text color to white, for example
              fontFamily: 'Nunito',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: splitMessageIntoLines(
            'Happy Birthday Deshaun, wish you more life and more blessings🎉-K ',
            5,
          )
              .map((line) => Text(
                    line,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 121, 170,
                          210), // Change text color to white, for example
                      fontFamily: 'Nunito',
                    ),
                  ))
              .toList(),
        ),
      ),
      Positioned(
        top: 100,
        left: 0,
        right: 0,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: splitMessageIntoLines(
              'I hope you have an amazing day! I can\'t believe that you\'re 21. I\'ve gotten to watch you grow over these past 7 months and you have definitely grown stronger, wiser and cuter 😂. You are my inspiration, you keep going even when it\'s tough and I really admire that about you. You have gotten me to want to be a better person for me, for you and for us. I can\'t wait to grow with you, live life with you and have fun with you. I love you ❤️❤️ ',
              5,
            )
                .map((line) => Text(
                      line,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 121, 170,
                            210), // Change text color to white, for example
                        fontFamily: 'Nunito',
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: splitMessageIntoLines(
                  'Happy Happy Birthday D! Wish you many more blessed years full of wisdom, health, happiness and peace of mind. May God grant you all your desires and may your wishes come true. Enjoy your wonderful day.🎉 - Maya',
                  5)
              .map((line) => Text(
                    line,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 121, 170,
                          210), // Change text color to white, for example
                      fontFamily: 'Nunito',
                    ),
                  ))
              .toList(),
        ),
      ),
      Positioned(
        bottom: 150,
        left: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: splitMessageIntoLines(
                  'Happy birthday Stink Stink. Hope you have an amazing day. Thank you for treating my sister so well. Here\'s to many more birthdays in each other\'s lives. -Your Fave, Mucha',
                  5)
              .map((line) => Text(
                    line,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 121, 170,
                          210), // Change text color to white, for example
                      fontFamily: 'Nunito',
                    ),
                  ))
              .toList(),
        ),
      ),
      Positioned(
        bottom: 200,
        right: 20,
        child: Text(
          'From all of us! 🎁',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(
                255, 121, 170, 210), // Change text color to white, for example
            fontFamily: 'Nunito',
          ),
        ),
      ),
    ];
  }
}
