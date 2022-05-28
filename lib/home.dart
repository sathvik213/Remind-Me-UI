import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  //60 sec - 360, 1 sec - 6degree
  //12 hours  - 360, 1 hour - 30degrees, 1 min - 0.5degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex=0;
  var time=DateTime.now();
  PageController pageController=PageController();
  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.easeInOutCubicEmphasized);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('RemindME'),),
      body: PageView(
      controller: pageController,
        children: [
          Container(color: Colors.blue,

                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: RichText(text: TextSpan(text:time.toString(),style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w900
                          )),),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 1,color: Colors.white),
                            boxShadow:[
                              BoxShadow(color: Colors.blueGrey.withOpacity(0.9),
                                blurRadius: 1,
                                spreadRadius: 2,)

                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
'https://www.clipartmax.com/png/middle/255-2557794_animated-person-animated-picture-of-man.png')
                            )



                          ),
                        ),
                        Container(
                          height: 100,
                          width: 500,
                          alignment: Alignment.centerLeft,
                          child: RichText(text: TextSpan(text:' Hello Person',style: TextStyle(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.w400
                          )),),

                        ),
                        Container(

                          child: ClockView(),
                        ),
                        Container(
                          width: 1000,
                          height: 240,
                          child: Container(

                            alignment: Alignment.topCenter,
                              child: RichText(text: TextSpan(text:'\nJune 1st | 6:00pm\nDoctor Appointment\n-----------------------------------------\nJune 2nd | 5:00pm\nBuyGroceries',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              )),),


                            decoration: BoxDecoration(

                                color: Colors.lightBlueAccent,

                                borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(70),
                                  topRight: Radius.circular(70),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)

                              )
                            ),
                          ),

                        ),

                      ],
                    ),
              ),
          Container(color: Colors.cyan,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: RichText(text: TextSpan(text:time.toString(),style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900
                    )),),
                  ),
                  Container(
                    height: 170,
                    width: 500,
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(text:' Medical Tablet Details',style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w400
                    )),),

                  ),
                   Container(
                    width: 1000,
                    height: 520,
                    child: Container(

                      alignment: Alignment.topCenter,
                      child: RichText(text: TextSpan(text:'\nJune 1st | 9:00pm\nTablet-1\n-----------------------------------------\nJune 2nd | 9:00am\nTablet-2\n-----------------------------------------\nJune 2nd | 9:00pm\nTablet-1\n-----------------------------------------\nJune 3rd | 9:00am\nTablet-3\n-----------------------------------------\nJune 4th | 5:00pm\nTablet-4',style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      )),),


                      decoration: BoxDecoration(

                          color: Colors.lightGreenAccent,

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70),
                              topRight: Radius.circular(70),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)

                          )
                      ),
                    ),

                  ),

                ],
              )),
          Container(color: Colors.pink,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: RichText(text: TextSpan(text:time.toString(),style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900
                  )),),
                ),
                Container(
                  height: 170,
                  width: 500,
                  alignment: Alignment.centerLeft,
                  child: RichText(text: TextSpan(text:'Banking Details',style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w400
                  )),),

                ),
                Container(
                  width: 1000,
                  height: 520,
                  child: Container(

                    alignment: Alignment.topCenter,
                    child: RichText(text: TextSpan(text:'\nJune 1st | 10:00am\nCredited:Rs.1000\n-----------------------------------------\nJune 2nd | 9:00am\nDebited:Rs.1000\n-----------------------------------------\nJune 2nd | 9:00pm\nCredited:Rs.1000\n-----------------------------------------\nJune 3rd | 9:00am\nDebited:Rs.1000\n-----------------------------------------\nJune 4th | 5:00pm\nDebited:Rs.1000',style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    )),),


                    decoration: BoxDecoration(

                        color: Colors.deepOrange,

                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)

                        )
                    ),
                  ),

                ),

              ],
            )),
          Container(color: Colors.white),
          Container(color: Colors.purple),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(label:'Tasks',icon: Icon(Icons.task,color: Colors.white,size: 40.0,)),
        BottomNavigationBarItem(label:'MedRem',icon: Icon(Icons.medical_services_rounded,color: Colors.white,size: 40.0,)),
        BottomNavigationBarItem(label:'Banking ',icon: Icon(Icons.monetization_on_rounded,color: Colors.white,size: 40.0,
            semanticLabel: 'Text to announce in accessibility modes')),
        BottomNavigationBarItem(label:'Account',icon: Icon(Icons.account_box,color: Colors.white,size: 40.0 )),
      ],
      currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.red,
        onTap: onTapped
      ),
    );
  }
}
