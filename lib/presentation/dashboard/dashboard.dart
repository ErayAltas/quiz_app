import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/presentation/auth/sign_in/sign_in.dart';
import 'package:quiz_app/presentation/dashboard/result/results_screen.dart';

import 'categories/categories_screen.dart';

class Dashboard extends StatelessWidget {
  final User currentUser;
  const Dashboard(this.currentUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Quiz App', style: TextStyle(fontSize: 24)),
          backgroundColor: Colors.green,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.domain_verification)),
            ],
          ),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              accountName: Text('${currentUser.displayName}', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              accountEmail: Text('${currentUser.email}', style: const TextStyle(fontWeight: FontWeight.bold)),
              currentAccountPicture: currentUser.photoURL != null ? Image.network("${currentUser.photoURL}") : const FlutterLogo(),
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Log out', style: TextStyle(fontSize: 20)),
              onTap: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
            ),
          ],
        )),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignIn()), (route) => false);
            }
          },
          child: TabBarView(
            children: [
              const Categories(),
              Results(),
            ],
          ),
        ),
      ),
    );
  }
}
