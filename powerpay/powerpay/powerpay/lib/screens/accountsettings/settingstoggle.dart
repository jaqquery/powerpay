import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:powerpay/screens/splashscreen/splashscreen.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/dialog.dart';

class SettingsToggle extends StatefulWidget {
  const SettingsToggle({super.key});
 
  @override
  State<SettingsToggle> createState() => _SettingsToggle();
}

class _SettingsToggle extends State<SettingsToggle> {
  
  getToggletInit() async{
    var status = await Permission.notification.status;
    if(status.isDenied || status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      CustomDialog.permissionDialog(context, "Notification is disabled, do you want to enable it?");
    }else{
      if (kDebugMode) {
        print("Notification permission granted");
      }
    }

    await Future.wait([
      // ignore: use_build_context_synchronously
      server.sendRefreshToken(context),
    ]).then((List<dynamic> value) async {
      await server.getSetting(context);
    });
  }

  void onResume() {
    // Implement your code inside here
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode:1)));
  }

  @override
  void initState(){
    super.initState();
    getToggletInit();  
  }

  requestNotificationPermissions() async {
   
   final PermissionStatus status = await Permission.notification.request();
   if (status.isGranted) {
      // Notification permissions granted
   } else if (status.isDenied) {
      // Notification permissions denied
   } else if (status.isPermanentlyDenied) {
      // Notification permissions permanently denied, open app settings
      await openAppSettings();
   }

  }

  Future<void> updateToggle(bool latestStat) async {

    setState(() {         
      nStat = latestStat;
    });

    await Future.wait([
      server.writeSecureData(server.notiFication, (latestStat==true)? "1":"0"),
      // ignore: use_build_context_synchronously
      server.sendRefreshToken(context),                                  
    ]).then((List<dynamic> lstValues) async {
      await server.updateNotification(latestStat);
    });

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
          onTap: () {
            Navigator.pop(context);
          } ,
        )
      ),
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Column(
                children: [
                  SizedBox(height: adjustResolution(context, Resolution.normal.index, 24)),                  
                  Padding(
                    padding: EdgeInsets.only(left: adjustResolution(context, Resolution.normal.index, 37), right : adjustResolution(context, Resolution.normal.index, 36)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Notifications", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 16)))),
                        SizedBox(
                          height: adjustResolution(context, Resolution.normal.index, 36),
                          width: adjustResolution(context, Resolution.normal.index, 50),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Switch (
                              value: nStat,      
                              activeTrackColor: buttonColor,
                              onChanged: (bool value) async {
                                await updateToggle(value);
                              },
                            ),
                          ),
                        ),                                  
                      ],
                    ),                              
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: adjustResolution(context, Resolution.normal.index, 37), right : adjustResolution(context, Resolution.normal.index, 26)),
                    child: Divider(thickness: 1, color: Colors.grey.shade300,),
                  ),
                ]),
      )
    ); 
  }
}