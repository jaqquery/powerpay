import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:powerpay/screens/splashscreen/splashscreen.dart';

Future<void> checkState(context, state, widget) async {
    switch(state){
      case AppLifecycleState.resumed:
      
        // Sequence: 
        // 1. Power button pressed: -inactive,hidden.paused,hidden,inactive 
        // 2. Overview pressed: - inactive
        // 3. Home pressed: - inactive,hidden,paused,hidden, inactive
        // 4. Detached: inactive, hidden, paused, detached

        if((widget.inactive == true && widget.hidden == true && widget.paused == true) || (widget.inactive == true && widget.hidden == false && widget.paused == false && widget.detached == false)){
          //resumed from power button - do nothing
        }
        else if(widget.inactive == true || widget.hidden == true || widget.paused == true || widget.detached == true){
          if (kDebugMode) {
            print("Call Splash");
          }
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode:1)));
        }
        widget.inactive = false; 
        widget.hidden = false;
        widget.paused = false;
        widget.detached = false;
        break;
      case AppLifecycleState.inactive:
        if (kDebugMode) {
          print("inactive");
        }
        widget.inactive = true;
        break;
      case AppLifecycleState.hidden:
        if (kDebugMode) {
          print("hidden");
        }
        widget.hidden = true;
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print("paused");
        }
        widget.paused = true;
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print("detached");
        }
        widget.detached = true;
        break;  
    }
}
    