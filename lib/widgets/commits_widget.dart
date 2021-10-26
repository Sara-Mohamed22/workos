


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {

  List <Color> _colors = [
    Colors.red ,
    Colors.green ,
    Colors.blue ,
  ];

  @override
  Widget build(BuildContext context) {
    _colors.shuffle();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        
        Expanded(
          flex: 1,
          child: Container(
            width: 40,
            height: 40 ,
            decoration: BoxDecoration(
              border: Border.all(width: 3 , color: _colors[2] ),
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage('https://e7.pngegg.com/pngimages/348/800/png-clipart-man-wearing-blue-shirt-illustration-computer-icons-avatar-user-login-avatar-blue-child.png'),
                  fit:BoxFit.fill  ),
            ),


          ),
        ),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('commeter name'),
              SizedBox(height: 10,),
              Text('commeter info') ,
            ],
          ),
        )

      ],

    );
  }
}
