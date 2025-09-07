import 'dart:async';
import 'package:flutter/material.dart';
import 'package:powerpay/screens/mainscreens/home.dart';
import 'package:powerpay/screens/mainscreens/transaction.dart';
import 'package:powerpay/screens/mainscreens/balance.dart';
import 'package:powerpay/screens/mainscreens/messages.dart';
import 'package:powerpay/screens/mainscreens/accountsettings.dart';
import 'package:powerpay/screens/mainscreens/livechat.dart';
// ignore: depend_on_referenced_packages
import 'package:draggable_fab/draggable_fab.dart';
import 'package:powerpay/util/assetdata.dart';

class Bottom extends StatefulWidget {
  final int currentIndex;

  const Bottom({
    super.key,
    this.currentIndex = 0
  });

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  
  // ignore: non_constant_identifier_names
  int currentIndex = 0;

  @override
  void initState(){
    super.initState();
    currentIndex = widget.currentIndex;
  }

  // ignore: non_constant_identifier_names
  List Screen = [Home(), Transaction(), Balance(), Messages(), Settings()];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Screen[currentIndex],
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: buttonColor,
          onPressed: (){
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Livechat()));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.headset_mic_outlined, color: Colors.white, size: adjustResolution(context, Resolution.normal.index, 25)),
          
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [             
              InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),              
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                child: Ink(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  height: 80,
                  width: 50,
                  child: Image.asset("assets/BottomLogo/Home.png", width: 40, height: 40, color: currentIndex == 0 ? buttonColor : Colors.grey,), 
                ),                
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: Ink(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  height: 80,
                  width: 50,                  
                  child: Image.asset("assets/BottomLogo/History.png", width: 40, height: 40, color: currentIndex == 1 ? buttonColor : Colors.grey,), 
                ),                
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                child: Ink(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  height: 80,
                  width: 50,
                  child: Image.asset("assets/BottomLogo/Balance.png", width: 40, height: 40, color: currentIndex == 2 ? buttonColor : Colors.grey,),                   
                ),                
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                child: Ink(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  height: 80,
                  width: 50,      
                  child: Image.asset("assets/BottomLogo/Messages.png", width: 40, height: 40, color: currentIndex == 3 ? buttonColor : Colors.grey,),             
                 ),                
              ),
              InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                onTap: () async {
                  
                  setState(() {
                    currentIndex = 4;
                  });

                  if(verf != "1") {
                    await Future.wait([
                      server.sendRefreshToken(context)
                    ]).then((List<bool> value) async {
                      await server.getSetting(context);
                    });  
                  }

                },
                child: Ink(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  height: 80,
                  width: 50,                  
                  child: Image.asset("assets/BottomLogo/Settings.png", width: 40, height: 40, color: currentIndex == 4 ? buttonColor : Colors.grey,),             
                ),                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
