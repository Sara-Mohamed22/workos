
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workos/screens/auth/login.dart';
import 'package:workos/constant/constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with
    TickerProviderStateMixin {
  late   AnimationController  _animationController ;
  late  Animation<double> animation ;
  var fullnamecontroller = TextEditingController() ;
  var emailcontroller = TextEditingController() ;
  var passcontroller = TextEditingController() ;
  var positioncontroller = TextEditingController() ;
   var pnumcontroller = TextEditingController() ;
  bool  _observe = false ;
  bool _isloading = false ;

  File? imgefile ;
  final FirebaseAuth _auth = FirebaseAuth.instance ;


  var formkey = GlobalKey<FormState>();

  FocusNode fname = FocusNode() ;
  FocusNode email = FocusNode() ;
  FocusNode pass = FocusNode() ;
  FocusNode position = FocusNode() ;
  FocusNode pnum = FocusNode() ;

   String? url ;

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose() ;
    super.dispose();
  }

  @override
  void initState() {
    _animationController =AnimationController(vsync: this , duration: Duration(seconds: 20));
    animation = CurvedAnimation(parent: _animationController , curve: Curves.linear)..addListener(() {setState(() {

    });})..addStatusListener((animationstatus) {
      if(animationstatus == AnimationStatus.completed)
      {
        _animationController.reset() ;
        _animationController.forward();
      }

    });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size ;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
            'https://images.unsplash.com/photo-1571844307880-751c6d86f3f3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=817&q=80' ,
            placeholder: (context, url) => Image.asset('assets/images/wallpaper.jpg' , fit: BoxFit.fill,),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover ,
            alignment: FractionalOffset(animation.value ,0 ),
            width: double.infinity ,
            height: double.infinity ,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                SizedBox(height: size.width*.1),
                Text('Sign UP' , style :TextStyle(fontSize: 30 ,
                  fontWeight: FontWeight.bold ,
                  //  color: Colors.white

                ),) ,

                SizedBox(height: 10,),
                RichText(text: TextSpan(children: [
                  TextSpan(text: 'Already have an Account?' ,style: TextStyle(color: Colors.black)),
                  TextSpan(text :' '),

                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=(){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      print('Sign Up');
                      },
                    text: 'Login' ,style: TextStyle(color: Colors.blue ,
                      decoration: TextDecoration.underline ),
                  ),
                ])),
                SizedBox(height: size.height*.05,),
                Form(

                  key: formkey ,


                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: email,
                         textInputAction: TextInputAction.next,
                        onEditingComplete: ()=> FocusScope.of(context).requestFocus(fname),
                        controller: emailcontroller ,
                        validator: (value){
                          if(value!.isEmpty )
                          {
                            return 'Please Enter Valid Email' ;
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)) ,
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink.shade200)) ,
                          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade300)) ,
                        ),

                      ),
                      SizedBox(height: 10,),

                      Row(
                        children: [
                          Flexible(
                            flex:2 ,
                            child: TextFormField(
                              focusNode: fname,
                              onEditingComplete: ()=> FocusScope.of(context).requestFocus(pass),
                              controller: fullnamecontroller ,
                              validator: (value){
                                if(value!.isEmpty || value.contains('@'))
                                {
                                  return 'Please Enter Valid Full name' ;
                                }
                                return null ;
                              },
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)) ,
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink.shade200)) ,
                                errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade300)) ,
                              ),

                            ),
                          ),
                          Flexible(
                            child: Stack(

                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1 ,color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),

                                  ),

                                  child: ClipRRect(child: imgefile == null ?
                                  Image.network('https://img.favpng.com/3/7/23/login-google-account-computer-icons-user-png-favpng-ZwgqcU6LVRjJucQ9udYpX00qa.jpg' ,

                                 ): Image.file( imgefile! , fit:BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15),),
                                ),

                                Positioned(

                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: (){
                                      print('show pick image dialog');

                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          title: Text('Please choose an option '),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  pickImageWithCamera() ;
                                                  Navigator.pop(context) ;
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.camera ,color: Colors.purple , ) ,
                                                    Text('Camera') ,
                                                  ],
                                                ),
                                              ),

                                              SizedBox(height: 10,),

                                              InkWell(
                                                onTap: (){
                                                  pickImageWithGallery();
                                                  Navigator.pop(context) ;

                                                },
                                                child: Row(
                                                  children: [

                                                    Icon(Icons.photo ,color: Colors.purple , ) ,
                                                    Text('Gallery') ,
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.pink,
                                        border: Border.all(width: 2, color: Colors.white ),
                                        shape: BoxShape.circle ,
                                      ),
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Icon(   imgefile==null ?  Icons.add_a_photo :Icons.edit_outlined ,
                                        size: 20,color: Colors.white ,),
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        focusNode: pass,
                        controller: passcontroller ,
                        onEditingComplete: ()=> FocusScope.of(context).requestFocus(pnum),
                        obscureText: _observe ,
                        validator: (value){
                          if(value!.isEmpty )
                          {
                            return 'Please Enter Valid Password' ;
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          suffix: GestureDetector(onTap: (){
                            setState(() {
                              if( _observe == false)  _observe = true ;
                              else  _observe = false ;
                            });
                          },

                            child: _observe? Icon(Icons.visibility) :Icon(Icons.visibility_off ) ,),
                          hintText: 'Password ',
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)) ,
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink.shade200)) ,
                          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade300)) ,
                        ),

                      ),

                      TextFormField(
                        focusNode: pnum ,
                        keyboardType: TextInputType.number ,
                        onEditingComplete: ()=> FocusScope.of(context).requestFocus(position),
                        controller: pnumcontroller ,
                        validator: (value){
                          if(value!.isEmpty )
                          {
                            return 'Please Enter Valid Phone Numer' ;
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)) ,
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink.shade200)) ,
                          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade300)) ,
                        ),

                      ),

                      TextFormField(
                        focusNode: position ,
                        textInputAction: TextInputAction.done ,
                        onTap: (){

                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text('Job' , style: TextStyle(
                                  color: Colors.pink[800 ] ,fontSize: 20),),
                              content: ListView.builder(
                                  shrinkWrap: true ,
                                  itemCount :constant.jobLists.length  ,
                                  itemBuilder: (context , index){
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle_outline ,color: Colors.red[300],),
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                positioncontroller.text = constant.jobLists[index];
                                                Navigator.pop(context) ;

                                              });
                                            },
                                              child: Text('${constant.jobLists[index]}' , style: TextStyle(fontSize: 18 ,),))
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
                        },
                        controller: positioncontroller ,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return 'Please Enter Valid Position' ;
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          hintText: 'position',
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)) ,
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink.shade200)) ,
                          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade300)) ,
                        ),

                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ) ,


                SizedBox(height: 15,),

              /*  Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(onPressed: (){}, child: Text('forget password',style: TextStyle(color: Colors.blue ,
                      fontStyle: FontStyle.italic ,
                      decoration: TextDecoration.underline),)),
                ),*/


               _isloading?Center(child: Container(
                 width: 20,
                   height: 20,
                   child: CircularProgressIndicator())) : MaterialButton

                  (onPressed: ()async {
                 if (formkey.currentState!.validate()) {
                   if(imgefile == null){
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
                         content: Text("Please pick up Image !"),
                         actions: [
                           TextButton(onPressed: (){
                             Navigator.canPop(context) ?
                             Navigator.pop(context)  :null ;
                           }, child: Text('Cancle')) ,

                         ],
                       ) ;
                     });
                     return ;
                   }

                   print('nice');
                   print(emailcontroller.text.toLowerCase().trim());
                   print(passcontroller.text.toLowerCase().trim());

                   setState(() {
                     _isloading = true;
                   });

                   try {
                     await _auth.createUserWithEmailAndPassword(
                         email: emailcontroller.value.text.toLowerCase()
                             .trim(),
                         password: passcontroller.value.text.toLowerCase()
                             .trim()).
                     then((value) async{
                       print('111');

                       setState(() {
                         _isloading = false;
                       });


                       final User? user = _auth.currentUser ;
                       final uid =user!.uid ;
                       final ref =FirebaseStorage.instance.ref().child('userImage').child(uid+"jpg");
                       await ref.putFile(imgefile!);
                       url = await ref.getDownloadURL();

                      await FirebaseFirestore.instance.collection('users').doc(uid).set(
                           {
                             "Id": uid ,
                             "name": fullnamecontroller.text,
                             "email" : emailcontroller.text ,
                             "userImgUrl" : url ,
                             "phoneNum" : pnumcontroller.text ,
                             "position" :positioncontroller.text ,
                             "createdAt" : Timestamp.now()

                           }

                       ).then((value) => print('222')).catchError((error)=> print('error in firebase ${error.toString()}'));




                     });


                     Navigator.canPop(context) ? Navigator.pop(context)  :null ;
                   }


                   catch (error) {
                     print('error occurs !');
                     showDialog(context: context, builder: (context){
                       return AlertDialog(
                         title: Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text('Error Occur !'),
                             )
                           ],
                         ),
                         content: Text("${error}"),
                         actions: [
                           TextButton(onPressed: (){
                             Navigator.canPop(context) ?
                             Navigator.pop(context)  :null ;
                           }, child: Text('Cancle')) ,

                         ],
                       ) ;
                   }
                     ); }


                   //

    }
                 // else print('enter all fields');
                 else
                 {
                   setState(() {
                     _isloading = false ;

                   });


                   }
                   // }
                },
                  color: Colors.pink.shade700 ,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Register' , style: TextStyle(color: Colors.white),),
                        Icon(
                          Icons.person_add , color: Colors.white,
                        )
                      ],),
                  ),),

              ],
            ),
          )

        ],
      ),

    );
  }

  void pickImageWithCamera() async {
      PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.camera ,
          maxHeight: 1080 , maxWidth: 1080) ;

        setState(() {
          if (pickedFile != null) {
            imgefile = File(pickedFile.path);
          } else {
            print('No image selected.');
          }
        });
      //croppImage(pickedFile!.path );
  }


  void pickImageWithGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.gallery ,
        maxHeight: 1080 , maxWidth: 1080) ;

    setState(() {
      if (pickedFile != null) {
        imgefile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
   // croppImage(pickedFile!.path );

  }


  /*void croppImage(filepath) async
  {
    File ?  cropImg= await ImageCropper.cropImage(
        sourcePath: filepath ,
        maxWidth: 1080,maxHeight: 1080);

    setState(() {
        if(cropImg != null )
          {
            imgefile = cropImg ;
          }
    });
  }*/



}
