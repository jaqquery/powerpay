import 'package:flutter/material.dart';
import 'package:powerpay/screens/splashscreen/splashscreen.dart';
import 'package:powerpay/util/dialog.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:google_fonts/google_fonts.dart';

FocusNode myFocusNode = FocusNode();
TextEditingController loginNumberController = TextEditingController();
TextEditingController loginPasswordController = TextEditingController();

class LoginRunApp extends StatefulWidget{  
  const LoginRunApp({
    super.key,
  });    
  @override
  State<LoginRunApp> createState() => _RunLoginRunAppState();
}

class _RunLoginRunAppState extends State<LoginRunApp> { 
  
  var loginBorderColor = Colors.transparent; 
  var pwdBorderColor = Colors.transparent; 

  bool passwordVisible=true;

  FocusNode textLoginNumFocusNode = FocusNode();
  FocusNode textLoginPwdFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:Builder(
          builder: (context) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: adjustResolution(context, Resolution.normal.index, 470),
                          decoration: const BoxDecoration(
                            gradient:  
                                LinearGradient(
                                colors: <Color>[                      
                                  Color(0xFF3EB9EC),
                                  Color(0xFF1F6FC8),
                                ],
                              ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                                        ),
                    Padding(
                      padding:  EdgeInsets.only(top: adjustResolution(context, Resolution.normal.index, 100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset(ppLogoWhiteVerPng, height: adjustResolution(context, Resolution.normal.index, 180), width:adjustResolution(context, Resolution.normal.index, 190))],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: adjustResolution(context, Resolution.normal.index, 350), left: 20, right: 20),
                      child: Container(
                        width: double.infinity,
                        height: adjustResolution(context, Resolution.normal.index, 200),
                        decoration: BoxDecoration(              
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: adjustResolution(context, Resolution.normal.index, 10)),
                          child: Column(
                                  children: [
                                    Row(
                                        children: <Widget>[
                                        Icon(Icons.phone_android, size:adjustResolution(context, Resolution.normal.index, 20)),
                                        Text("    |   ",   style: GoogleFonts.figtree(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Figtree', color: Color(0xFF257CCE)))),
                                        SizedBox(
                                          width: 180,
                                          child: TextField(
                                            focusNode: textLoginNumFocusNode,
                                            style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20), fontWeight: FontWeight.w600)),                 
                                            controller: loginNumberController,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              focusedBorder:  UnderlineInputBorder(                        
                                                  borderSide: BorderSide(
                                                                width: 2, 
                                                                color: loginBorderColor,      
                                                  )
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 2, color: loginBorderColor,
                                                  ),
                                              ) ,
                                              labelText: 'Enter mobile number',                                  
                                              labelStyle: GoogleFonts.figtree( textStyle: 
                                                            TextStyle(                                                        
                                                              fontSize: adjustResolution(context, Resolution.normal.index, 14),
                                                              color: myFocusNode.hasFocus ? const Color.fromARGB(255, 0, 93, 169) : Colors.grey[400]
                                                            ),
                                                          ),
                                              filled: true,
                                              floatingLabelStyle:  const TextStyle(color: Color.fromARGB(255, 0, 93, 169)),
                                            ),
                                            keyboardType: TextInputType.number,        
                                          ),
                                        ),
                                      ]
                                    ),
                                    const Divider(),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.key_sharp, size: adjustResolution(context, Resolution.normal.index, 20)),
                                        Text("    |   ",   style: GoogleFonts.figtree(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Figtree', color: Color(0xFF257CCE)))),
                                        SizedBox(
                                          width: adjustResolution(context, Resolution.normal.index, 240),
                                          child: TextField(
                                            focusNode: textLoginPwdFocusNode,   
                                            style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20), fontWeight: FontWeight.w600)),                            
                                            controller: loginPasswordController,
                                              obscureText: passwordVisible,                   
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1, color: pwdBorderColor,                          
                                                  )
                                              ),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1, color: pwdBorderColor,                          
                                                  ),
                                                ) ,
                                              labelText: 'Enter password',                                  
                                              labelStyle: GoogleFonts.figtree(textStyle:  TextStyle(                                                        
                                                  fontSize: adjustResolution(context, Resolution.normal.index, 14),
                                                  color: myFocusNode.hasFocus ? const Color.fromARGB(255, 0, 93, 169) : Colors.grey[400]
                                                )
                                              ),          
                                              filled: true,
                                              floatingLabelStyle:  const TextStyle(color: Color.fromARGB(255, 0, 93, 169)),                    
                                              suffixIcon: IconButton(
                                                icon: Icon(passwordVisible
                                                            ? Icons.visibility_off
                                                            : Icons.visibility,
                                                          size: adjustResolution(context, Resolution.normal.index, 20)
                                                    ),
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      passwordVisible = !passwordVisible;
                                                    },
                                                  );
                                                },
                                              ),
                                            ),        
                                          ),
                                        ),
                                      ]
                                    ),
                                ],),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: adjustResolution(context, Resolution.height.index, 580), left: 20, right: 20),
                            child: SizedBox(                        
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),                  
                                child: Stack(
                                  children: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        // backgroundColor: const Color(0xFF03033C),
                                        backgroundColor: buttonColor,
                                        foregroundColor: Colors.white,
                                        fixedSize: const Size(500,50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                      ),
                                      child: Text('Log In', style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w600))),                        
                                      onPressed: () async {
            
                                        //check empty username or password
                                        if(loginNumberController.text.isEmpty && loginPasswordController.text.isEmpty){
                                          setState(() {
                                            loginBorderColor = Colors.red;
                                            pwdBorderColor = Colors.red;
                                            FocusScope.of(context).requestFocus(textLoginNumFocusNode);                              
                                          });
                                        }else if(loginNumberController.text.isNotEmpty && loginPasswordController.text.isEmpty){
                                          //set focus node to login box, and set the border color to red
                                          setState(() {
                                            loginBorderColor = Colors.transparent;
                                            pwdBorderColor = Colors.red;
                                          });
                                          FocusScope.of(context).requestFocus(textLoginPwdFocusNode);
                                        }else if(loginNumberController.text.isEmpty && loginPasswordController.text.isNotEmpty){
                                          //set focus node to password box, and set the border color to red 
                                          setState(() {
                                            loginBorderColor = Colors.red;
                                            pwdBorderColor = Colors.transparent;
                                          });
                                          FocusScope.of(context).requestFocus(textLoginNumFocusNode);
                                        }else{
        
                                          try{
                                            setState(() {
                                              loginBorderColor = Colors.transparent;
                                              pwdBorderColor = Colors.transparent;
                                            });
                                            hud.show();
                                            //get device id, device model and device token
                                            bool loginStatus = await server.sendLoginRequest(loginNumberController.text, loginPasswordController.text); 
                                            if (loginStatus == true){
                                              hud.hide();
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode: 0)));
                                            }else{
                                              hud.hide();
                                              // ignore: use_build_context_synchronously
                                              CustomDialog.cancelDialog(context, errLoginMsg.isEmpty ? "Host unreachable": "Incorrect Username or Password");
                                            }
                                            hud.hide();
                                          }catch (err){
                                            throw("$err"); 
                                          }
                                        }                              
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ]      
                    ),
                )
              ],
            );
          }
        ),
    );
  }

}