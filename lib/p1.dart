import 'package:flutter/material.dart';
class p1 extends StatefulWidget {
  const p1({Key? key}) : super(key: key);

  @override
  State<p1> createState() => _p1State();
}

class _p1State extends State<p1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withOpacity(0.2),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: RichText(text: TextSpan(text: 'MON ',style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w900
              ),
                  children: [
                    TextSpan(text: '30 May',style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.normal
                    ),)
                  ]
              ),
              ),
            ),
            SizedBox(height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1,color: Colors.white),
                    boxShadow: [
                      BoxShadow(color: Colors.blueAccent.withOpacity(0.9),
                        blurRadius: 12,
                        spreadRadius: 8,)
                    ],

                    image: DecorationImage(
                      fit:BoxFit.cover,
                      image: NetworkImage('data:image/jpeg;base64,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'),                ),

                  ),
                ),
                SizedBox(width: 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello Peter',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueAccent.withOpacity(1),
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Here is your to do list ',style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepPurpleAccent,
                    ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'to remind you ',style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepPurpleAccent,
                    ),
                    ),
                  ],)
              ],)
          ],
        )
    );
  }
}
