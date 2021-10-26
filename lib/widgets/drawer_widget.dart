import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workos/innerscreen/add_task.dart';
import 'package:workos/profile.dart';
import 'package:workos/screens/auth/login.dart';
import 'package:workos/user_state.dart';

import '../all-worker.dart';

class DrawerWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance ;

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _auth =FirebaseAuth.instance ;
    return Drawer(
      child:ListView(
        children: [
          DrawerHeader(decoration: BoxDecoration(color: Colors.cyan),
          child: Column(
            children: [
              Flexible(child: Image.network('https://image.flaticon.com/icons/png/128/1055/1055672.png')),
              SizedBox(height: 5,),

              Flexible(
                child: Text('Work Os' , style: TextStyle(fontWeight: FontWeight.bold ,
                    fontSize: 25 ,
                    color: Colors.white),),
              )
            ],
          ),),
          _listview(Icons.task, 'All Tasks', (){}),
          _listview(Icons.settings, 'My Account', (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen(userId: _auth.currentUser!.uid ,)),
            );

          }),
          _listview(Icons.workspaces_outline, 'Register works', (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllWorkerScreen()),
            );
          }),
          _listview(Icons.add_task_outlined , 'Add Task', (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()),
            );
          }),
          Divider(thickness: 1,),
          _listview(Icons.logout_outlined, 'Logout', (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.logout_outlined) ,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('SignOut'),
                    )
                  ],
                ),
                content: Text('Are you Logout ?'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.canPop(context) ?
                    Navigator.pop(context)  :null ;
                  }, child: Text('Cancle')) ,
                  TextButton(onPressed: () async {
                       await _auth.signOut() ;
                        Navigator.canPop(context) ? Navigator.pop(context)  :null ;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserState()));
                        print('logout');

                  }, child: Text('ok')) ,
                ],
              ) ;
            });
          }),



        ],
      ),
    );
  }

  Widget _listview( @required IconData icon , @required String txt , @required Function fct)
  {
    return ListTile(
      onTap: (){
        fct() ;
      } ,
      leading: Icon(icon, color: Colors.blue, ),
      title: Text('${txt}' , style: TextStyle( fontStyle: FontStyle.italic ,
          fontWeight: FontWeight.bold ,
          fontSize: 23,
      color: Colors.blue ),),
    );
  }
}
