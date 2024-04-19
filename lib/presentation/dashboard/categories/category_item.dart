import 'package:flutter/material.dart';
import 'package:quiz_app/presentation/main/difficulty_selection_screen.dart';
import 'package:quiz_app/utility/category_detail_list.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(this.index, {super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DifficultyScreen(categoryIndex: index)));
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: categoryDetailList[index].accentColor, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              categoryDetailList[index].title,
              style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
