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
              ListView.builder(
                itemCount: categoryDetailList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
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
