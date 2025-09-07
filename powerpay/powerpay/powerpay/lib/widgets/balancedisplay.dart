import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerpay/util/assetdata.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

TextEditingController balanceAmtController = TextEditingController();

// ignore: must_be_immutable
class BalanceDisp extends StatefulWidget{
  bool visible;
  BalanceDisp({super.key, required this.visible});

  @override
  State<BalanceDisp> createState() => _BalanceDisp();
}

class _BalanceDisp extends State<BalanceDisp> {

  

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
                Padding(
                    padding: const EdgeInsets.only(top: 86, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: widget.visible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Available Balance',
                                style: GoogleFonts.figtree(textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: adjustResolution(context, Resolution.normal.index, 12),
                                    color: Colors.white,
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.visible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [  
                              Text(
                                  "RM ${NumberFormat.currency(customPattern:'#,##0.00 \u00a4', decimalDigits:2, symbol: "").format(double.parse(getLatestBalance)) }",
                                  style: GoogleFonts.figtree( textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: adjustResolution(context, Resolution.normal.index, 35),
                                    color: Colors.white,
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
      ],
    );
  }
}