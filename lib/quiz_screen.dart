import 'package:flutter/material.dart';
import 'color.dart';
import 'questions_example.dart';
import 'result.dart';
import 'answer.dart';


class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;
  List<int?> selectedAnswers = List<int?>.filled(questions.length, null); // List to store selected answers

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pripmaryColor,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: PageView.builder(
          controller: _controller!,
          onPageChanged: (page) {
            if (page == questions.length - 1) {
              setState(() {
                btnText = "See Results";
              });
            } else {
              setState(() {
                btnText = "Next Question";
              });
            }
            setState(() {
              answered = false;
            });
          },
          physics: new NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Question ${index + 1}/3",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200.0,
                  child: Text(
                    "${questions[index].question}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                for (int i = 0; i < questions[index].answers!.length; i++)
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    margin: EdgeInsets.only(
                      bottom: 20.0,
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: Answer(
                      selectHandler: () {
                        if (!answered) {
                          if (questions[index].answers!.values.toList()[i]) {
                            score++;
                            print("yes");
                          } else {
                            print("no");
                          }
                          selectedAnswers[index] = i; // Update selected answer
                          setState(() {
                            btnPressed = true;
                            answered = true;
                          });
                        }
                      },
                      answerText: questions[index].answers!.keys.toList()[i],
                      isSelected: selectedAnswers[index] == i, // Check if this answer is selected
                    ),
                  ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (index > 0)
                      RawMaterialButton(
                        
                        onPressed: () {
                          _controller!.previousPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInExpo,
                          );
                          setState(() {
                            btnPressed = false;
                            answered = false;
                          });
                          
                        },
                        shape: StadiumBorder(),
                      fillColor: Colors.blue,
                      padding: EdgeInsets.all(18.0),
                      elevation: 0.0,
                        
                        child: Text("Previous",style: TextStyle(color: Colors.white)),
                        
                      ),
                    RawMaterialButton(
                      onPressed: () {
                        if (_controller!.page?.toInt() == questions.length - 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(score),
                            ),
                          );
                        } else {
                          _controller!.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInExpo,
                          );

                          setState(() {
                            btnPressed = false;
                            answered = false;
                          });
                        }
                      },
                      shape: StadiumBorder(),
                      fillColor: Colors.blue,
                      padding: EdgeInsets.all(18.0),
                      elevation: 0.0,
                      child: Text(
                        btnText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          itemCount: questions.length,
        ),
      ),
    );
  }
}
