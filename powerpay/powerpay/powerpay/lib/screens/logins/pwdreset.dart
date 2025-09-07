import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/dialog.dart';

class PwdReset extends StatefulWidget{
    
    const PwdReset({
      super.key,
    });

    @override
    State<PwdReset> createState() => _PwdResetState();
}

class _PwdResetState extends State<PwdReset> {
  bool passwordExtVisible=true;
  bool passwordNewVisible=true;
  bool passwordCfmVisible=true;
  
  Color borderColorExtPwd =Colors.transparent;
  Color borderColorNewPwd =Colors.transparent;
  Color borderColorConfPwd = Colors.transparent;

  FocusNode textExtPwdFocusNode = FocusNode();
  FocusNode textNewPwdFocusNode = FocusNode();
  FocusNode textConfNewPwdFocusNode = FocusNode();
  TextEditingController ctrlExtPwd = TextEditingController();
  TextEditingController ctrlNewPwd = TextEditingController();
  TextEditingController ctrlConfNewPwd = TextEditingController();

  @override
  Widget build(BuildContext context){

    return Scaffold(      
      body: CustomScrollView(
          slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                
                Container(
                  width: double.infinity,
                      height: 425,
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
                  padding: const EdgeInsets.only(left: 20, top: 100),
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onTap: (){
                      Navigator.of(context).pop();
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset(ppLogoWhiteVerPng, height: 180, width:190),],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Existing password (Code sent to e-mail.)", style: GoogleFonts.figtree(textStyle: const TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.bold)),)],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 350, left: 20, right: 20),
                  child: Container(
                    width: double.infinity,
                    height: 280,
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
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  TextField(
                                    style: GoogleFonts.figtree(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),                 
                                    controller: ctrlExtPwd,
                                    focusNode: textExtPwdFocusNode,
                                    obscureText: passwordExtVisible,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1, color: borderColorExtPwd,
                                            
                                          )
                                      ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1, color: borderColorExtPwd,
                                          ),
                                        ) ,
                                      filled: true,
                                      labelText: 'Enter existing password',                                  
                                      labelStyle: GoogleFonts.figtree(textStyle: TextStyle(color: textExtPwdFocusNode.hasFocus ? const Color.fromARGB(255, 0, 93, 169) : Colors.grey[400], fontSize: 20)),
                                      suffixIcon: IconButton(
                                      icon: Icon(passwordExtVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(
                                          () {
                                            passwordExtVisible = !passwordExtVisible;
                                          },
                                        );
                                      },
                                    ),
                                    ),        
                                  ),

                              TextField(
                                style: GoogleFonts.figtree(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),                 
                                controller: ctrlNewPwd,
                                focusNode: textNewPwdFocusNode,
                                obscureText: passwordNewVisible,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1, color: borderColorNewPwd,                          
                                      )
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1, color: borderColorNewPwd,
                                      ),
                                    ),
                                  labelText: 'New password',                    
                                  labelStyle: GoogleFonts.figtree(textStyle: TextStyle(color: textNewPwdFocusNode.hasFocus ? const Color.fromARGB(255, 0, 93, 169) : Colors.grey[400], fontSize: 20)),
                                  filled: true,
                                  suffixIcon: IconButton(
                                  icon: Icon(passwordNewVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordNewVisible = !passwordNewVisible;
                                      },
                                    );
                                  },
                                ),
                                ),        
                              ),

                              TextField(
                                style: GoogleFonts.figtree(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),                 
                                controller: ctrlConfNewPwd,
                                focusNode: textConfNewPwdFocusNode,
                                obscureText: passwordCfmVisible,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1, color: borderColorConfPwd,
                                        
                                      )
                                  ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1, color: borderColorConfPwd,
                                      ),
                                    ) ,                              
                                  labelText: 'Confirm password',                    
                                  labelStyle: GoogleFonts.figtree(textStyle: TextStyle(color: textConfNewPwdFocusNode.hasFocus ? const Color.fromARGB(255, 0, 93, 169) : Colors.grey[400], fontSize: 20)),
                                  filled: true,
                                  suffixIcon: IconButton(
                                  icon: Icon(passwordCfmVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordCfmVisible = !passwordCfmVisible;
                                      },
                                    );
                                  },
                                ),
                              ),        
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),                  
                              child: Stack(
                                children: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: buttonColor,                          
                                      fixedSize: const Size(500,48),                          
                                    ),
                                    child: Text('Update Password', style: GoogleFonts.figtree(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: white)),),                        
                                    onPressed: () async {
                                      if(ctrlExtPwd.text.isEmpty && ctrlNewPwd.text.isEmpty && ctrlConfNewPwd.text.isEmpty){
                                        setState(() {
                                          borderColorExtPwd = Colors.red;
                                          borderColorNewPwd = Colors.red;
                                          borderColorConfPwd = Colors.red;
                                        });                            
                                        FocusScope.of(context).requestFocus(textExtPwdFocusNode);
                                      }else if(ctrlExtPwd.text.isNotEmpty && ctrlNewPwd.text.isEmpty && ctrlConfNewPwd.text.isEmpty ){
                                        setState(() {
                                          borderColorExtPwd = transparent;
                                          borderColorNewPwd = Colors.red;
                                          borderColorConfPwd = Colors.red;
                                        });
                                        FocusScope.of(context).requestFocus(textNewPwdFocusNode);  
                                      }else if(ctrlExtPwd.text.isNotEmpty && ctrlNewPwd.text.isNotEmpty && ctrlConfNewPwd.text.isEmpty ){
                                        setState(() {
                                          borderColorExtPwd = transparent;
                                          borderColorNewPwd = transparent;
                                          borderColorConfPwd = Colors.red;
                                        });
                                        FocusScope.of(context).requestFocus(textConfNewPwdFocusNode);  
                                      }else if(ctrlExtPwd.text.isEmpty && ctrlNewPwd.text.isNotEmpty && ctrlConfNewPwd.text.isNotEmpty){
                                        setState(() {
                                          borderColorExtPwd = Colors.red;
                                          borderColorNewPwd = transparent;
                                          borderColorConfPwd = transparent;
                                        });
                                        FocusScope.of(context).requestFocus(textExtPwdFocusNode);
                                      }else if(ctrlExtPwd.text.isEmpty && ctrlNewPwd.text.isEmpty && ctrlConfNewPwd.text.isNotEmpty){
                                        setState(() {
                                          borderColorExtPwd = Colors.red;
                                          borderColorNewPwd = Colors.red;
                                          borderColorConfPwd = transparent;
                                        });
                                        FocusScope.of(context).requestFocus(textExtPwdFocusNode);
                                      }else if(ctrlExtPwd.text.isNotEmpty && ctrlNewPwd.text.isEmpty && ctrlConfNewPwd.text.isNotEmpty){
                                        setState(() {
                                          borderColorExtPwd = transparent;
                                          borderColorNewPwd = Colors.red;
                                          borderColorConfPwd = transparent;
                                        });
                                        FocusScope.of(context).requestFocus(textNewPwdFocusNode);
                                      }else if(ctrlExtPwd.text.isEmpty && ctrlNewPwd.text.isNotEmpty && ctrlConfNewPwd.text.isEmpty){
                                        setState(() {
                                          borderColorExtPwd = Colors.red;
                                          borderColorNewPwd = transparent;
                                          borderColorConfPwd = Colors.red;
                                        });
                                        FocusScope.of(context).requestFocus(textExtPwdFocusNode);
                                      }                          
                                      else if(ctrlExtPwd.text.isNotEmpty && ctrlNewPwd.text.isNotEmpty && ctrlConfNewPwd.text.isNotEmpty){
                                        setState(() {
                                          borderColorExtPwd = transparent;
                                          borderColorNewPwd = transparent;
                                          borderColorConfPwd = transparent;
                                        });
                                        
                                        if(ctrlNewPwd.text.toString() == ctrlConfNewPwd.text.toString()){
                                          await Future.wait([
                                            server.sendRefreshToken(context)
                                          ]).then((List<bool> value) async {
                                            List statList = await server.changePassword(ctrlExtPwd.text, ctrlNewPwd.text, ctrlConfNewPwd.text);
                                            if(statList[0] == true){
                                              // ignore: use_build_context_synchronously
                                              CustomDialog.backToLoginDialog(context, "Your password has been updated");
                                            }else{
                                              // ignore: use_build_context_synchronously
                                              CustomDialog.cancelDialog(context, statList[1].toString()); 
                                            }
                                          });    
                                        }else{
                                          CustomDialog.cancelDialog(context,"New password and confirmation password does not match.");
                                          FocusScope.of(context).requestFocus(textNewPwdFocusNode);
                                        }  
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    )
                  ),
                )
              ]),
          ),
        ],
      ),
    );
  }
}