import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powerpay/util/assetdata.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/pdf.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// import 'package:share/share.dart';
import 'package:share_plus/share_plus.dart';

class Receipt extends StatelessWidget{
  const Receipt({super.key});

  Future<Uint8List> generatePdf(String title) async {
    
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);

    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load(ppLogoGradVerPng);
    final Uint8List byteList = bytes.buffer.asUint8List();
    
    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a6,
            build: (context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Header(text: title, level: 2, textStyle: pw.TextStyle(fontSize: 10, font: ttf)),
                        pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight, height: 50, width: 80)
                      ]
                    ),
                    pw.Divider(borderStyle: pw.BorderStyle.dashed),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(
                          children: [                            
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("STATUS", style: pw.TextStyle(fontSize: 12, font: ttf)),
 
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(vTopupDetails['Status'].toString().toUpperCase() ,style: pw.TextStyle(font: ttf /*,fontSize: 6*/ )),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("AMOUNT" ,style: pw.TextStyle(font: ttf /*fontSize: 6*/)),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text( "RM ${double.parse(vTopupDetails['Amount'].toString()).toStringAsFixed(2)}"  ,style: pw.TextStyle( font: ttf /*,fontSize: 6*/)),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("TYPE" ,style: pw.TextStyle(font: ttf, /*fontSize: 6*/)),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("${vTopupDetails["TrxType"].toString().toUpperCase()} - ${vTopupDetails['Description'].toString().toUpperCase()} " ,style: pw.TextStyle(font: ttf, /*fontSize: 6*/) ),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("DATE/TIME"  ,style: pw.TextStyle(font: ttf, /*fontSize: 6)*/)),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(vTopupDetails['Date'].toString().toUpperCase() ,style: pw.TextStyle(font: ttf, /*fontSize: 6*/)),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("RELOAD NO."  ,style: pw.TextStyle(font: ttf, /*fontSize: 6*/)),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                               pw.Text(vTopupDetails['RefNo'].toString().toUpperCase(), style: pw.TextStyle(font: ttf)),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("REMARK"  ,style: pw.TextStyle( font: ttf, /*fontSize: 6*/)),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                if(vTopupDetails['RefNo2'].toString().toUpperCase() == "NULL") pw.Text(" ", style: pw.TextStyle(font: ttf)), 
                                if(vTopupDetails['RefNo2'].toString().toUpperCase() != "NULL") pw.Text(vTopupDetails['RefNo2'].toString().toUpperCase(), style: pw.TextStyle(font: ttf)),
                              ]
                            )
                        ]),
                      ]
                    )  
                  ]
              );
            }
        ));
        return pdf.save();
  }

  Future<void> sharePdf(Uint8List pdfBytes, String fileName) async {

    try{

      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(pdfBytes);

      if (kDebugMode) {
        print('File path: ${file.path}');
      }

      if(await file.exists()){
        if (kDebugMode) {
          print('File exists');
        }
        final result = await Share.shareXFiles([XFile(file.path)], text: 'Here is your PDF');
        if (kDebugMode) {
          print('Share result: $result');
        }
      } else {
        if (kDebugMode) {
          print('File does not exist');
        }
      }

      await Share.shareXFiles([XFile(file.path)], text: 'Here is your PDF');
      if (kDebugMode) {
        print("File saved successfullu");
      }

    }catch (e) {
      if (kDebugMode) {
        print("Error sharing file: $e");
      }
    }

    

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text("Receipt", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
          onTap: () {
            Navigator.pop(context);
          } ,
        )
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: white,
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("RM ${double.parse(vTopupDetails['Amount'].toString()).toStringAsFixed(2)}", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 30), fontWeight: FontWeight.w600),)),
                    ],
                  ),
                ),
          
                const Padding(
                  padding:  EdgeInsets.only(top: 50),
                  child:  Divider(color: Colors.black26, endIndent: 16, indent: 16),
                ),
          
                ListTile(
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      leading: Text("Status", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500),)),
                      trailing: 
                        FittedBox(
                          fit: BoxFit.fill,
                          child: Column(
                            children: <Widget>[
                              if(vTopupDetails['StatusID'].toString() == "0") Text(vTopupDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600))),
                              if(vTopupDetails['StatusID'].toString() == "1") Text(vTopupDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: const TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w600))),
                              if(vTopupDetails['StatusID'].toString() == "2") Text(vTopupDetails['Status'].toString(), style: GoogleFonts.figtree(textStyle: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600))),
                              
                            ],
                          ),
                        ),
                      ),
                const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text("Type", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                  trailing: 
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Column(
                        children: <Widget>[
                          Text("${vTopupDetails["TrxType"].toString().toUpperCase()} - ${vTopupDetails['Description'].toString().toUpperCase()} ", style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600),)),
                        ],
                      ),
                    ),
                ),
                const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text("Date/Time", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                  trailing: 
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Column(
                        children: <Widget>[
                          Text(vTopupDetails["Date"].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                        ]
                      ),
                    ),
                  ),
                const Divider(color: Colors.black26, endIndent: 16, indent: 16),  
                ListTile(
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text("Remark", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                  trailing: 
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Column(
                        children: <Widget>[
                          Text(vTopupDetails["RefNo"].toString().toUpperCase(), style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ),
                ),
                const Divider(color: Colors.black26, endIndent: 16, indent: 16),
                ListTile(
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text("Ref.ID", style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 15), fontWeight: FontWeight.w500))),
                  trailing: 
                    Text((vTopupDetails["RefNo2"].toString().toUpperCase()=="NULL")?"":vTopupDetails["RefNo2"].toString().toUpperCase() , style: GoogleFonts.figtree(textStyle: TextStyle(color: Colors.black, fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
                ),
                const Divider(color: Colors.black26, endIndent: 16, indent: 16),  
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.share, size: adjustResolution(context, Resolution.normal.index, 16)),      
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: buttonColor,
                    fixedSize: Size(adjustResolution(context, Resolution.container.index, 330),adjustResolution(context, Resolution.container.index, 50)),
                    elevation: 0,                           
                  ),
                  label: Text('SHARE',style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),                        
                  onPressed: () async {    
                                    
                    // Collect your data
                    String title = "RECEIPT";
                    
                    // Generate the PDF
                    Uint8List pdfBytes = await generatePdf(title);

                    // Share the PDF
                    final filename = "Receipt_${vTopupDetails['RefNo'].toString()}_${vTopupDetails['Date'].toString()}.pdf";
                    await sharePdf(pdfBytes, filename);
                                    



                  },
                ),
            ],
          ),
        )
      )
    );
 }
}

