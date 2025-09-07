import 'package:flutter/material.dart';
import 'package:powerpay/screens/logins/login.dart';
import 'package:powerpay/screens/splashscreen/splashscreen.dart';
import 'package:powerpay/util/assetdata.dart';

  //check the availability of a token
  // - > if exist -> getSettings  -> home
  //        <1 hour -> getSetting -> home
  //        >1 hour -> refreshLogin -> getSetting -> home  
  //if API Request ok, go to home
  //if API request fail, then route to login page
  // -> if not exist -> route to login page     

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: server.hasKeySecureData(server.token),
        builder: (context, AsyncSnapshot<bool> snapshot){

          if(snapshot.connectionState == ConnectionState.done){
            
            if(snapshot.data == true){
              return Splash(mode: 0);
            }else{              
              return const LoginRunApp();
            }

          }else{
            return const Scaffold(
                    body: Center(
                    child: CircularProgressIndicator(),
                  ),
            );
          }
        },
      )
    );
  }
}