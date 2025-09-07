import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/screens/splashscreen/splashscreen.dart';
import 'package:powerpay/util/assetdata.dart';

// ignore: must_be_immutable
class CommissionRate extends StatefulWidget {
  
  const CommissionRate({super.key});
 
  @override
  State<CommissionRate> createState() => _CommissionRate();
}

class _CommissionRate extends ResumableState<CommissionRate> {  
  @override
  void onResume() {
    // Implement your code inside here
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode:1)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commission Rate", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600, color: buttonColor))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16),),
          onTap: () {
            Navigator.pop(context);
          },
        ) 
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF5F5F5),
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: telcos.length,
              itemBuilder: ( context, index){                
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                                  backgroundImage: AssetImage((imageMap[telcos[getIndexOf(index)]].toString())),
                                  radius: adjustResolution(context, Resolution.normal.index, 28),
                      ),
                      title: Text("\t\t\t\t\t\t\t\t\t${telcos[index]}", style: GoogleFonts.figtree(textStyle:  TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20), fontWeight: FontWeight.w600))),
                      trailing: Text( "${commissionRates[index]} %" , style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 20), fontWeight: FontWeight.w600))),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                  ],
                );
              })
          ],
        ), 
      ),
    );
  }
}



