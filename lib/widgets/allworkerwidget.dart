import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../profile.dart';

class WorkWidget extends StatefulWidget {
  final String userId ;
  final String username ;
  final String useremail ;
  final String userposition ;
  final String userphoneNum ;
  final String userImage ;

  const WorkWidget({required this.userId , required this.username ,
    required this.useremail , required this.userposition ,
    required this.userImage , required this.userphoneNum }) ;

  @override
  _WorkWidgetState createState() => _WorkWidgetState();
}


class _WorkWidgetState extends State<WorkWidget> {



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 8),
      child: ListTile(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.userId ,)),
          );
        },

        contentPadding: EdgeInsets.symmetric(horizontal: 12 , vertical: 8),
        leading: Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(border: Border(right: BorderSide(width: 1))),
          child: CircleAvatar(radius: 20,
            backgroundColor: Colors.transparent,
            child: Image.network(
              widget.userImage ==null ?
              'https://e7.pngegg.com/pngimages/348/800/png-clipart-man-wearing-blue-shirt-illustration-computer-icons-avatar-user-login-avatar-blue-child.png':
              widget.userImage
           , width: 150,
            height: 150,),),
        ),
        title: Text( widget.username , maxLines: 2 , overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold ),),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.linear_scale ,  color: Colors.pink.shade800 ,),
            Text('${widget.userposition} / ${ widget.userphoneNum }' ,
              maxLines: 2,
              overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16),),

          ],),
        trailing: IconButton(onPressed: (){
          _mailTo();
        } ,

            icon: Icon(Icons.mail_outline , color: Colors.pink.shade800, size: 30,)),
      ),
    );
  }
  void _mailTo() async
  {
    var url = 'mailto:${widget.useremail } ' ;
    if(await canLaunch(url))
    {
      await launch(url);
    }
    else
    {
      throw 'can\'nt open this link !' ;
    }

  }
}
