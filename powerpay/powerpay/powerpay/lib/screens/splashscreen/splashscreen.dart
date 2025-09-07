import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:powerpay/screens/logins/login.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/dialog.dart';
import 'package:powerpay/widgets/bottomnavigationbar.dart';
import 'package:sizer/sizer.dart';


// ignore: must_be_immutable
class Splash extends StatefulWidget {
  int mode;
  Splash({
    super.key, 
    required this.mode
  });

  @override
  State<Splash> createState() => _Splash();
}

class _Splash extends State<Splash> { 
  bool? statGetSetting;
  void _getSplashSetting() async {      
    
    try{
      await Future.wait([
        server.sendRefreshToken(context)
      ]).then((List<bool> value) async {
        statGetSetting = await server.getSetting(context);
      });
    }catch (e){
            
      if (kDebugMode) {
        print(e);
      }

      // ignore: use_build_context_synchronously
      CustomDialog.hostUnreachable(context, "Host unreachable");
      // ignore: use_build_context_synchronously
      
    }

    if(statGetSetting! == false){
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginRunApp()));
    }

    Future.delayed(const Duration(seconds: 2), (){
      switch(widget.mode){
        case 0:
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Bottom()));
          break;
        case 1:
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
            break;  
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getSplashSetting();

    //handling notification receive from broadcast
    messagingService.configureMessaging();

  }
  
  @override
  Widget build(BuildContext context) {

    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {  
        return  MaterialApp(
                home: Scaffold(
                    body:             
                      Container(
                        decoration: 
                        const BoxDecoration(
                          gradient: LinearGradient(
                              colors: <Color>[                      
                                Color(0xFF3EB9EC),
                                Color(0xFF1F6FC8),
                              ],
                            ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ppLogoWhiteVerPng, 
                                  width: 32.h,
                                  height: 38.w,
                                )
                              ],
                            ),
                          ],
                        ), 
                      ),    
                    )
            ); 
      },
    );

  }
}