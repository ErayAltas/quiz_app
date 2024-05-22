import 'package:flutter/material.dart';
import 'package:quiz_app/utility/category_detail_list.dart';

class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage({super.key});

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  final questionController = TextEditingController();
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  final option4Controller = TextEditingController();
  final correctAnswerController = TextEditingController();
  String selectedCategory = categoryDetailList[0].category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text("Choose category", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    hint: const Text('Select Category'),
                    padding: const EdgeInsets.all(5),
                    value: selectedCategory,
                    underline: const SizedBox(),
                    items: categoryDetailList.map((category) {
                      return DropdownMenuItem(
                        value: category.category,
                        child: Text(category.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Write a question", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: questionController,
                  maxLines: 2,
                  decoration: const InputDecoration(hintText: "Question", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                const Text("Options", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: option1Controller,
                  decoration: const InputDecoration(hintText: "Option 1", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: option2Controller,
                  decoration: const InputDecoration(hintText: "Option 2", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: option3Controller,
                  decoration: const InputDecoration(hintText: "Option 3", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: option4Controller,
                  decoration: const InputDecoration(hintText: "Option 4", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: correctAnswerController,
                  decoration: const InputDecoration(hintText: "Correct Answer", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add question to database
                    // clear all fields
                    setState(() {
                      selectedCategory = categoryDetailList[0].category;
                    });
                    questionController.clear();
                    option1Controller.clear();
                    option2Controller.clear();
                    option3Controller.clear();
                    option4Controller.clear();
                    correctAnswerController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
