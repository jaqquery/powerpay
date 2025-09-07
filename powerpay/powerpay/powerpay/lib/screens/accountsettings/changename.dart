import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/dialog.dart';
 
const Color defaultThemeBlue = Color.fromARGB(255, 0, 93, 169);

// ignore: must_be_immutable
class ChangeName extends StatefulWidget {
  bool inactive;
  bool hidden;
  bool paused;
  bool detached;

  Color borderColor;
  ChangeName({
    super.key, 
    this.borderColor = Colors.transparent,
    this.inactive = false,
    this.hidden = false,
    this.paused = false,
    this.detached = false,
  });
 
  @override
  State<ChangeName> createState() => _ChangeName();
}

class _ChangeName extends ResumableState<ChangeName> {
  
  // @override
  // void onResume() {
  //   // Implement your code inside here
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode:1)));
  // }

    @override
  void initState(){
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch(state){
  //     case AppLifecycleState.resumed:
  //       // Sequence: 
  //       // 1. Power button pressed: -inactive,hidden.paused,hidden,inactive 
  //       // 2. Overview pressed: - inactive
  //       // 3. Home pressed: - inactive,hidden,paused,hidden, inactive
  //       // 4. Detached: inactive, hidden, paused, detached

  //       if((widget.inactive == true && widget.hidden == true && widget.paused == true) || (widget.inactive == true && widget.hidden == false && widget.paused == false && widget.detached == false)){
  //        //Do Nothing 
          
  //       }else if(widget.inactive == true || widget.hidden == true || widget.paused == true || widget.detached == true){
  //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode:1)));
  //       }
  //       widget.inactive = false; 
  //       widget.hidden = false;
  //       widget.paused = false;
  //       widget.detached = false;

  //       break;
  //     case AppLifecycleState.inactive:
  //       print("inactive");
  //       widget.inactive = true;
  //       break;
  //     case AppLifecycleState.hidden:
  //       print("hidden");
  //       widget.hidden = true;
  //       break;
  //     case AppLifecycleState.paused:
  //       print("paused");
  //       widget.paused = true;
  //       break;
  //     case AppLifecycleState.detached:
  //       print("detached");
  //       widget.detached = true;
  //       break;  
  //   }
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool passwordVisible = true;

  FocusNode newNameFocusNode = FocusNode();
  TextEditingController ctrlChangeName = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    return PopScope(
      canPop: false,
      onPopInvoked: ((didPop) {
        if(didPop){
          return;
        }
        
        Navigator.of(context).pop(personname);

      }),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Name", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600, color: buttonColor))),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
            onTap: () {
              setState(() {
                Navigator.of(context).pop(personname);
              });
            } ,
          ) 
        ),
        body: Builder(
          builder: (context) {
            return Column(
              children: [
                
                Padding(
                  padding: EdgeInsets.only(left: adjustResolution(context, Resolution.normal.index, 20), right: adjustResolution(context, Resolution.normal.index, 20), top: adjustResolution(context, Resolution.normal.index, 20)),
                  child: Column(
                          children: [
                            TextField(
                              style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 20) )),
                              controller: ctrlChangeName,
                              focusNode: newNameFocusNode,                              
                              decoration: InputDecoration(
                                prefixIcon: Image.asset("assets/Settings/Registerdealer/Shop.png", width: adjustResolution(context, Resolution.normal.index, 10), height: adjustResolution(context, Resolution.normal.index, 10)),
                                fillColor: const Color(0xFFF5F5F5),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 1, color: widget.borderColor,
                                  )
                              ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 1, color: widget.borderColor,
                                  ),
                                ) ,
                              hintText: personname.toString(),
                              hintStyle: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.grey, fontSize: adjustResolution(context, Resolution.normal.index, 20))),                    
                              filled: true,
                              // labelStyle: GoogleFonts.figtree(textStyle: const TextStyle(color: Color(0xFF3D3D3D))),
                            ),        
                          ),
                          const SizedBox(height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),                  
                            child: Stack(
                              children: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: buttonColor,
                                    foregroundColor: Colors.white,
                                    fixedSize: Size(adjustResolution(context, Resolution.normal.index, 500), adjustResolution(context, Resolution.normal.index, 50)),
                                  ),
                                  child: Text('Update Name', style: GoogleFonts.figtree(textStyle: TextStyle(color:Colors.white, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),                        
                                  onPressed: ()async{                                                                        
                                    if(ctrlChangeName.text.isNotEmpty){
                                      hud.show();
                                      await Future.wait([
                                        server.sendRefreshToken(context)
                                      ]).then((List<bool> value) async {
                                        if(await server.changeName(ctrlChangeName.text) == true){
                                          hud.hide();
                                          setState(() {
                                            CustomDialog.okDialog(context, "Your name is now ${ctrlChangeName.text}");
                                            widget.borderColor = Colors.transparent;
                                            personname = ctrlChangeName.text;
                                          }); 
                                        }else{
                                          hud.hide(); 
                                          // ignore: use_build_context_synchronously
                                          CustomDialog.cancelDialog(context, "Unable to update your name");
                                        }
                                      });    
                                      hud.hide();                                       
                                    }else{
                                      setState(() {
                                        widget.borderColor = Colors.red;
                                        CustomDialog.cancelDialog(context, "Please enter your new name.");
                                        FocusScope.of(context).requestFocus(newNameFocusNode);
                                      });     
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                ),
              ],
            );
          }
        )
      ),
    );

  }
}