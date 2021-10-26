import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workos/constant/constant.dart';
import 'package:workos/widgets/drawer_widget.dart';
import 'package:workos/widgets/task_widget.dart';

class TasksScreen extends StatelessWidget {



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
        title: Text('Tasks' , style: TextStyle(color: Colors.white ),),
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
       body: ListView.builder(itemBuilder: (context , index){
         return TaskWidget();
       }),
    );
  }
}
