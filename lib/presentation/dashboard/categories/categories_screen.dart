import 'package:flutter/material.dart';
import 'package:quiz_app/utility/category_detail_list.dart';

import 'category_item.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Categories', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black)),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: categoryDetailList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CategoryItem(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
