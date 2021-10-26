import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:workos/screens/auth/signup.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> with
    TickerProviderStateMixin {
  late   AnimationController  _animationController ;
  late  Animation<double> animation ;
  var emailcontroller = TextEditingController() ;
  var passcontroller = TextEditingController() ;

  bool  _observe = false ;

  var formkey = GlobalKey<FormState>();

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
                Text('Forget Password' , style :TextStyle(fontSize: 30 ,
                  fontWeight: FontWeight.bold ,
                  //  color: Colors.white

                ),) ,

                SizedBox(height: 10,),
                RichText(text: TextSpan(children: [
                  TextSpan(text: 'Email Address' ,style: TextStyle(color: Colors.black , fontStyle: FontStyle.italic)),
                  TextSpan(text :' '),

                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=(){
                      print('Sign Up');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );

                    },
                    text: 'SignUp' ,style: TextStyle(color: Colors.blue ,
                      decoration: TextDecoration.underline ),
                  ),
                ])),
                SizedBox(height: size.height*.05,),
                Form(
                  key: formkey ,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller ,
                        validator: (value){
                          if(value!.isEmpty || value.contains('@'))
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
                    /*  TextFormField(
                        controller: passcontroller ,
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

                      ), */
                    ],
                  ),
                ) ,




                SizedBox(height: 15,),

               /* Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(onPressed: (){}, child: Text('forget password',style: TextStyle(color: Colors.blue ,
                      fontStyle: FontStyle.italic ,
                      decoration: TextDecoration.underline),)),
                ),*/
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Reset Password' , style: TextStyle(color: Colors.white),),
                       /* Icon(
                          Icons.login_sharp , color: Colors.white,
                        )*/
                      ],),
                  ),),

              ],
            ),
          )

        ],
      ),

    );
  }
}
