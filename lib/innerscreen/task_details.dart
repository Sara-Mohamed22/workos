import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workos/widgets/commits_widget.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {

   bool _iscommenting = false ;
   var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
          backgroundColor: Colors.pink[900],
        elevation: 0,
        title: TextButton(onPressed: (){
          Navigator.pop(context);
        },child: Text('Back' ,
          style: TextStyle(color: Colors.white ,fontSize: 22),),) ,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Center(child: Text('Task Title' , style: TextStyle(fontWeight:  FontWeight.bold , fontSize: 28 ) ,)),

            SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.all(10 ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween ,

                        children: [
                          Text('Upload by '),
                         // Spacer(),

                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50 ,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 3 , color: Colors.pink.shade800 ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: NetworkImage('https://e7.pngegg.com/pngimages/348/800/png-clipart-man-wearing-blue-shirt-illustration-computer-icons-avatar-user-login-avatar-blue-child.png'),
                                      fit:BoxFit.fill  ),
                                ),


                              ),
                              SizedBox(height: 5,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,

                                children: [
                                  Text('Uploader name' , ),
                                  Text('Uploader name' , ),
                                ],
                              )
                            ],
                          ),


                        ],
                      ),
                      Divider(thickness: 1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Upload by '),
                          Text('data:6-9-2021')
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('deadline '),
                          Text('data:6-9-2021')
                        ],
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text('1-12-2021 ' , style: TextStyle(color: Colors.green),),
                      ),
                      Divider(thickness: 1,),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Done State:'),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                        Text('done'),

                          Opacity(
                            opacity: .4,
                              child: Icon(Icons.check_box , color: Colors.green ,)),

                        SizedBox(width: 20,),

                        Text('not done'),

                          Opacity(
                            opacity: .4,
                              child: Icon(Icons.check_box , color: Colors.red ,))
                      ],),
                      Divider(thickness: 1,),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Task Description:'),
                          Text('description by '),
                        ],
                      ),

                      AnimatedSwitcher(duration: Duration(milliseconds: 500),
                      child: _iscommenting? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex:3,
                            child: TextField(
                              maxLength: 200 ,
                              //controller: ,
                              style: TextStyle(color: Colors.blueAccent ),
                              keyboardType: TextInputType.text ,
                              maxLines: 6 ,
                              decoration: InputDecoration(
                                filled: true ,
                                fillColor: Colors.red[200],
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white ),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.purple
                                  )
                                )
                              ),
                            ),

                          ),
                          SizedBox(width: 10,),
                          Flexible(
                            flex: 2 ,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                MaterialButton
                                  (onPressed: (){
                                  if(formkey.currentState!.validate())
                                  {
                                    print('nice');
                                  }
                                  //   else print('enter all fields');
                                } ,
                                  color: Colors.pink.shade700 ,
                                  elevation: 10,
                                  child: Padding(

                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('post' , style: TextStyle(color: Colors.white),),

                                  ),),

                                TextButton(child: Text('Cancel'),
                                onPressed: (){
                                  setState(() {

                                    _iscommenting = !_iscommenting ;
                                  });
                                },),


                              ],
                              /*  Flexible(

                       child: Column(
                            children: [
                             MaterialButton
                                (onPressed: (){
                                if(formkey.currentState!.validate())
                                {
                                  print('nice');
                                }
                                //   else print('enter all fields');
                              } ,
                                color: Colors.pink.shade700 ,
                                elevation: 10,
                                child: Padding(

                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('post' , style: TextStyle(color: Colors.white),),

                                ),),

                              Text('Cancel'),
                            ],
                        ),
                     ),*/



                            ),
                          ),
                        ],
                      ) : MaterialButton
                        (onPressed: (){

                           setState(() {
                            _iscommenting = !_iscommenting ;
                            print(_iscommenting);
                            print('11');

                            });


                        //   else print('enter all fields');
                      } ,
                        color: Colors.pink.shade700 ,
                        elevation: 10,
                        child: Padding(

                          padding: const EdgeInsets.all(8.0),
                          child: Text('Add Comment ' , style: TextStyle(color: Colors.white),),

                        ),),

                      ),

                      ListView.separated(

                        shrinkWrap: true ,   // to resize
                          physics: NeverScrollableScrollPhysics() ,  // to scroll

                          itemBuilder: (context , index) {
                            return CommentWidget() ;
                          },
                          separatorBuilder: (context , index){
                            return (Divider(thickness: 1,)) ;
                          },
                          itemCount: 2 )

                  ]),
                ),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
