import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/presentation/auth/sign_in/sign_in.dart';
import 'package:quiz_app/presentation/create_question.dart';
import 'package:quiz_app/presentation/dashboard/result/results_screen.dart';

import 'categories/categories_screen.dart';

class Dashboard extends StatefulWidget {
  final User currentUser;
  const Dashboard(this.currentUser, {super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> screens = [
    const Categories(),
    const CreateQuestionPage(),
    const Results(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Quiz App')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              accountName: Text('${widget.currentUser.displayName}', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              accountEmail: Text('${widget.currentUser.email}', style: const TextStyle(fontWeight: FontWeight.bold)),
              currentAccountPicture: widget.currentUser.photoURL != null ? Image.network("${widget.currentUser.photoURL}") : const FlutterLogo(),
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Log out', style: TextStyle(fontSize: 20)),
              onTap: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
            ),
          ],
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignIn()), (route) => false);
          }
        },
        child: screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create Question'),
          BottomNavigationBarItem(icon: Icon(Icons.domain_verification), label: 'Results'),
        ],
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
      ),
    );
  }
}
