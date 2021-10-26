import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workos/innerscreen/task_details.dart';

class TaskWidget extends StatefulWidget {

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 8),
      child: ListTile(
        onTap: (){
          print('hiii');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetail()),
          );
        },
        onLongPress:(){
          showDialog(context: (context), builder: (context){
            return AlertDialog(
              actions: [
                TextButton(onPressed: (){}, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center ,

                  children: [
                  Icon(Icons.delete , color: Colors.red,),
                  Text('Delete' , style: TextStyle(color: Colors.red),)
                ],))
              ],
            );
          });
        } ,
        contentPadding: EdgeInsets.symmetric(horizontal: 12 , vertical: 8),
        leading: Container(
           padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(border: Border(right: BorderSide(width: 1))),
          child: CircleAvatar(radius: 20,
          backgroundColor: Colors.transparent,
          child: Image.network('https://image.flaticon.com/icons/png/128/390/390973.png'),),
        ),
        title: Text('Title' , maxLines: 2 , overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold ),),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Icon(Icons.linear_scale ,  color: Colors.pink.shade800 ,),
            Text('Subtitle / Description' ,
              maxLines: 2,
              overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16),),

        ],),
        trailing: Icon(Icons.arrow_forward_ios_outlined , color: Colors.pink.shade800, size: 30,),
      ),
    );
  }
}
