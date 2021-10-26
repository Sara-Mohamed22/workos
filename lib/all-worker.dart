import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workos/constant/constant.dart';
import 'package:workos/widgets/allworkerwidget.dart';
import 'package:workos/widgets/drawer_widget.dart';
import 'package:workos/widgets/task_widget.dart';

class AllWorkerScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(

        leading: Builder(
            builder: (BuildContext context) {
              return  IconButton(
                icon: Icon(
                  Icons.menu_outlined ,
                  color: Colors.red,

                ),
                onPressed: (){
                  Scaffold.of(context).openDrawer() ;
                },
              );
              ;
            }
        ),




        //  backgroundColor: Theme.of(context).backgroundColor ,
        title: Text('All Worker' , style: TextStyle(color: Colors.white ),),
        actions: [
          IconButton(onPressed: (){

            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text('Task Category' , style: TextStyle(
                    color: Colors.pink[800 ] ,fontSize: 20),),
                content: ListView.builder(
                    shrinkWrap: true ,
                    itemCount :constant.taskCategoryList.length  ,
                    itemBuilder: (context , index){
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline ,color: Colors.red[300],),
                            Text('${constant.taskCategoryList[index]}' , style: TextStyle(fontSize: 18 ,),)
                          ],
                        ),
                      );
                    }),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.canPop(context) ?
                    Navigator.pop(context)  :null ;
                  }, child: Text('Close')) ,
                  TextButton(onPressed: (){

                  }, child: Text('filter Cancle')) ,
                ], );
            });
          }, icon: Icon(Icons.filter_list_outlined )) ,
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder:(context , snapshot)
      {

         if(snapshot.connectionState ==ConnectionState.waiting)
           {
             return Center(
                 child: CircularProgressIndicator()) ;
           }
         else if (snapshot.connectionState == ConnectionState.active )
         {
             if(snapshot.data!.docs.isNotEmpty)
               {
                 return  ListView.builder(
                     itemCount: snapshot.data!.docs.length,
                     itemBuilder: (context , index){
                   return WorkWidget(
                     userId: snapshot.data!.docs[index]['Id'] ,
                     username: snapshot.data!.docs[index]['name'] ,
                     useremail: snapshot.data!.docs[index]['email'] ,
                     userposition: snapshot.data!.docs[index]['position'] ,
                     userphoneNum:  snapshot.data!.docs[index]['phoneNum'],
                     userImage: snapshot.data!.docs[index]['userImgUrl'] ,

                   );
                 });
               }else{Center(child: Text('Task has not found !!'),);}
         }


             return  Center(child: Text('Something went wrong !!'),);


      },
      )
    );
  }
}
