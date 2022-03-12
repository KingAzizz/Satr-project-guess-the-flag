import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guess_the_flag/ResultScreen.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen();

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<String> countries = [
    "Estonia",
    "France",
    "Germany",
    "Ireland",
    "Italy",
    "Monaco",
    "Nigeria",
    "Poland",
    "Russia",
    "Spain",
    "UK",
    "US",
  ];
  int correct = 0;
  int wrong = 0;
  @override
  void initState() {
    super.initState();
    countries.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    int rnd = Random().nextInt(3);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 16),
              Text(
                "Guess The Flag?",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              Text(
                countries[rnd],
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30),
              for (int i = 0; i < 3; i++)
                FlagButton(
                  name: countries[i],
                  onPressed: () {
                    if (rnd == i) {
                      Fluttertoast.showToast(
                          msg: "Correct", backgroundColor: Colors.green);
                      correct++;
                      print("Correct Answers: $correct");
                    } else {
                      Fluttertoast.showToast(
                          msg: "Wrong", backgroundColor: Colors.red);
                      wrong++;
                      print("Wrong Answers: $wrong");
                    }
                    setState(() {
                      countries.shuffle();
                      rnd = new Random().nextInt(3);
                    });
                  },
                ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                  correct: correct,
                                  wrong: wrong,
                                )));
                  },
                  child: Text("Result"))
            ],
          ),
        ),
      ),
    );
  }
}

class FlagButton extends StatelessWidget {
  const FlagButton({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Image.asset(
        "assets/countries/${name}.png",
        height: 150,
      ),
    );
  }
}
