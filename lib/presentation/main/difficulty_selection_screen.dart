import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/difficulty_level/difficulty_level_bloc.dart';
import 'package:quiz_app/bloc/difficulty_level/difficulty_level_event.dart';
import 'package:quiz_app/bloc/difficulty_level/difficulty_level_state.dart';
import 'package:quiz_app/presentation/main/prepare_quiz_screen.dart';
import 'package:quiz_app/widgets/close_button.dart';
import 'package:quiz_app/widgets/difficulty_level_widget.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key, required this.categoryIndex});
  final int categoryIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DifficultyLevelBloc()..add(InitEvent(categoryIndex)),
      child: BlocListener<DifficultyLevelBloc, DifficultyLevelState>(
        listener: (context, state) {
          if (state is StartQuizState) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => PrepareQuizScreen(index: state.selectedIndex, selectedDif: state.selectedDiff)));
          }
        },
        child: BlocBuilder<DifficultyLevelBloc, DifficultyLevelState>(builder: (context, state) {
          if (state is LoadedState) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(alignment: Alignment.centerLeft, child: RoundCloseButton()),
                    const SizedBox(height: 40),
                    Text(
                      state.title,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
                    ),
                    const SizedBox(height: 80),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Select Difficulty', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        DifficultyLevelWidget(selectedIndex: categoryIndex, difficulty: 0),
                        const SizedBox(height: 20),
                        DifficultyLevelWidget(selectedIndex: categoryIndex, difficulty: 1),
                        const SizedBox(height: 20),
                        DifficultyLevelWidget(selectedIndex: categoryIndex, difficulty: 2),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
