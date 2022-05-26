import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Color bgColor1 = Colors.grey.shade800;
  Color textColor1 = Colors.black;
  Color bgColor2 = Colors.grey.shade800;
  Color textColor2 = Colors.black;

  bool isOn1 = false;
  bool isOn2 = false;

  turnOn1(){
    bgColor1 = Colors.orange;
    textColor1 = Colors.white;
  }

  turnOff1(){
    bgColor1 = Colors.grey.shade800;
    textColor1 = Colors.black;
  }

  turnOn2(){
    bgColor2 = Colors.orange;
    textColor2 = Colors.white;
  }

  turnOff2(){
    bgColor2 = Colors.grey.shade800;
    textColor2 = Colors.black;
  }

  void tap1(){
    if(isOn1==true  &&  isOn2==false){
      turnOn2();
      isOn2 = !isOn2;
      turnOff1();
      isOn1 = !isOn1;
    }
    if(isOn1==isOn2 && !isOn1){
      turnOn2();
      isOn2 = !isOn2;
      showPauseIcon = true;
    }
  }

  void tap2(){
    if(isOn1==false  &&  isOn2==true){
      turnOn1();
      isOn1 = !isOn1;
      turnOff2();
      isOn2 = !isOn2;
    }
    if(isOn1==isOn2 && !isOn1){
      turnOn1();
      isOn1 = !isOn1;
      showPauseIcon = true;
    }
  }

  void resetClock(){
    setState(() {
      bgColor1 = Colors.grey.shade800;
      textColor1 = Colors.black;
      bgColor2 = Colors.grey.shade800;
      textColor2 = Colors.black;

      isOn1 = false;
      isOn2 = false;

      showPauseIcon = false;
    });
  }

  bool showPauseIcon = false;


  Widget timerCard1(){
    return GestureDetector(
      onTap: (() {
        setState(tap1);
        final player1 = AudioCache();
        player1.play('tick1.wav');
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor1
          ),
        width: double.infinity,
        height: 230,
        child: RotatedBox(
          quarterTurns: 2,
          child: Center(child: Text("5:00",style: TextStyle(fontSize: 100, color: textColor1)),
            ),
        )),
    );
  }

  Widget timerCard2(){
    return GestureDetector(
      onTap: ((){
        setState(tap2);
        final player2 = AudioCache();
        player2.play('tick2.wav');
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor2
          ),
        width: double.infinity,
        height: 230,
        child: Center(child: Text("5:00",style: TextStyle(fontSize: 100, color: textColor2)),
      )),
    );
  }

  Widget buttonCard(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: changeClockPopup,
            child: Container(
              width: 100,
              child: Icon(
                Icons.settings,
                size: 40,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          GestureDetector(
            child: showPauseIcon ?SizedBox(
              width: 100,
              child: Icon(
                Icons.pause,
                size: 45,
                color: Colors.grey.shade700,
              ),
            ) :Container(
              width: 100,
            ),
          ),
          GestureDetector(
            onTap: resetClock,
            child: Container(
              width: 100,
              // color: Colors.amber,
              child: Icon(
                Icons.restart_alt,
                size: 45,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  changeClockPopup(){
    return showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text('Change Clock'),
        content: Container(
          height: 200,
          // color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('1'),
                ],
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blueGrey ,width: 1),borderRadius: BorderRadius.circular(15),),
                  hintText: 'P1',
                  hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blueGrey ,width: 1),borderRadius: BorderRadius.circular(15),),
                  hintText: 'Player2 Timer',
                  hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                ),
              )
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: Navigator.of(context).pop, 
            child: Text('Done')
          )
        ],
      ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                timerCard1(),
                buttonCard(),
                timerCard2(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}