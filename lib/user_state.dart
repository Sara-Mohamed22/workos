import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workos/screens/auth/login.dart';
import 'package:workos/screens/auth/tasks.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges() ,
        builder: (context , snapshot ) {
          if(snapshot.data ==null) {
           print('data not found');
            return LoginScreen();
          } else if (snapshot.hasData) {
            print('data found');
            return TasksScreen();
          }
          else if(snapshot.hasError){
            return Scaffold (
              body: Center(child: Text('Error !!')),

            );}
          else return null! ;
        }) ;
  }
}
