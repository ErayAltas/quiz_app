import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/quiz/quiz_bloc.dart';
import 'package:quiz_app/bloc/quiz/quiz_event.dart';
import 'package:quiz_app/bloc/quiz/quiz_state.dart';
import 'package:quiz_app/presentation/main/result_detail_screen.dart';
import 'package:quiz_app/utility/category_detail_list.dart';
import 'package:quiz_app/utility/prepare_quiz.dart';
import 'package:quiz_app/widgets/option_widget.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.questionData, required this.categoryIndex, required this.difficultyLevel});

  final dynamic questionData;
  final int categoryIndex;
  final String difficultyLevel;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  PrepareQuiz quizMaker = PrepareQuiz();
  int questionNumber = 0;
  bool isAbsorbing = false;
  final int duration = 10;
  List<Color> optionColor = [Colors.white, Colors.white, Colors.white, Colors.white];
  int selectedOption = 0;

  @override
  void initState() {
    super.initState();
    quizMaker.populateList(widget.questionData);
  }

  List<Widget> buildOptions(List<String> options) {
    List<Widget> optionsWidget = [];
    for (int j = 0; j < 4; j++) {
      optionsWidget.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: OptionWidget(
          widget: widget,
          option: options[j],
          optionColor: optionColor[j],
          onTap: () async {
            setState(() {
              if (selectedOption != -1) {
                optionColor[selectedOption] = Colors.white;
              }
              selectedOption = j;
              optionColor[selectedOption] = Colors.greenAccent;
            });
            // await Future.delayed(const Duration(seconds: 1, milliseconds: 30), () {});
          },
        ),
      ));
    }
    return optionsWidget;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => QuizBloc(quizMaker),
        child: BlocListener<QuizBloc, QuizState>(
          listener: (context, state) {
            if (state is QuizFinishedState) {
              _navigateToResultScreen(context, state);
            }
          },
          child: BlocBuilder<QuizBloc, QuizState>(
            buildWhen: (previous, current) => true,
            builder: (BuildContext context, state) {
              if (state is QuizOnGoingState) {
                return AbsorbPointer(
                  absorbing: isAbsorbing,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
                    decoration: BoxDecoration(
                      color: categoryDetailList[widget.categoryIndex].textColor,
                    ),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(state.currentIndex + 1).toString()} of 10',
                                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 20),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                state.currentQuestion,
                                style: const TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ...buildOptions(state.options),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              if (state.currentIndex < 9) {
                                if (selectedOption != -1) optionColor[selectedOption] = Colors.white;
                                int selectedIndex = selectedOption;
                                selectedOption = -1;
                                BlocProvider.of<QuizBloc>(context).add(NextQuestion(selectedIndex));
                              } else {
                                BlocProvider.of<QuizBloc>(context).add(QuizFinished(selectedOption));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              minimumSize: const Size.fromHeight(45),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Next', style: TextStyle(color: Colors.white, fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Text('Loading...');
            },
          ),
        ));
  }

  void _navigateToResultScreen(context, QuizState state) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultDetailScreen(
          score: state.currentScore,
          categoryIndex: widget.categoryIndex,
          attempts: state.currentAttempts,
          wrongAttempts: state.currentWrongAttempts,
          correctAttempts: state.currentCorrectAttempts,
          difficultyLevel: widget.difficultyLevel,
          isSaved: false,
        ),
      ),
    );
  }
}
