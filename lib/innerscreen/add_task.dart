import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workos/screens/auth/tasks.dart';
import 'package:workos/widgets/drawer_widget.dart';
import 'package:workos/constant/constant.dart';

class AddTaskScreen extends StatefulWidget {

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  var catcontroller = TextEditingController(text: 'Task Category.' );
  var titlecontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();
  var datecontroller = TextEditingController(text: 'pick up a date ');

  var formkey = GlobalKey<FormState>() ;


  final FirebaseAuth _auth = FirebaseAuth.instance ;
  Timestamp?  deadlineDateTimeStamp ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      drawer: DrawerWidget(),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.only(top:20 , left: 10 , right: 10),
        child: SingleChildScrollView(
          child: Card(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.center,
                      child: Text('All Fields are Required ' , style: TextStyle(color: Colors.black),)),
                ) ,
                Divider(thickness: 1,),


                Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Task Category' , style: TextStyle(color: Colors.pink[800]),),
                      ),

                    _txtformField(valuekey: 'Task Category',
                        namecontroller: catcontroller ,
                        enb: false , fct:(){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text('Task Category' , style: TextStyle(
                                  color: Colors.pink[800 ] ,fontSize: 20),),
                              content: ListView.builder(
                                  shrinkWrap: true ,
                                  itemCount : constant.taskCategoryList.length  ,
                                  itemBuilder: (context , index){
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle_outline ,color: Colors.red[300],),
                                          InkWell(
                                            onTap: (){
                                              print(constant.taskCategoryList[index]);
                                              setState(() {
                                                catcontroller.text = constant.taskCategoryList[index] ;
                                                Navigator.pop(context) ;
                                              });
                                            },
                                              child: Text('${constant.taskCategoryList[index]}' , style: TextStyle(fontSize: 18 ,),))
                                        ],
                                      ),
                                    );
                                  }),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.canPop(context) ?
                                  Navigator.pop(context)  :null ;
                                }, child: Text('Close')) ,

                              ], );
                          });
                        },
                        maxlength: 100) ,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Task Title' , style: TextStyle(color: Colors.pink[800]),),
                      ),
                      _txtformField(valuekey: 'Task Title',
                          namecontroller: titlecontroller ,
                          enb: true , fct:(){},
                          maxlength: 100) ,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Task Description' , style: TextStyle(color: Colors.pink[800]),),
                      ),

                      _txtformField(valuekey: 'Task Description',
                          namecontroller: descriptioncontroller ,
                          enb: true , fct:(){},
                          maxlength: 1000 ) ,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Task Deadline' , style: TextStyle(color: Colors.pink[800]),),
                      ),
                      _txtformField(valuekey: 'Task Deadline',
                          namecontroller: datecontroller ,
                          enb: false , fct:(){

                        showDatePicker(context:
                        context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(Duration( days:10)),
                            lastDate: DateTime(2100)
                        ).then((value) {
                          print(value);
                          datecontroller.text ='${value!.year}-${value!.month}-${value!.day}' ;
                        });
                          },
                          maxlength: 100) ,

                      MaterialButton

                        (onPressed: () async{
                          var datte = deadlineDateTimeStamp!.toDate() ;

                        User? user= _auth.currentUser;
                        String uid= user!.uid ;

                        if(formkey.currentState!.validate())
                        {
                          print('nice');
                          await FirebaseFirestore.instance.collection('tasks').doc('_uid').set(
                              {
                                 'taskId' :'1' ,
                                'uploadBy' : uid ,
                                'taskTitle' : titlecontroller.text ,
                                'taskDesc' : descriptioncontroller.text ,
                                'deadlineDate' : datecontroller.text ,
                                'deadlineDateTimeStamp' : datte ,
                               'taskcategory' : catcontroller.text  ,
                                'comment' : [] ,
                                'isDone' : false ,
                                'createdAt' : Timestamp.now()



                              }

                          );
                        }
                        //   else print('enter all fields');
                      } ,
                        color: Colors.pink.shade700 ,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Upload' , style: TextStyle(color: Colors.white),),
                              Icon(
                                Icons.upload_file , color: Colors.white,
                              )
                            ],),
                        ),),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   _txtformField({
     @required String? valuekey ,
     @required TextEditingController? namecontroller  ,
     @required bool? enb,
   @required Function? fct ,
   @required int? maxlength }){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: (){
             fct!();
        },
        child: TextFormField(
          controller: namecontroller,
          validator: (value){
            if(value!.isEmpty)
            {
              return 'please enter all fields '  ;
            }
            return null ;
          },
          enabled: enb ,
          key: ValueKey('${valuekey}'),
          maxLines: valuekey == 'Task Description'? 3: 1,
          maxLength: maxlength ,

          keyboardType: TextInputType.text ,
          decoration: InputDecoration(
            filled: true ,
            fillColor: Colors.grey[300],
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red) ,
            ),
          ),
        ),
      ),
    ) ;
  }

}
