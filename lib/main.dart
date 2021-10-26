

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workos/screens/auth/login.dart';
import 'package:workos/screens/auth/signup.dart';
import 'package:workos/screens/auth/tasks.dart';
import 'package:workos/user_state.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized() ;

  return runApp(MyApp()) ;
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _application = Firebase.initializeApp() ;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _application  ,
      builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting )
          {
            return MaterialApp(
              theme: ThemeData(
                // scaffoldBackgroundColor: Color(0xFFDE7DC)
              ),
              home:Scaffold(
                body: Center(child: Text('App is Loading...')),
              ),

              debugShowCheckedModeBanner: false,
            );
          }
        else if(snapshot.hasError)
          {
            return MaterialApp(
              theme: ThemeData(
                // scaffoldBackgroundColor: Color(0xFFDE7DC)
              ),
              home:Scaffold(
                body: Center(child: Text('Error !!')),
              ),

              debugShowCheckedModeBanner: false,
            );
          }

        else {
          return MaterialApp(
            theme: ThemeData(
              // scaffoldBackgroundColor: Color(0xFFDE7DC)
            ),
            home:
            //TasksScreen() ,

           UserState(),
           // LoginScreen(),
            // SignUpScreen(),
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}
