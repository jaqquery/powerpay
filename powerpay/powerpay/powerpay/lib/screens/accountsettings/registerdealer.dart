import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/screens/splashscreen/splashscreen.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/dialog.dart';

class RegisterDealer extends StatefulWidget{
    const RegisterDealer({super.key});
    @override
    State<RegisterDealer> createState() => _RegisterDealer();
}

class _RegisterDealer extends ResumableState<RegisterDealer> {

  @override
  void onResume() {
    // Implement your code inside here
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode:1)));
  }

  // bool passwordVisible=true;
  TextEditingController ctrlNewDealerNumber = TextEditingController();
  TextEditingController ctrlNewDealerName = TextEditingController();

  FocusNode textNewDealerNumFocusNode = FocusNode();
  FocusNode textNewDealerNameFocusNode = FocusNode();

  FocusNode regDealerFocusNode = FocusNode();
  Color dealerNumBorderColor = Colors.transparent;
  Color dealerNameBorderColor = Colors.transparent;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("New Dealer Registration", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600, color: buttonColor))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) 
      ),
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.white,
            child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
                    child: Padding(
                            padding: EdgeInsets.only(left:adjustResolution(context, Resolution.normal.index, 20), right: adjustResolution(context, Resolution.normal.index, 20)),
                            child:                                   
                              Column (             
                                children: <Widget>[                                       
                                   
                                              const Padding(padding: EdgeInsets.only(top: 10.0)),
                                              
                                              TextField(
                                                style: GoogleFonts.figtree(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                                controller: ctrlNewDealerNumber,
                                                focusNode: textNewDealerNumFocusNode,
                                                decoration: InputDecoration(
                                                  prefixIcon: Image.asset("assets/Settings/Registerdealer/Phone.png", width: 10, height: 10),
                                                  labelStyle: GoogleFonts.figtree(textStyle: TextStyle(color:  Colors.grey[400], fontSize: adjustResolution(context, Resolution.normal.index, 20))),
                                                  fillColor: const Color(0xFFF5F5F5),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                      borderSide: BorderSide(
                                                        width: 1, 
                                                        color: dealerNumBorderColor,                          
                                                      )
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15),  
                                                    borderSide: BorderSide(
                                                        width: 1, color: dealerNumBorderColor,
                                                    ),
                                                  ),
                                                  labelText: 'New Dealer Number',                        
                                                  filled: true,           
                                                  ),
                                                keyboardType: TextInputType.number,        
                                              ),
                                              const Padding(padding: EdgeInsets.only(top: 22.0)),
                                              TextField(
                                                style: GoogleFonts.figtree(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),                 
                                                controller: ctrlNewDealerName,
                                                focusNode: textNewDealerNameFocusNode,                      
                                                decoration: InputDecoration(
                                                  prefixIcon: Image.asset("assets/Settings/Registerdealer/Shop.png", width: adjustResolution(context, Resolution.normal.index, 10), height: adjustResolution(context, Resolution.normal.index, 10)),
                                                  labelText: 'New Dealer Name',
                                                  labelStyle: GoogleFonts.figtree(textStyle: TextStyle(color:  Colors.grey[400], fontSize: adjustResolution(context, Resolution.normal.index, 20))),
                                                  fillColor: const Color(0xFFF5F5F5),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                    borderSide: BorderSide(
                                                      width: 1, color: dealerNameBorderColor,                          
                                                    )
                                                  ),
                                                  enabledBorder: OutlineInputBorder( 
                                                    borderRadius: BorderRadius.circular(15),                       
                                                    borderSide: BorderSide(
                                                      width: 1, color: dealerNameBorderColor,
                                                    ),
                                                  ),                                         
                                                  filled: true,
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
                                                        fixedSize: Size(
                                                                    adjustResolution(context, Resolution.normal.index, 500),
                                                                    adjustResolution(context, Resolution.normal.index, 50)
                                                                  ),
                                                      ),
                                                      child: Text('Register Dealer', style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w600, color: white)),),                     
                                                      onPressed: () async {    
                                                              
                                                        if(ctrlNewDealerNumber.text.isEmpty && ctrlNewDealerName.text.isEmpty){
                                                          setState(() {
                                                            dealerNumBorderColor = Colors.red;
                                                            dealerNameBorderColor = Colors.red;
                                                            FocusScope.of(context).requestFocus(textNewDealerNumFocusNode);                              
                                                          });
                                                        }else if(ctrlNewDealerNumber.text.isNotEmpty && ctrlNewDealerName.text.isEmpty){
                                                          setState(() {
                                                            dealerNumBorderColor = Colors.transparent;
                                                            dealerNameBorderColor = Colors.red;
                                                          });
                                                          FocusScope.of(context).requestFocus(textNewDealerNameFocusNode);
                                                        }else if(ctrlNewDealerNumber.text.isEmpty && ctrlNewDealerName.text.isNotEmpty){
                                                          setState(() {
                                                            dealerNumBorderColor = Colors.red;
                                                            dealerNameBorderColor = Colors.transparent;
                                                          });
                                                          FocusScope.of(context).requestFocus(textNewDealerNumFocusNode);
                                                        }else{
                                                          try{
                                                            setState(() {
                                                              dealerNumBorderColor = Colors.transparent;
                                                              dealerNameBorderColor = Colors.transparent;
                                                            });
                                                              
                                                            hud.show();
                                                            await Future.wait([
                                                              server.sendRefreshToken(context)
                                                            ]).then((List<bool> value) async {
                                                              bool checkNumber = await server.checkPhoneExist(ctrlNewDealerNumber.text);                                                               
                                                              if(checkNumber){
                                                                hud.hide();
                                                                // ignore: use_build_context_synchronously
                                                                CustomDialog.cancelDialog(context, "${ctrlNewDealerNumber.text} already registered");
                                                              }else{                                                                
                                                                bool regStatus = await server.registerDealer(ctrlNewDealerNumber.text, ctrlNewDealerName.text);                                                                
                                                                hud.hide();
                                                                if (regStatus == true){
                                                                  // ignore: use_build_context_synchronously
                                                                  CustomDialog.okDialog(context, "${ctrlNewDealerNumber.text} is successfully registered.");
                                                                }else if(regStatus == false){
                                                                  // ignore: use_build_context_synchronously
                                                                  CustomDialog.cancelDialog(context, "${ctrlNewDealerNumber.text}: registration error.");  
                                                                }                                                                
                                                              }
                                                              hud.hide();
                                                            });    
                                                          }catch (err){
                                                            throw("$err"); 
                                                          }
                                                        }
                                                        
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),                          
                                            ],
                                          ),
                    ),  
            ),
          );
        }
      ),
    );
   
  }
}
