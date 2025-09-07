import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:powerpay/util/dialog.dart';

// ignore: must_be_immutable
class KYC extends StatefulWidget {
  
  const KYC({super.key});
 
  @override
  State<KYC> createState() => _KYC();
}

class _KYC extends State<KYC> {
  
  File ? _selectedFrontIcImage;
  File ? _selectedBackIcImage;
  File ? _selectedSelfieIcImage;

  XFile? returnedImage;

  @override
void initState() {
  super.initState();
}

  @override
  void dispose() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    super.dispose();  
  }

  Future _pickImage(int mode) async{
    
    await showDialog(
      context: context,      
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.photo_camera, color: Colors.white, size: adjustResolution(context, Resolution.normal.index, 20)),
              label: Text("Camera",style: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20),color: Colors.white),),
              style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
              onPressed: () async {
                returnedImage = await ImagePicker().pickImage(source:ImageSource.camera);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(true);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon:   Icon(Icons.photo, color: Colors.white, size: adjustResolution(context, Resolution.normal.index, 20)),
              label:  Text("Gallery",style: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20),color: Colors.white),),
              style:  ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
              onPressed: () async {
                returnedImage = await ImagePicker().pickImage(source:ImageSource.gallery);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(false);
              },
            ),
          ],
        ),
      ),
    );
    
    //Mode
    //0 : Front IC
    //1 : Back IC
    //2 : Selfie with IC

    if(returnedImage == null) return;
        
    setState(() {
      switch(mode){
        case 0:
          _selectedFrontIcImage = File(returnedImage!.path);
          break;
        case 1:
          _selectedBackIcImage = File(returnedImage!.path);
          break;
        case 2:
          _selectedSelfieIcImage = File(returnedImage!.path);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

  return Scaffold(
      appBar: AppBar(
        title: Text("KYC", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: const Color(0xFF3D3D3D), size: adjustResolution(context, Resolution.normal.index, 16) ),
          onTap: () {
            Navigator.pop(context);
          } ,
        )
      ),
      body: Container(
          color: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [              
                  Column(
                    children: [                          
                      Row(children: [
                        Image.asset("assets/Kyc/KYC_Verf.png", width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 20), color: _selectedFrontIcImage == null ? const Color(0xFFC1C1C1): Colors.blue)
                      ]),
                      const SizedBox(height: 10),  
                      Row(children: [
                        Image.asset("assets/Kyc/KYC_Line.png", color: const Color(0xFFBDBDBD), width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 60) )
                      ]),
                    ]
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Container(
                          width: adjustResolution(context, Resolution.normal.index, 340),
                          height: adjustResolution(context, Resolution.normal.index, 115),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4, left: 10),
                            child: Row(
                              
                              children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("Upload Front IC", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 15), color: const Color(0xFF333333))),),
                                  ),
                                  const SizedBox(height: 6),
                                  Text("File type: JPG, PNG      ", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: adjustResolution(context, Resolution.normal.index, 10), color: const Color(0xFF7C7C7C)))), 
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: adjustResolution(context, Resolution.normal.index, 12), left: adjustResolution(context, Resolution.normal.index, 64)),
                                    child: InkWell(
                                      child: Container(
                                        width: adjustResolution(context, Resolution.normal.index, 135),
                                        height: adjustResolution(context, Resolution.normal.index, 80),
                                        color: const Color(0xFFF5F5F5),
                                        child: _selectedFrontIcImage == null ?  Image.asset("assets/Kyc/KYC_Camera.png"): Image.file(_selectedFrontIcImage!, fit: BoxFit.fill),
                                      ),
                                      onTap: (){
                                        _pickImage(0);
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],),
                          ),
                        )
                      ],
                    ),
                  )
              ],),
      
              const SizedBox(height: 12),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [              
                    Column(
                      children: [                          
                        Row(children: [
                          Image.asset("assets/Kyc/KYC_Verf.png", width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 20), color: _selectedBackIcImage == null ? const Color(0xFFC1C1C1): Colors.blue)
                        ]),
                        const SizedBox(height: 10),  
                        Row(children: [
                          Image.asset("assets/Kyc/KYC_Line.png", color: const Color(0xFFBDBDBD), width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 60),)
                        ]),
                      ]
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Container(
                            width: adjustResolution(context, Resolution.normal.index, 335),
                            height: adjustResolution(context, Resolution.normal.index, 109),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4, left: 10),
                              child: Row(
                                
                                children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text("Upload Back IC", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 15), color: const Color(0xFF333333))),),
                                    ),
                                    const SizedBox(height: 6),
                                    Text("File type: JPG, PNG      ", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: adjustResolution(context, Resolution.normal.index, 10), color: const Color(0xFF7C7C7C)))), 
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: adjustResolution(context, Resolution.normal.index, 12), left: adjustResolution(context, Resolution.normal.index, 64)),
                                      child: InkWell(
                                        child: Container(
                                          width: adjustResolution(context, Resolution.normal.index, 135),
                                          height: adjustResolution(context, Resolution.normal.index, 80),
                                          color: const Color(0xFFF5F5F5),
                                          child: _selectedBackIcImage == null ?  Image.asset("assets/Kyc/KYC_Camera.png"): Image.file(_selectedBackIcImage!, fit: BoxFit.fill),
                                        ),
                                        onTap: (){
                                          _pickImage(1);
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ],),
                            ),
                          )
                        ],
                      ),
                    )
                ],),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [              
                    Column(
                      children: [                          
                        Row(children: [
                          Image.asset("assets/Kyc/KYC_Verf.png", width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 20), color: _selectedSelfieIcImage == null ? const Color(0xFFC1C1C1): Colors.blue)
                        ]),
                        const SizedBox(height: 10),  
                        Row(children: [
                          Image.asset("assets/Kyc/KYC_Line.png", color: const Color(0xFFBDBDBD), width: adjustResolution(context, Resolution.normal.index, 20), height: adjustResolution(context, Resolution.normal.index, 60))
                        ]),
                      ]
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Container(
                            width: adjustResolution(context, Resolution.normal.index, 335),
                            height: adjustResolution(context, Resolution.normal.index, 109),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4, left: 10),
                              child: Row(
                                
                                children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text("Selfie With IC   ", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: adjustResolution(context, Resolution.normal.index, 15), color: const Color(0xFF333333))),),
                                    ),
                                    const SizedBox(height: 6),
                                    Text("File type: JPG, PNG      ", style: GoogleFonts.figtree(textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: adjustResolution(context, Resolution.normal.index, 10), color: const Color(0xFF7C7C7C)))), 
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: adjustResolution(context, Resolution.normal.index, 12), left: adjustResolution(context, Resolution.normal.index, 64)),
                                      child: InkWell(
                                        child: Container(
                                          width: adjustResolution(context, Resolution.normal.index, 135),
                                          height: adjustResolution(context, Resolution.normal.index, 80),
                                          color: const Color(0xFFF5F5F5),
                                          child: _selectedSelfieIcImage == null ?  Image.asset("assets/Kyc/KYC_Camera.png"): Image.file(_selectedSelfieIcImage!, fit: BoxFit.fill),
                                        ),
                                        onTap: (){
                                          _pickImage(2);
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ],),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
              const SizedBox(height: 12),
              
              TextButton(                                
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF03033C),
                  foregroundColor: Colors.white,
                  // padding: const EdgeInsets.all(16.0),
                  fixedSize: Size(adjustResolution(context, Resolution.normal.index, 360), adjustResolution(context, Resolution.normal.index, 44)),                           
                ),
                child: Text('SUBMIT KYC',style:TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20))),                        
                onPressed: () async {
                  if (_selectedFrontIcImage == null){
                    CustomDialog.cancelDialog(context, "Missing front IC image."); 
                  } else if (_selectedBackIcImage == null){
                    CustomDialog.cancelDialog(context, "Missing back IC image."); 
                  } else if (_selectedSelfieIcImage == null){
                    CustomDialog.cancelDialog(context, "Missing selfie with IC image.");
                  }else{
                    //Submit KYC
                    hud.show();
                    await Future.wait([
                      server.sendRefreshToken(context)
                    ]).then((List<bool> value) async {
                      bool status = await server.userVerification(_selectedFrontIcImage!.path, _selectedBackIcImage!.path, _selectedSelfieIcImage!.path);
                      hud.hide();
                      if(status == true){                        
                        // ignore: use_build_context_synchronously
                        if(lstUsrVerfResponse[0].toString().toLowerCase() == "success" ) {
                          // ignore: use_build_context_synchronously
                          CustomDialog.okDialog(context, "KYC has successfully submitted.");
                        }else{
                          // ignore: use_build_context_synchronously
                          CustomDialog.okDialog(context, "Unsuccessful KYC Submission. Please try again later.");
                        }           
                      }else{
                        // ignore: use_build_context_synchronously
                        CustomDialog.okDialog(context, "Error connecting to host.");
                      }
                    });   
                  }
                },
              ),
            ],
          )
        )
    );
  } 
}