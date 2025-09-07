// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:powerpay/screens/logins/login.dart';
import 'package:powerpay/util/assetdata.dart';

class CustomDialog{

  //new personal custom dialog
  static Future<void> okDialog(BuildContext context, String descripstions){
    return showDialog(
      context: context, 
      builder: (context){
        return Theme(
          data: ThemeData(
            useMaterial3: false,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  descripstions,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.figtree(
                    textStyle: TextStyle(
                        fontSize: adjustResolution(
                          context, Resolution.normal.index, 18
                        ),
                    ),
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: const Color(0xFF03033C),
                    foregroundColor: Colors.white
                  ),
                  child: const Text('  OK  '),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  static Future<void> exitDialog(BuildContext context, String descriptions){
    return showDialog(
      context: context, 
      builder: (context){
        return Theme(
          data: ThemeData(
            useMaterial3: false,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    descriptions,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      textStyle: TextStyle(
                          fontSize: adjustResolution(
                            context, Resolution.normal.index, 18
                          ),
                      ),
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    ElevatedButton(
                    onPressed: () async {
                      hud.show();
                      await Future.wait([
                        server.sendRefreshToken(context)
                      ]).then((List<bool> value) async {                          
                        await Future.wait([
                          server.sendLogout(),
                          server.clearData()
                        ]).then((List<dynamic> value) async {
                            hud.hide(); 
                        });
                      });
                      
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginRunApp()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: const Color(0xFF03033C),
                      foregroundColor: Colors.white
                    ),
                    child: const Text('      OK      '),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: const Color(0xFF03033C),
                      foregroundColor: Colors.white
                    ),
                    child: const Text('CANCEL'),
                  ),
                  ],)
                  
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  
  static Future<void> cancelDialog(BuildContext context, String descripstions){
    return showDialog(
      context: context, 
      builder: (context){
        return Theme(
          data: ThemeData(
            useMaterial3: false,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  descripstions,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.figtree(
                    textStyle: TextStyle(
                        fontSize: adjustResolution(
                          context, Resolution.normal.index, 18
                        ),
                    ),
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: const Color(0xFF03033C),
                    foregroundColor: Colors.white
                  ),
                  child: const Text('CANCEL'),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  static Future<void> backToLoginDialog(BuildContext context, String descripstions){
    return showDialog(
      context: context, 
      builder: (context){
        return Theme(
          data: ThemeData(
            useMaterial3: false,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  descripstions,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.figtree(
                    textStyle: TextStyle(
                        fontSize: adjustResolution(
                          context, Resolution.normal.index, 18
                        ),
                    ),
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    hud.show();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginRunApp()));
                    hud.hide();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: const Color(0xFF03033C),
                    foregroundColor: Colors.white
                  ),
                  child: const Text('    OK    '),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  static Future<void> expiredDialog(BuildContext context, String descripstions){
    return showDialog(
      context: context, 
      builder: (context){
        return Theme(
          data: ThemeData(
            useMaterial3: false,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  descripstions,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.figtree(
                    textStyle: TextStyle(
                        fontSize: adjustResolution(
                          context, Resolution.normal.index, 18
                        ),
                    ),
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    hud.show();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginRunApp()));
                    hud.hide();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: const Color(0xFF03033C),
                    foregroundColor: Colors.white
                  ),
                  child: const Text('    OK    '),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  static Future<void> permissionDialog(BuildContext context, String descriptions){
    return showDialog(
      context: context, 
      builder: (context){
        return Theme(
          data: ThemeData(
            useMaterial3: false,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    descriptions,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      textStyle: TextStyle(
                          fontSize: adjustResolution(
                            context, Resolution.normal.index, 18
                          ),
                      ),
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    ElevatedButton(
                    onPressed: () async {
                      hud.show();
                      await openAppSettings();
                      hud.hide();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: const Color(0xFF03033C),
                      foregroundColor: Colors.white
                    ),
                    child: const Text('      OK      '),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: const Color(0xFF03033C),
                      foregroundColor: Colors.white
                    ),
                    child: const Text('CANCEL'),
                  ),
                  ],)
                  
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  static Future<void> hostUnreachable(BuildContext context, String descripstions){
    return showDialog(
      context: context, 
      builder: (context){
        return Theme(
          data: ThemeData(
            useMaterial3: false,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  descripstions,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.figtree(
                    textStyle: TextStyle(
                        fontSize: adjustResolution(
                          context, Resolution.normal.index, 18
                        ),
                    ),
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    hud.show();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginRunApp()));
                    hud.hide();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: const Color(0xFF03033C),
                    foregroundColor: Colors.white
                  ),
                  child: const Text('    OK    '),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}