import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workos/user_state.dart';
import 'package:workos/widgets/drawer_widget.dart';
import 'package:workos/constant/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {

  final String userId ;
  const ProfileScreen( {required this.userId} ) ;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance ;

  bool _isloading = false ;
  String phoneNumber ='' ,
      email=''
     ,name  =''  ,
      job =''   ,

      joinedAt ="" ;
  String? imgUrl  ;

  bool _issameUser = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData();
  }

  void userData() async
  {
    _isloading = true ;

    try
    {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.
      collection("users").
      doc(widget.userId).get().
      // then((value) {
      //
      //   print('user: ${value }');
      // }).
      catchError((e){print('error before:${e}');}) ;


      if( userDoc == null )
      {
        print('userDoc : ${userDoc.get('name')}');
        print('userDoc');
        print( userDoc);
        print('nullllll***');
        return ;

      }
      else
      {
        setState(() {
          email=userDoc.get('email') ;
          name= userDoc.get('name') ;
          phoneNumber= userDoc.get('phoneNum');
          imgUrl= userDoc.get('userImgUrl');
          job= userDoc.get('position') ;
          Timestamp joinedAtTimeStamp = userDoc.get('createdAt') ;

          var joinDate = joinedAtTimeStamp.toDate() ;
          joinedAt= '${joinDate.year}:${joinDate.month}:${joinDate.day}' ;

        });


        User? user= _auth.currentUser;
        String uid= user!.uid ;
        //To do check if same user
        setState(() {

          // _issameUser = uid == widget.userId ;

          if(uid == widget.userId) {_issameUser= true ;}
          else {_issameUser = false ;}
        });


      }

    }catch(error)
    {
      print(error.toString()) ;
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error'),
              )
            ],
          ),
          content: Text("User Not Login !"),
          actions: [
            TextButton(onPressed: (){
              Navigator.canPop(context) ?
              Navigator.pop(context)  :null ;
            }, child: Text('Cancle')) ,

          ],
        ) ;
      });

    }finally{
      setState(() {

        _isloading =false ;
      });
    }

  }

  //




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
        title: Text('Profile' , style: TextStyle(color: Colors.white ),),
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
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
            children: [
              Card(
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    SizedBox(height: 50,) ,
                    Align(
                      alignment: Alignment.center ,
                      child: Text(name ,style: TextStyle(fontSize: 22,
                          fontWeight: FontWeight.bold),)
                    ),
                    SizedBox(height: 10,) ,
                    Align(
                      alignment: Alignment.center ,
                      child: Text( job ,style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.normal),),
                    ),

                    Align(
                      alignment: Alignment.center ,
                      child: Text( joinedAt ,style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.normal),),
                    ),


                    SizedBox(height: 15,) ,
                    Divider(thickness: 1,),
                    SizedBox(height: 15,) ,
                    Text('Contact Info',style: TextStyle(fontSize: 22,
                        fontWeight: FontWeight.bold),),
                    
                    SocialInfo(label: 'Email: ', email: email ),
                    
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                        child: SocialInfo(label: 'Phone Number: ', email: phoneNumber )),

                    SizedBox(height: 12,) ,
                   _issameUser ? Container() : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SocialIcon(color: Colors.green, icon: FontAwesomeIcons.whatsapp  , fct: (){
                          print('whatsup');
                          _openWhatsUpChat();
                        }),

                        SocialIcon(color: Colors.red, icon: Icons.mail , fct: (){
                          print('email');
                          _mailTo() ;
                        }),

                        SocialIcon(color: Colors.purple, icon: Icons.phone , fct: (){
                          _callphoneNumber();
                        }),
                      ],
                    ) ,
                    SizedBox(height: 20,) ,
                    _issameUser ? Container() : Divider(thickness: 1,),
                    !_issameUser ? Container() :   MaterialButton

                      (onPressed: () async {

                      //   else print('enter all fields');
                      await _auth.signOut() ;
                      // Navigator.canPop(context) ? Navigator.pop(context)  :null ;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UserState()));
                      print('logout');
                    } ,
                      color: Colors.pink.shade700 ,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Logout' , style: TextStyle(color: Colors.white),),
                            Icon(
                              Icons.logout , color: Colors.white,
                            )
                          ],),
                      ),),



                  ],
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center ,

                children: [
                  Container(
                    width: 60 ,
                    height: 60 ,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3 , color: Colors.grey ),
                        shape: BoxShape.circle ,
                        image: DecorationImage( image:
                        NetworkImage(
                               imgUrl == null ?
                            'https://e7.pngegg.com/pngimages/348/800/png-clipart-man-wearing-blue-shirt-illustration-computer-icons-avatar-user-login-avatar-blue-child.png'
                                : imgUrl! ),
                            fit: BoxFit.fill)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget SocialInfo({ @required String? label ,@required String? email}){
    return  Row(
      children: [
        Text('${label}',style: TextStyle(fontSize: 22,
            fontWeight: FontWeight.bold),),

        Text('${email}',style: TextStyle(fontSize: 22,
            fontWeight: FontWeight.normal ,),
        )],
    );
  }



  Widget SocialIcon({@required Color? color, @required IconData? icon,@required  Function? fct}){
   return CircleAvatar(
      radius: 25,
      backgroundColor: color ,
      child:CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white ,
        child: IconButton(onPressed: (){fct!();},icon:Icon(icon , size: 20,)),


      ) ,

    );




  }

  void _openWhatsUpChat() async
  {
    // String phone= '24781' ;
    var url = 'https://wa.me/$phoneNumber?text=hello' ;
    if(await canLaunch(url))
    {
      await launch(url);

    }
    else
    {
      throw 'can\'nt open this link !' ;
    }
  }

  void _mailTo() async
  {
    // String email = 'saraamohamed090@gmail.com' ;
    var url = 'mailto:$email ' ;
    if(await canLaunch(url))
    {
      await launch(url);
    }
    else
    {
      throw 'can\'nt open this link !' ;
    }

  }

  void _callphoneNumber() async
  {
    // String phone= '24781' ;
    var url = "tel://$phoneNumber ";
    if(await canLaunch(url))
    {
      await launch(url);
    }
    else
    {
      throw 'can\'nt open this phone !' ;
    }

  }
}









