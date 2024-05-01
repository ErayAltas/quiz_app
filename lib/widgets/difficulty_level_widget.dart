import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/difficulty_level/difficulty_level_bloc.dart';
import 'package:quiz_app/bloc/difficulty_level/difficulty_level_event.dart';
import 'package:quiz_app/utility/category_detail_list.dart';

class DifficultyLevelWidget extends StatelessWidget {
  DifficultyLevelWidget({super.key, required this.selectedIndex, required this.difficulty});
  final int selectedIndex;
  final int difficulty;
  final List<String> level = ['Easy', 'Medium', 'Hard'];
  final List<String> levelLowercase = ['easy', 'medium', 'hard'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<DifficultyLevelBloc>(context).add(DifficultyLevelSelectedEvent(levelLowercase[difficulty], selectedIndex));
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: categoryDetailList[selectedIndex].textColor),
        ),
        child: Text(
          level[difficulty],
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