// ignore: must_be_immutable
class PdfPreviewPage extends StatelessWidget {
  String? text;
  PdfPreviewPage(this.text, {super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Receipt' , style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600))),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16) ),
          onTap: () {
            Navigator.pop(context);
          } ,
        )
      ),
      body: PdfPreview(
        allowPrinting: false,
        allowSharing: true,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        actionBarTheme: const PdfActionBarTheme(backgroundColor: Colors.blue),
        build: (context) => makePdf(),
      ),
    );
  }
 
  //details to create the pdf
  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load(ppLogoGradVerPng);
    final Uint8List byteList = bytes.buffer.asUint8List();
    
    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a6,
            build: (context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Header(text: text, level: 2, textStyle: const pw.TextStyle(fontSize: 10)),
                        pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight, height: 50, width: 80)
                      ]
                    ),
                    pw.Divider(borderStyle: pw.BorderStyle.dashed),
                    // pw.Paragraph(text: " "),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(
                          children: [                            
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("STATUS", style: const pw.TextStyle(fontSize: 12)),
 
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(vTopupDetails['Status'].toString().toUpperCase() /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("AMOUNT" /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text( "RM ${double.parse(vTopupDetails['Amount'].toString()).toStringAsFixed(2)}" /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("TYPE" /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("${vTopupDetails["TrxType"].toString().toUpperCase()} - ${vTopupDetails['Description'].toString().toUpperCase()} " /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("DATE/TIME" /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(vTopupDetails['Date'].toString().toUpperCase() /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("RELOAD NO." /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                               pw.Text(vTopupDetails['RefNo'].toString().toUpperCase()),
                              ]
                            )
                        ]),
                        pw.TableRow(
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("REMARK" /* ,style: pw.TextStyle(fontSize: 6)*/),
                              ]
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment : pw.MainAxisAlignment.center,
                              children: [
                                if(vTopupDetails['RefNo2'].toString().toUpperCase() == "NULL") pw.Text(" "), 
                                if(vTopupDetails['RefNo2'].toString().toUpperCase() != "NULL") pw.Text(vTopupDetails['RefNo2'].toString().toUpperCase()),
                              ]
                            )
                        ]),
                      ]
                    )  
                  ]
              );
            }
        ));
        return pdf.save();
  }
}




