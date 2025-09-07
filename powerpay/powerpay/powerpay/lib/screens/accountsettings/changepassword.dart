import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/dialog.dart';

class ChangePassword extends StatefulWidget{
    
    const ChangePassword({
      super.key,
    });

    @override
    State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
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
      appBar: AppBar(
        title: Text("Change Password", style: GoogleFonts.figtree(textStyle: const TextStyle( fontSize: 16, fontWeight: FontWeight.w600))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
          onTap: () {
            Navigator.pop(context);
          } ,
        )
      ), 
      body:       
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Builder(
            builder: (context) {
              return Container(
                  color: Colors.white,
                  child: 
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: adjustResolution(context, Resolution.normal.index, 20), right: adjustResolution(context, Resolution.normal.index, 20)),
                      child: Column(
                              children: [
                                  TextField(
                                    
                                    style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20), fontWeight: FontWeight.w600)),                 
                                    controller: ctrlExtPwd,
                                    focusNode: textExtPwdFocusNode,
                                    obscureText: passwordExtVisible,
                                    decoration: InputDecoration(
                                      prefixIcon: Image.asset("assets/Settings/Registerdealer/Key.png", height: adjustResolution(context, Resolution.normal.index, 20), width: adjustResolution(context, Resolution.normal.index, 20)),
                                      fillColor: const Color(0xFFF5F5F5),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1, color: borderColorExtPwd,
                                          
                                        )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          width: 1, color: borderColorExtPwd,
                                        ),
                                      ) ,
                                      filled: true,
                                      labelText: 'Enter existing password',                                  
                                      labelStyle: GoogleFonts.figtree(textStyle: TextStyle(color: textExtPwdFocusNode.hasFocus ? const Color.fromARGB(255, 0, 93, 169) : Colors.grey[400], fontSize: adjustResolution(context, Resolution.normal.index, 20))),
                                      suffixIcon: IconButton(
                                      icon: Image.asset(passwordExtVisible
                                          ? "assets/Settings/Closeeye.png"
                                          : "assets/Settings/Openeye.png", 
                                          width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 20)),
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
                              const SizedBox(height: 22),
                              TextField(
                                style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20), fontWeight: FontWeight.w600)),                 
                                controller: ctrlNewPwd,
                                focusNode: textNewPwdFocusNode,
                                obscureText: passwordNewVisible,
                                decoration: InputDecoration(
                                              prefixIcon: Image.asset("assets/Settings/ChangePassword.png", width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 20)),
                                              fillColor: const Color(0xFFF5F5F5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                  width: 1, color: borderColorNewPwd,                          
                                                )
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                  width: 1, color: borderColorNewPwd,
                                                ),
                                              ),
                                              labelText: 'New password',                    
                                              labelStyle: GoogleFonts.figtree(textStyle: TextStyle(color: textNewPwdFocusNode.hasFocus ? const Color.fromARGB(255, 0, 93, 169) : Colors.grey[400], fontSize: adjustResolution(context, Resolution.normal.index, 20))),
                                              filled: true,
                                              suffixIcon: IconButton(
                                              icon: Image.asset(passwordNewVisible
                                                  ? "assets/Settings/Closeeye.png"
                                                  : "assets/Settings/Openeye.png",
                                                  width: adjustResolution(context, Resolution.normal.index, 20),
                                                  height: adjustResolution(context, Resolution.normal.index, 20)),
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
                              const SizedBox(height: 22),
                              TextField(
                                style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20), fontWeight: FontWeight.w600)),                 
                                controller: ctrlConfNewPwd,
                                focusNode: textConfNewPwdFocusNode,
                                obscureText: passwordCfmVisible,
                                  decoration: InputDecoration(
                                    prefixIcon: Image.asset("assets/Settings/ChangePassword.png", width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 20)),
                                    fillColor: const Color(0xFFF5F5F5),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                                    width: 1, color: borderColorConfPwd,                                                        
                                      )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        width: 1, color: borderColorConfPwd,
                                      ),
                                    ) ,                              
                                    labelText: 'Confirm password',                    
                                    labelStyle: GoogleFonts.figtree(textStyle: TextStyle(color: textConfNewPwdFocusNode.hasFocus ? const Color.fromARGB(255, 0, 93, 169) : Colors.grey[400], fontSize: adjustResolution(context, Resolution.normal.index, 20))),
                                    filled: true,
                                    suffixIcon: IconButton(
                                    icon: Image.asset(passwordCfmVisible
                                          ? "assets/Settings/Closeeye.png"
                                          : "assets/Settings/Openeye.png",
                                          width: adjustResolution(context, Resolution.normal.index, 20),
                                          height: adjustResolution(context, Resolution.normal.index, 20)),
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
                             
                            const SizedBox(height: 34),
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
                                          
                                          hud.show();
                                          await Future.wait([
                                            server.sendRefreshToken(context)
                                          ]).then((List<bool> value) async {
                                            List statList = await server.changePassword(ctrlExtPwd.text, ctrlNewPwd.text, ctrlConfNewPwd.text);
                                            hud.hide();
                                            if(statList[0] == true){
                                              // ignore: use_build_context_synchronously
                                              CustomDialog.okDialog(context, "Your password has been updated");
                                            }else{
                                              // ignore: use_build_context_synchronously
                                              CustomDialog.cancelDialog(context, statList[1].toString()); 
                                            }
                                          });                                          
                                        }else{
                                          hud.hide();
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
                );
            }
          ),
        
            )
          ],
          ),
    );
  }
}