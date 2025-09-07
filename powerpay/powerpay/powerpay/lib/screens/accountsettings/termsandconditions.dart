import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/screens/splashscreen/splashscreen.dart';
import 'package:powerpay/util/assetdata.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

 @override
  State<TermsCondition> createState() => _TermsCondition();
}

class _TermsCondition extends ResumableState<TermsCondition> {

   @override
  void onResume() {
    // Implement your code inside here
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode: 1)));
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
        title: Text("Terms and Conditions", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600, color: buttonColor))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: buttonColor, size: adjustResolution(context, Resolution.normal.index, 16)),
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
              SliverToBoxAdapter(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: 
                      Text(
'''

1. ENTIRE AGREEMENT 

1.1 These Terms constitute the entire agreement between the parties hereto with respect to the matters dealt with herein. The documents incorporated into these Terms by reference constitute the full and entire understanding and agreement among the parties and no party shall be liable or bound to any other party in any manner by any warranties, representations, or covenants, except as specifically set forth herein or therein. In the event of any inconsistency between these Terms and the specific terms that apply to any products or services provided by EBRIC PTE LTD (Company No. 202016237H) (the “Company”) from time to time, the specific terms shall prevail over these Terms. 

Annex 1: Definitions  

In this Agreement, the following words and expressions shall, where not inconsistent with the context, have the following meanings respectively: 

“Designated Web Address” means https://www.powerpay.my/.  

“Dispute” means any dispute between the parties arising out of or in relation to these Terms.  

“Excluded Persons” means a person from an Excluded Jurisdiction. 

INTRODUCTION 

2.1 These terms of service (these “Terms”) constitute a legally binding agreement between the Company and you. These Terms govern your access and use of the website products or services provided by either the Company or through its subsidiary, holding company or associated company, on the websites and/or apps managed by the Company (“Marketplace”). 

2.2 Throughout these Terms, any reference to “We”, “Our” or “Us” shall mean the Company and include any of its employees, subsidiaries, related companies, agents and/or representatives, meanwhile, any reference to “You” shall refer to all Users of the Marketplace. 

2.3 Your use of the Marketplace is conditioned upon your acceptance of these Terms without modification. By accessing and/or using the Marketplace, you are deemed to have read and understood these Terms, and you further agree to be bound by these Terms, including without limitation, additional terms and conditions incorporated by reference in these Terms as may be updated from time to time, applicable to any of our services. All such additional terms shall have the same binding effects as these Terms. 

2.4 In the event that you do not agree to these Terms, you must immediately discontinue your use of the Marketplace. If you are using the Marketplace on behalf of an organisation, you are deemed to have read, understood and agreed to be bound by these Terms for and on behalf of that organisation and you shall represent and warrant that you have the authority to bind that organisation to these Terms (in which event, "You" and "Your" will refer to such organisation). If your organisation has a separate contract in effect with us, the terms and conditions of such contract will govern your use of the Marketplace. 

3. ACCOUNT REGISTRATION  

3.1 You are required to register an account on the Marketplace in order to use and have full access to the Marketplace. You agree to:  
    (a) provide certain information about yourself, including but not limited to, your name, email address and password, as prompted to do so during the registration process or thereafter by the Marketplace; and 
    (b) maintain and update this information as required to keep it true, accurate and complete.  

3.2 We may request further information from you for the purposes of identity verification and detection of money laundering, terrorist financing, fraud, or any other financial crimes. The information we request may include certain personal information including, but not limited to, your full name, date of birth, national identification number/passport number, telephone number, address, financial and personal tax information. In providing us with your personal information or any other information that may be required, you confirm that all such information is accurate and correct and you agree to keep us updated of any change in any of the information provided by you to us. You agree that your failure to provide any information which may be required by us shall constitute a breach to these Terms, which may result in immediate termination of these Terms.  

3.3 We will provide you, in accordance with your application, a username, password, and an account, which will allow you to access and use the Marketplace. Unless specifically stated otherwise, you must not share your account with anyone else and shall not divulge information relating to your account to any third party.  

3.4 You are solely responsible to your account whereby any act undertaken by means of your account will be deemed an act undertaken by you. The Company reserves the right to disable your account or take any other action that the Company in its sole discretion deems necessary or appropriate in the event that the Company has reason to believe that your use of the Marketplace has violated these Terms. You further agree to immediately notify us of any unauthorized use of your account or any other suspected breach of security known to you, including if you believe that your password and/or account information has been stolen or otherwise compromised. Nevertheless, we shall not be liable for any loss incurred resulting from any party’s use of your account, as may be applicable, either with or without your knowledge.        

3.5 You are forbidden from:  • selecting or using as an account name the name of another person with the intent to impersonate that person; • using as an account name the name subject to any rights of a person other than you without appropriate authorisation; and/or • using as an account name the name that is otherwise offensive, vulgar or obscene.  

3.6 We reserve the right to change your username and password at any time as necessary to maintain normal operation of the Marketplace, to prevent unlawful or improper use of the Marketplace, or to uphold the rights of a third party.  

4. REPRESENTATION AND WARRANTIES  

4.1 You represent and warrant for our benefit that:  • you are not prohibited or restricted from registering an account on our Marketplace for any reason whatsoever; • you have the full capacity, power and authority to execute, deliver, perform and observe these Terms; • your access and/or use of the Marketplace are on your own initiative and you are responsible for compliance with the applicable laws and regulations; • you will not falsify or materially omit any information or provide misleading or inaccurate information as requested by us; and • you will not use the Marketplace for the purpose of concealing or disguising the origin or nature of proceeds of crime or terrorist financing, or to further, any breach of applicable anti-money laundering laws or counter-terrorism financing laws, or to deal with any unlawful assets, property, funds or proceeds.  

4.2 The Company does not make, and hereby disclaims, any representation or warranty in any form whatsoever, including any representation or warranty in relation to: • the information set out on the Whitepaper, the Channels or any other place; • the Marketplace; • the sale and purchase of BRICs; • the BRICs; • the Designated Account; • the Designated Web Address; • the Wallet; and • EBRIC Labuan.  

5. USER REPRESENTATIONS AND WARRANTIES Legal Capacity 

5.1 The User represents and warrants that:  
  (a) the User is not an Excluded Person;  
  (b) the User is of legal age to enter into a binding agreement both in the Company’s and the User’s jurisdiction;  
  (c) the User has the full and unrestricted legal capacity to perform its obligations within these Terms;  
  (d) where the User represents another entity, that the User has the right, power and authorisation to represent that entity to enter into the terms and conditions on behalf of that entity and to legally bind it to these terms and conditions; and  
  (e) if the User is a partnership, corporation, trust or other entity or association (an “Entity”), the User is duly registered, incorporated or formed, validly existing and in good standing under the laws of the jurisdiction of its registration, incorporation or formation and has all requisite power and authority to carry on its business as presently conducted, to execute and deliver this binding contract and to carry out the transactions contemplated within these Terms.  Authorisation; Binding Obligation  5.2 Where the User is an Entity, the execution, delivery and performance of these Terms by the User, the fulfilment of and the compliance with these Terms, and the due consummation of the transactions contemplated within these Terms have been duly and validly authorised by all necessary corporate procedures or other action on the part of the User (none of which actions have been modified or rescinded, and all of which actions are in full force and effect). When executed by the User, these Terms will constitute a valid and binding obligation of the User, enforceable in accordance with its terms, except as may be limited by applicable bankruptcy, insolvency, reorganisation or other similar laws relating to or affecting creditors’ rights generally or by general equitable principles.  Non-Contravention  5.3 The purchase by the User of the BRICs does not conflict with the constituent documents of the User or with any material contract by which the User or its property is bound, if the User is an Entity, or any laws or regulations or decree, ruling or judgement of any Court applicable to the User or the User’s property.  5.4 The funds that the User uses to purchase BRICs were not and are not directly or indirectly derived from any activities in connection with anti-money laundering and/or terrorism financing laws or regulations or any other acts in breach or contravention of any applicable law, regulation or rule.  5.5 The BRICs to be delivered to and received by the User will not be used for any purpose in connection with money laundering, terrorism financing or any other acts in breach or contravention of any applicable law, regulation or rule.  5.6 The User agrees and acknowledges that the Company is not liable for any direct, indirect, special, incidental, consequential or other losses of any kind, in tort, contract or otherwise (including but not limited to loss of revenue, income or profits, and loss of use or data), arising out of or in connection with any acceptance of or reliance on these Terms or any part thereof by the User.  5.7 The User waives the right to participate in a class action lawsuit or a class wide arbitration against the Company and/or any person involved in the sale and/or with the creation and distribution of the BRICs.  5.8 All of the above representations and warranties are, and will continue to be, true, complete, accurate and non-misleading from the time of the User’s acceptance of these Terms notwithstanding the receipt by the User of all of the BRICs.  6. CONTENT ON THE MARKETPLACE  6.1 You acknowledge and agree that all the information and materials presented or used on the Marketplace by us, including but not limited to images, pictures, data, text, music, sound, photographs, graphics, illustrations, video, audio, messages, code, or other materials (the “Content”), whether publicly posted or privately transmitted, is the exclusive work and property of the person from whom such Content originated.  6.2 We do not claim any permanent ownership of any Intellectual Property Rights (as defined in Clause 28.6 of these Terms) that you may hold in the Content. You retain the copyright and any other rights that you already hold in the Content which you may submit, post, upload or display on or through the Marketplace. However, limited rights may be required by us (and those we work with) to provide our services to you. Thus, when you submit, post, upload or display the Content, you expressly grant us a perpetual, irrevocable, worldwide, royalty-free, and non-exclusive license (and sub-licensable) to use, exploit and archive the Content in accordance with or as reasonably contemplated by these Terms.  6.3 When you post, submit, transmit, or upload the Content on the Marketplace, you represent and warrant that:  (a) you own all Intellectual Property Rights in respect of the Content, or if you are not the owner, that you have permission, rights or license to use the Content; (b) you have the permission, rights or license to display and reproduce the Content via the Marketplace; (c) you grant to us a limited, non-exclusive, non-transferable license to use and sub- license the Content in accordance with these Terms; (d) you and the Content do not and will not infringe the Intellectual Property Rights or other rights of any person or entity, including copyright, moral rights, trademarks, patents or rights of privacy; (e) you or your Content, and your use, storage, reproduction and display of the Content on the Marketplace will comply with all applicable law, rules and regulations; 
  (f) your Content does not breach any of these Terms; and 
  (g) your Content is not misleading or deceptive. 
   
6.4 All the Content on the Marketplace are for your general information purposes only and are no substitute for independent research and/or verification. None of the Content is intended to constitute professional advice or recommendation for you to make any kind of decision. When you use or access to any of the Content, you shall agree to bear all risks arising thereof whereby you shall be solely liable for any losses or damages suffered by any person as a result of your use or access to the Content. You further agree to fully defend and indemnify us from and against any claim, lawsuit, or other proceeding, loss, cost, liability, or expense we may incur to the extent arising from the Content that you publish or upload through the Marketplace.  

6.5 The Company may review the published Content upon requests or at its own discretion to determine whether they violate any of our policies or the applicable laws. the Company may change, modify or remove any of the Content without prior notice to you. Notwithstanding anything to the contrary, you acknowledge and agree that the Company has no obligation to monitor any published Content or information appearing on the Marketplace. We are not responsible or liable for the accuracy, completeness, appropriateness, or legality of any Content you may be able to access using the Marketplace.  

7. ELIGIBILITY TO PURCHASE  

7.1 The User shall not purchase BRICs if there are applicable legal restrictions in the User’s country of residence or domicile. It is the User’s sole responsibility to ensure that participation in the BRIC purchase is not prohibited, restricted, curtailed, hindered, impaired or otherwise adversely affected in any way by any applicable law, regulation or rule in the User’s country of residence or domicile and/or citizenship.  

7.2 The User is not eligible and is not to purchase any BRICs if:  

  (a) the User is an individual who is a citizen, domiciled in, resident of, or physically present / located in an Excluded Jurisdiction; 
  (b) the User is a body corporate which is incorporated in, or operates out of, an Excluded Jurisdiction, or the User’s operator(s) are citizens of, domiciled in, residents of, or physically present / located in, an Excluded Jurisdiction; (c) the User is the subject of any sanctions administered or enforced by the United Nations; (d) the User is a person who is otherwise prohibited or ineligible in any way, whether in full or in part, from participating in a Token purchase, or such purchase is prohibited, restricted or unauthorised in any form or manner whether in full or in part under the laws, regulatory requirements or rules in any jurisdiction applicable to the User (collectively, the “Excluded Persons”).    

8. USER’S KNOWLEDGE AND EXPERIENCE  

8.1 The User agrees that the User has received all the information that the User considers material in determining whether to purchase the BRICs. The User further represents that the User has had an opportunity to ask questions of and receive answers from the Marketplace regarding the terms and conditions of the purchase of BRICs and information pertaining to the Underlying Property. 

8.2 The User agrees that the User understands cryptocurrencies, digital assets, as well as blockchain technology. The User further agrees that the User fully understands the risks associated with the trading of BRICs, cryptocurrencies and digital assets as well as the mechanics related to the use of such BRICs, cryptocurrencies and digital assets (including their storage and exchange).  

8.3 The User further agrees that the User sufficiently understands investments in real estate and acknowledges that the User is able to fend for themselves, can bear the economic risk of investment, including a total loss, and has such knowledge and experience in financial or business matters that the User is capable of evaluating the merits and risks of the BRIC purchase.  

8.4 The User further agrees that the User understands the concepts of liquidity, market depth and other characteristics of the property market, cryptocurrencies and digital assets. 

8.5 The User understands that the Marketplace offers no guarantee against losses in relation to the value of the Underlying Property.  

8.6 The User represents and warrants that the User is not entering into transactions that are above the User’s financial abilities.  

8.7 The User further acknowledges and agrees that the Marketplace does not provide any advice, guidance or recommendations on the opportunity to purchase, sell, or retain ownership of the BRICs.  

8.8 If the User is considering purchasing BRICs as an investment, the User understands that it should contact a financial advisor for any such advice, guidance or recommendation.  

8.9 If the User is an Entity, the User also represents it has not been organised solely for the purpose of purchasing the BRICs.  

8.10 Should the User be invited and agrees to participate in any testing or closed group session for the improvement of the Marketplace, the User will adhere and abide to all rules and regulations set out by the Marketplace.  

8.11 The User further agrees to the use of the User’s information on the Marketplace for the purpose of improvement of the Marketplace. Usage of such information is compliant with Personal Data Protection Act 2010 (PDPA)  

9. NUMBER OF BRICS FOR SALE AND THE SALE PERIOD  

9.1 Each BRIC is valued at the amount stated on the Designated Web Address at the time of purchase and represents the stated amount on the Designated Web Address worth of the Underlying Properties on which the BRIC has been issued. The number of BRICs available for sale is determined by the value of the Underlying Properties divided by the value stated on the Designated Web Address at the time of purchase. The value of the Underlying Property is determined by valuation by an approved and registered valuer.  

9.2 The sale period is determined by the time it takes to sell the number of BRICs issued for the Underlying Property.       

9.3 In the event that the User attempts to make a purchase of BRICs after the sale period and payment has been transferred for such attempted purchase of BRICs, the User acknowledges and agrees that such refund shall be performed in accordance with Clause 18 below.  

9.4 The User further acknowledges and agrees that the Company shall have no obligations in any form or manner whatsoever to the User in respect of such attempted purchase and hereby waives all rights, claims and/or courses of action (present or future) under the law (including tortious claims) or contract against the Company in connection with or arising from such attempted purchase. The User shall further hold harmless, the Company from and against any and all losses damages, taxes, liabilities and expenses that may be incurred by the User in connection with or arising from such attempted purchase.  

10. PURCHASE OF TOKENS  

10.1 Subject to these Terms, the Users agree to purchase the BRICs listed on the Marketplace in a dollar amount equal to its desired purchase amount, at the value stated on the Designated Web Address per BRIC at the time of purchase.  

10.2 The respective number of BRICs to be purchased by each User hereunder shall be determined by dividing the User’s desired purchase amount hereto by the value stated on the Designated Web Address at the time of purchase (rounded down to the nearest whole token).  

10.3 Payment of the purchase price (which shall be the total number of BRICs to be purchased by a User, as calculated pursuant to the immediately preceding clause, multiplied by the value stated on the Designated Web Address per BRIC at the time of purchase) for the BRICs (the “Purchase Price”) shall be made at the time of the issue of the BRICs in accordance with Clause 11.2 below.  

10.4 The BRICs are issued against the value of a specific Underlying Property, or if elected, returns generated from the Underlying Property. Each BRIC represents a specific fraction of value of Underlying Properties valued at the amount stated on the Designated Web Address at the time of purchase or the amount of returns generated from the Underlying Property. Ownership of a BRIC therefore represents either ownership of the specific fraction of value of the Underlying Properties, or in the case of an elected investment in real estate assets, the returns generated from the assets. The details of the Underlying Properties are stated at the Designated Web Address.  

10.5 No information contained in or on, and no part of the following:  (a) the finalised, published and adopted version or draft of the Whitepaper or any other documents uploaded on the website of the Marketplace; (b) the Designated Web Address or any website or other social media channels directly or indirectly linked to the Whitepaper or the Channels; or (c) any other information or document,  shall constitute part of these Terms, and no representations, warranties or undertakings are or are intended or purported to be given by the Marketplace in respect of any information contained in or on, or any part of, the items as stated above.  

10.6 Without prejudice anything to the contrary, the User hereby acknowledges and agrees that the purchase and sale of the BRICs is directly between EBRIC Labuan and the User, and the Company is not a party to that or any other contract between EBRIC Labuan and the User and accepts no obligations in connection with any such contract. The Company hereby further disclaims all express and implied warranties in relation to the BRICs and the purchase of BRICs.      

11. ACCEPTED CURRENCIES AND TRANSFER PROCEDURE  

11.1 The User may purchase BRICs through the Designated Web Address.  

11.2 The purchase of BRICs may be completed via the following forms of payment to the Designated Account through its Payment Gateway:  
  (a) US Dollars (fiat currencies); or 
  (b) cryptocurrencies (i.e., USDT, AVAX).  
  
11.3 The delivery of BRICs to the User shall only be made on satisfaction of all of the following:  
  (a) the Purchase Price for the purchase of BRICs is received in full at the Designated Account; and 
  (b) the Wallet corresponding to the address provided by the User to the Marketplace is being maintained in fully operational, secure and valid status. For the avoidance of doubt, it is the sole responsibility of the User to ensure that the correct Wallet address is provided as described in Clause 12 below.  

11.4 BRICs shall be deemed to be received by the User upon confirmation of receipt of BRICs in the Wallet.  

12. RESPONSIBILITY TO ESTABLISH AND MAINTAIN CRYPTOCURRENCY WALLET AND ADDRESS  

12.1 It is the sole responsibility of the User to establish, and maintain, in a fully operational, secure and valid status, access to a Wallet.  

12.2 It is also the sole responsibility of the User to ensure the secure possession of the credentials for accessing the User’s Wallet and the private key to the Wallet.  

12.3 In the event your Wallet is not supported by the Marketplace, the User may also request for new digital wallet whitelisting with the Marketplace subject to fees (including but not limited to the admin and gas fees) by the Company.  

12.4 In the event of any loss, hack or theft from the User’s Wallet, the User acknowledges and confirms that the User has no right(s), claim(s) or courses of action in any way whatsoever against the Company.  

12.5 Any obligation of EBRIC Labuan to deliver any BRICs to the User or provide the User with any refund shall be subject to compliance with the provisions of these Terms. In the event that EBRIC Labuan is unable to deliver any BRICs to the User or provide the User with any refund due to the User’s Wallet not being initialised, valid or operational, EBRIC Labuan may, at its sole and absolute discretion, hold such BRICs or refund in escrow or do such other acts as it may determine and shall not be obliged to deliver any BRICs to the User or provide the User with any refund.  

13. FEES  

13.1 There are four kinds of fees, as the case may be:  
  
  (a) the handling fee at the moment of the purchase of the BRIC; 
  (b) the transfer fee for every transfer of the BRIC; 
  (c) the property management fees on the rental for all property management activities such as tenancy management, property appraisal, property maintenance, etc; and 
  (d) platform fee applied for each transaction passing through the Marketplace related to both rent generating and cashflow generating properties. The applicable fee is a proportion of transaction value (i.e., monthly rental income) and is automatically withheld before payment to the Users.   
  
13.2 These fees shall cover all the costs related to the issuance of the BRIC and the ownership of the Underlying Property, including safekeeping, insurance, valuation, audit, AML procedures and all other costs that may arise during the ownership of the Underlying Property.  

14. PURCHASE OF BRICS FROM OTHER PARTIES 

14.1 In the event that the User purchases first-hand BRICs through any website or place other than the Marketplace or the Designated Web Address, the User acknowledges and agrees that:  
  
  (a) the Company shall have no obligation to deliver, and the User shall have no right to receive, any BRICs; 
  (b) the Company shall have no obligation to provide, and the User shall have no right to receive, any refund for any part of the purchase consideration transferred by the User through such other website or place; and 
  (c) the Marketplace shall have no obligations to the User in any manner or form in respect of such purported purchase.  14.2 Any availability, transferability or tradability of BRICs on any cryptocurrency exchange shall not be construed, interpreted or deemed by the User as an indication of the merits of the Marketplace, EBRIC Labuan, the Whitepaper, the Channels, and the BRICs.  
  
14.3 Notwithstanding Clauses 14.1 and 14.2 above, where a BRIC is purchased from an cryptocurrency exchange or a BRIC owner and the following conditions are met:  
  
  (a) the BRIC is validated on the underlying blockchain as a legitimately issued BRIC issued by EBRIC Labuan; 
  (b) the new BRIC owner is eligible to purchase the BRICs under these Terms; 
  (c) the new BRIC holder is not an Excluded Person; 
  (d) the new BRIC holder is not a resident or a citizen of an Excluded Jurisdiction; and 
  (e) the new BRIC holder meets all AML requirements and provides all relevant information and documents on request,  then the new BRIC holder will be considered to have the same rights and be subject to the same terms and conditions as if the BRIC had been purchased from EBRIC Labuan via the Marketplace, with the exception that EBRIC Labuan will not have any obligation whatsoever to provide the new BRIC holder with a refund of the paid or due purchase price.  
  
15. RIGHTS OF BRIC HOLDERS  

15.1 Except for any rights granted by EBRIC Labuan, in its sole and absolute discretion, to BRIC holders as described in the Whitepaper (with the terms and conditions, and extent, of any such granted right also being determined by EBRIC Labuan in its sole and absolute discretion), ownership and holding of BRICs shall carry no other rights, express or implied, in relation to the User, the Company, the Marketplace or any other person or property.  

15.2 For the avoidance of doubt, the User shall have no right to interfere with the management or running of the Underlying Properties or assets, which will be carried out solely by the appointed property manager(s).  

16. WITHDRAWAL OF RENTAL INCOME FROM BRICS  

16.1 Should the User wish to redeem rental income from the BRICs owned, the BRIC holder or User must have submitted all relevant and requested documents and information prior to initiating the withdrawal. This may include (but is not limited to) the following:  

  (a) identity card and other identifying documents; 
  (b) date of birth; 
  (c) residences for tax purposes (may be more than 1) with proof of addresses; 
  (d) citizenships held; 
  (e) phone numbers and email addresses; 
  (f) relevant passwords (BRICs); 
  (g) tax Identification number(s); and 
  (h) evidence for the source of wealth and source of funds.  
  
16.2 The withdrawal of the income by the User on the Marketplace will be subject to the applicable bank transaction fees incurred during the withdrawal process. The User acknowledges and agrees that such fees, as to be determined by the relevant bank or financial institution, will be borne by the User and, if applicable, deducted from the withdrawn rental income.  

16.3 The eligibility to withdraw rental income from the property or BRIC will be subject to the User’s or BRIC holder’s local law, regulation and guidelines.  

17. WITHDRAWALS, CANCELLATIONS, REJECTIONS OF PURCHASES AND TERMINATION OF SALE  

17.1 Upon successful receipt in the Designated Account of the Purchase Price for the purchase of BRICs, save as provided for under these Terms:  

  (a) such transfer shall be deemed to be final; and 
  (b) unless otherwise required by the applicable laws, regulations or rules, the User shall not be entitled to any withdrawals or cancellations of transfers or purchases, or any refunds.  
  
17.2 The Company reserves the right, in its sole and absolute discretion, to reject any purchases of BRICs or terminate a sale at any time after the User’s acceptance of these Terms and prior to the delivery of BRICs in the event that the Marketplace is not completely satisfied with the outcome of the customer due diligence carried out on the User. The Company further reserves the right, in its sole and absolute discretion, to treat the sale and purchase of BRICs therein as being invalid, notwithstanding any delivery of BRICs which may have been effected, where there has been any change in any applicable law, regulation or rule that prohibits, restricts, curtails, hinders, impairs or otherwise adversely affects the sale to any extent.  

17.3 In the event of any such rejection of the User’s purchase of BRICs, termination of the sale or the sale being treated as invalid, where the User has transferred the purchase amount for such rejected purchase, or such purchase of BRICs which is the subject of a terminated sale, or the completed sale being treated as invalid (as the case may be), the User acknowledges and agrees that such refund shall be performed in accordance with the Clause 18 below.  

17.4 The User further acknowledges and agrees that except for any refund that the Company may elect to provide under Clause 17.3 above, the Company shall have no obligations in any form or manner whatsoever to the User with respect of such purchase and the User hereby waives all rights, claims and/or courses of action (present or future) under law (including any tortious claims) or contract against the Company in connection with or arising from such intended purchase. The User shall further hold harmless, the Company from and against any and all losses, damages, taxes, liabilities and expenses that may be incurred by the User in connection with or arising from such purchase.  

18. REFUND OF PURCHASE CONSIDERATION  

18.1 The User acknowledges, agrees, and confirms that there shall be no refund of any transfers made by the User in any form or manner unless clearly provided for under these Terms. All risks in relation to any refund of transfers made, shall be borne absolutely by the User, and the Company shall not be liable for any such risks. 

18.2 In relation to Clauses 9.3, 17.3 and 25.3, the User acknowledges and agrees that EBRIC Labuan may, at its sole and absolute discretion, provide a refund of such transfer in full or in part without interest and net of all administrative and/or third party charges and/or other transaction fees (if any) that may be incurred in connection with such refund. For the avoidance of doubt, all administrative and/or third party charges and/or transaction fees (if any) incurred in connection with such refund shall be borne by the User.  

18.3 In each case where the EBRIC Labuan elects, in accordance with these Terms, to provide a refund of any transfers made by the User for any intended purchase, EBRIC Labuan shall transfer such amount as may be equivalent to the amount refundable to the User.  

18.4 Unless otherwise stated herein, the User hereby waives all rights, claims and/or courses of action (present or future) under law (including any tortious claims) or contract against the Company in connection with or arising from such refund, and shall further hold harmless, the Company from and against any and all losses, damages, taxes, liabilities and expenses that may be incurred by the User in connection with or arising from such refund.  19. GUIDELINES  19.1 You use of the Marketplace is subject to our guidelines. You shall not use, allow, or enable others to use the Marketplace, or knowingly condone use of the Marketplace by others, in any manner that is, attempts to, or is likely to:  

  (a) use any proxy internet protocol addresses (IPs) in order to attempt to hide the use of multiple accounts, disrupt any of our services or to avoid being detected; 
  (b) be libellous, defamatory, indecent, vulgar or obscene, pornographic, sexually explicit or sexually suggestive, racially, culturally, or ethnically offensive, harmful, harassing, intimidating, threatening, hateful, objectionable, discriminatory, or abusive, or which may or may appear to impersonate anyone else; 
  (c) affect us adversely or reflect negatively on us, the Marketplace, our goodwill, name or reputation or cause duress, distress or discomfort to us or anyone else, or discourage any person from using all or any portion, features or functions of the platform, or fromadvertising, linking or becoming a supplier to us in connection with the Marketplace; 
  (d) send or result in the transmission of junk e-mail, chain letters, duplicative or unsolicitedmessages, or so-called “spamming” and “phishing”; 
  (e) transmit, distribute or upload programs or material that contain malicious code, such as viruses, timebombs, cancelbots, worms, trojan horses, spyware, or other potentiallyharmful programs or other material or information; 
  (f) violate any laws, regulations, judicial or governmental order, any treaties or violate orinfringe upon any Intellectual Property Rights, rights of publicity or privacy, or any other rights of ours or of any other person; 
  (g) gain unauthorised access to the Marketplace, other users’ accounts, names, passwords, personally identifiable information or other computers, websites or pages, connected or linked to the Marketplace in any manner which violates or is inconsistent with these Terms; 
  (h) modify, disrupt, impair, alter or interfere with the use, features, functions, operation ormaintenance of the Marketplace or the rights or use and enjoyment of the Marketplace by anyother person; 
  (i) collect, obtain, compile, gather, transmit, reproduce, delete, revise, view or display anymaterial or information, whether personally identifiable or not, posted by or concerning any other person, in connection with their or your use of the Marketplace, unless you have obtained the express, prior permission of such other person to do so; 
  (j)  “stalk” or otherwise harass another; 
  (k) interfere with other user’s posts; 
  (l) circumvent or manipulate our fee structure, the billing process, or fees owed to us; 
  (m) post or provide false, inaccurate, misleading, incomplete, defamatory or libellous Content; 
  (n) take any action that may undermine any ratings system that we may use; 
  (o) transfer your account and user identification to another party without our consent; 
  (p) copy, modify, or distribute content from any  websites or any  of our  copyright  or trademarks; 
  (q) harvest or otherwise collect information about users, including email addresses, without their consent; 
  (r) forge headers, icons or otherwise manipulate identifiers in order to disguise the originof any Content transmitted through the Marketplace; and/or 
  (s) upload, post, email, transmit or otherwise make available any Content that you do not have a right to make available under any law or under contractual or fiduciary relationships (such as inside information, proprietary and confidential information learned or disclosed as part of employment relationships or under non-disclosure agreements).  
  
19.2 While we prohibit all the aforesaid conducts and Content on the Marketplace, you understand and agree that we cannot be responsible for the Content posted on the Marketplace and you nonetheless may be exposed to such materials and that you use the Marketplace at your own discretion.  

19.3 We do not manually screen Content or control Content before it is displayed on the Marketplace so occasionally users may inadvertently or deliberately submit and display Content that breaches any of these Terms. This means that you, and not us, are entirely responsible for all Content that you upload, post, email, transmit or otherwise make available via the Marketplace.  19.4 You may be exposed to Content that is offensive, indecent or objectionable. Under no circumstances, we will be liable in any way for any Content, including, but not limited to, any errors or omissions in any Content, or any loss or damage of any kind incurred as a result of the use of any Content posted, emailed, transmitted or otherwise made available via the Marketplace.  19.5 You agree to adhere to our guidelines as set in these Terms and if you fail to do so, we reserve our right to suspend or terminate your account. We also reserve our rights to introduce, change or amend our guidelines from time to time.  

20. MODIFICATION  

20.1 In the event that relevant laws require or we deem necessary, we reserve the right to amend or update these Terms herein from time to time without giving prior notice to you. We may change any or all aspects of the services provided via the Marketplace at any time at our sole discretion and you acknowledge and agree that you shall be deemed to have notice of and agree to the updated Terms. Nothing in these Terms will constrain how we operate our business. You shall be responsible for reviewing and becoming familiar with any such modifications.  

20.2 If the alterations constitute a material change to these Terms, we will notify you by posting a notification on the Marketplace or through other reasonable means. Your use of the services following such notification constitutes your acceptance of the terms and conditions as modified. What constitutes a “material change” will be determined at oursole discretion, in good faith and using common sense and reasonable judgment.  

20.3 If you do not accept a change to these Terms, you shall cease to use our Marketplace and delete your account immediately.  

21. NOTICES  

21.1 Any notice or other communication to be given under these Terms shall be in writing, and shall be deemed to have been duly served on, given to or made in relation to a Party if it is:  (a) left at the address of that Party or posted by prepaid airmail/first-class/registered post addressed to that Party at such address, in which case such notice shall be deemed to have been delivered and received at the time of delivery; or (b) transmitted by email or facsimile, in which case such notice shall be deemed to be delivered and received at the time of transmission in legible form.       

21.2 In the case of delivery by hand, provided that the delivery occurs after 6.00 p.m. on a business day or on a day which is not a business day, receipt shall be deemed to occur at 9.00 a.m. on the next business day.  

21.3 For the purposes of these Terms, all notices, demands or request provided for or permitted to be given pursuant to these Terms must be in writing and the contact details of the Marketplace shall be the contact details (including, if applicable, the details of the person for whose attention a notice or communication is to be addressed) as stipulated under Clause 40 below or as the Marketplace may announce on the Channels or notify to you in writing from time to time in accordance with the requirements of this Agreement.  

21.4 The User’s contact details shall be such contact details as the User may notify to the Marketplace in writing from time to time in accordance with the requirements of this Agreement.  

22. PRIVACY  

22.1 When you access to or use the Marketplace, you acknowledge and agree that we will collect, store and process certain information as described in our Privacy Policy (which is available at www.likwidasset.com. You agree and acknowledge that our Privacy Policy is incorporated into these Terms by reference. Please carefully read our Privacy Policy as it contains important details about our collection, processing and retention of your personal information.  

23. CONFIDENTIAL INFORMATION  

23.1 We will not disclose or use your personal data or confidential information in accordance with the Personal Data Protection Act 2010 and other applicable laws, you will not disclose or use our Confidential Information (as defined hereunder).  

23.2 “Confidential Information” means any information which is either marked “confidential” orby its nature intended to be exclusively for your sole knowledge whether disclosed or made available to you by us, directly or indirectly, whether in writing, orally or visually. For the avoidance of doubt, Confidential Information shall include, without limitation, all information contained within our reporting systems and other performance metrics and any other technicalor programming information we disclose or make available to you. 

23.3 However, Confidential Information does not include information that:  

  (a) is or becomes publicly known and generally available other than through your/or actionor inaction; 
  (b) was already in your possession (as documented by written records) without confidentiality restrictions before you received it from us; and 
  (c) is required by applicable law, regulation, governmental order decree, legal process,court order or regulatory authority to be disclosed.  
  
23.4 You acknowledge, consent and agree that we may access, preserve and disclose your account information and Content if required to do so by law or in a good faith belief that such access preservation or disclosure is reasonably necessary to:  
  
  (a) comply with legal process; 
  (b) enforce these Terms; 
  (c) respond to claims that any Content violates the rights of third parties; 
  (d) respond to your requests for customer service; or 
  (e) protect our rights, property or personal safety, our users and the public.  
  
23.5 You will protect all Confidential Information you receive through the Marketplace, and you may not disclose or distribute any such Confidential Information, and you will only use such Confidential Information in conjunction with the Marketplace and as permitted by these Terms or by other agreements between you and us.    

24. MESSAGING SERVICES  

24.1 The Marketplace allows users to send messages to one another. However, the use of the private messaging service is not “private” in the sense that it is a message seen only by the sender and receiver. While the message is private from the rest of the users, you acknowledge and confirm that your communications may be read or intercepted by us. Messages will not be shared by the Company with external parties without obtaining your prior permission.  

25. ANTI-MONEY LAUNDERING AND COUNTER TERRORIST FINANCING  

25.1 As part of its anti-money laundering and counter terrorist financing due diligence and verification procedures, the Marketplace may require the User to furnish such documents and information (and which includes photographs and/or videos evidencing the existence of such documents and information) so as to prove the User’s identity, status and/or eligibility to purchase BRICs.  

25.2 EBRIC Labuan reserves the right, in its sole and absolute discretion, to reject the User’s intended purchase of BRICs if the User is unable to furnish such documents or information to the EBRIC Labuan’s sole and absolute satisfaction. Only Users who have satisfied EBRIC Labuan’s AML requirements to its sole and absolute satisfaction shall be eligible to redeem the returns generated from BRICs.  

25.3 In the event that you have not successfully met the AML requirements and provided that payment of the BRICs is successfully made, EBRIC Labuan may, at its sole and absolute discretion, provide a refund of such transfer in full or in part without interest and net of all administrative and/or third party charges and/or other transaction fees (if any) that may be incurred in connection with such refund, and it shall be performed in accordance with Clause 18. 

25.4 Unless stated otherwise, the Company shall have no obligations in any form or manner whatsoever to the User with respect of such attempted purchase and the User hereby waives all rights, claims and/or courses of action (present or future) under law (including any tortious claims) or contract against the Company in connection with or arising from such intended purchase. The User shall further hold harmless, the Company from and against any and all losses, damages, taxes, liabilities and expenses that may be incurred by the User in connection with or arising from such attempted purchase.  

26. LIABILITY  

26.1 You expressly agree that to the fullest extent permitted by law, the Company and our parent company, subsidiaries, affiliates, partners, directors, managers, officers, agents, shareholders, employees, and applicable third parties will not be liable for any loss of profits, data or costs of procurementof substitute goods or services, or for any other indirect, special, incidental, punitive, consequential damages arising out of or in connection with these Terms or your use of the Marketplace, other intangible losses, however caused, and under whatever cause of action or theoryof liability brought, even if such damages are foreseeable, and whether or not you or we have been advised of the possibility of such damages. We further deny responsibility for all liabilityand damages to you or other users caused by:  

  (a) your access to or use of or inability to access or use the Marketplace; 
  (b) any conduct or content of any third party on this Marketplace, including without limitation,any defamatory, offensive or illegal conduct of others; 
  (c) any Content provided by you; and 
  (d) unauthorised access, use or alteration of your transmissions or the Content, whether based on warranty, contract, tort (including negligence) or any other legal theory, whether or not we have been informed of the possibility of such damage, and even if aremedy set forth herein is found to have failed of its essential purpose.     
  
26.2 If you are dissatisfied with any aspect of the Marketplace or with these Terms, your sole and exclusive remedy is to discontinue your access and/or use of the Marketplace. The limitation of liability as set out herein shall apply to the maximum extent permitted by law.  

26.3 You agree to limit any additional liability not disclaimed or denied by us under these Terms to your direct and documented damages and you further agree that under no circumstances will any such liability exceed in the aggregate the amount of fees paid by you to us during the past six months’ period immediately preceding the event that gave rise to your claim for damages.  

26.4 You acknowledge that we may not be able to confirm the identity of other registered users or prevent them acting under false pretends or in a manner that infringes the rights of any person.  

26.5 We exercise all reasonable skill and care to ensure that our website https://www.likwidasset.com/ is free from viruses and other malware. However, you must take your own precautions to ensure that the process that you employ for accessing the Marketplace and our service does not expose you to the risk of viruses, malicious computer code or other forms of interference which may damage your own computer system. We do not accept responsibility for any interference or damage to any computer system that arises in connection with your use of the Marketplace or any linked website.You must ensure that your access to or use of the Marketplace is not illegal or prohibited by laws that apply to you.   

27. SITE AVAILABILITY AND ACCURACY  

27.1 Although we strive to provide you with excellent services, we do not guarantee that the Marketplace will be available without interruption. Access to the Marketplace may become degraded or unavailable during times of significant volatility or volume. This could result in the inability to the use of the Marketplace and may also lead to support response time delays. the Company shall not be liable for any losses resulting from or arising out of any delays from the Marketplace.  

28. INTELLECTUAL PROPERTY RIGHTS  

28.1 This Agreement shall not entitle the User to any intellectual property rights, including the rights in relation to the use, for any purpose, of any information, image, user interface, logos, trademarks, trade names, Internet domain names or copyright in connection with the Company the Whitepaper, the Channels, the Marketplace, the BRIC sale, the BRICs, the Designated Web Address, or the User’s purchase of BRICs.  

28.2 You acknowledge that all rights, title and interest, including without limitation all Intellectual Property Rights contained on the Marketplace and any trademarks and brands included in those materials on the Marketplace, unless specifically labelled otherwise, shall belong to the Company and that you shall not acquire any rights, titles, or interests in or to the Marketplace except as expressly set forth in these Terms.  

28.3 You will not modify, adapt, translate, prepare derivative works from, decompile, reverse engineer, disassemble or otherwise attempt to derive source code from any of our services, software, or documentation, or create or attempt to create a substitute or similar service or product through the use of or access to the Marketplace or proprietary information related thereto.  

28.4 You will not remove, obscure, or alter our copyright notice or other proprietary rights notices affixed to or contained in the Marketplace.        

28.5 You undertake that your Content does not infringe, or constitute an infringement or misappropriation of, any third party’s Intellectual Property Rights. If any third party claims any right or interest in your Content or brings any action against us on alleged infringement or misappropriation of such third party’s Intellectual Property Rights, you shall fully indemnify, defend and hold us harmless against any and all such claims, actions, costs, expenses and damages which we may incur or become liable for such infringement.  

28.6 “Intellectual Property Rights” means any and all rights existing from time to time under patent law, copyright law, moral rights law, trade secret law, trademark law, unfair competition law, publicity rights law, privacy rights law, and any and all other proprietary rights, as well as, any and all applications, renewals, extensions, restorations and reinstatements thereof, now or hereafter in force and effect worldwide.  

29. INDEMNITY  

29.1 You shall indemnify, defend and hold the Company and our parent company, subsidiaries, affiliates, partners, directors, managers, officers, agents, shareholders, employees, and applicable third parties (e.g. syndication partners, licensors, licensees, consultants and contractors) (collectively “Indemnified Person(s)”) harmless from and against any and all third party claims, demands, liabilities, losses, damages and expenses (including damage awards, settlement amounts, and reasonable legal fees), brought against any Indemnified Person(s), arising out of, related to or which may arise from your use of the Marketplace and/or your breach of any term of these Terms or the infringement of any Intellectual Property Rights or any rights of other persons due to your access or use of the Marketplace, or those who use your account or any Content you post, store or otherwise transmit on or through the Marketplace. If any Indemnified Person(s) suffers any losses or damages, you shall indemnify them, including but not limited to litigation fees, attorney fees, settlement fees and other losses. The Company may ask you to defend against any claimor take legal action, and to conduct any settlement negotiations in respect of the claim or demand stated hereinabove. You may not take any legal action which may be adverse to our rights without our express consent.  

29.2 To the maximum extent permitted by the applicable laws, regulations and rules:  

  (a) the Company shall not be liable for any indirect, special, incidental, consequential or other losses of any kind, in tort, contract or otherwise (including but not limited to loss of revenue, income or profits, and loss of use or data), arising out of or in connection with the purchase of, use, receipt or holding of BRICs by the User; 
  (b) the aggregate liability of the Company, in tort, contract or otherwise, arising out of or in connection with the purchase of, use, receipt or holding of BRICs by the User shall be limited to the funds transferred by the User as consideration for the BRIC purchase; and 
  (c) the User agrees to waive all rights to assert any claims under the applicable laws, regulations and rules and may make claims based only on these Terms.  29.3 To the maximum extent permitted by the applicable laws, regulations and rules, the User shall indemnify, defend, and hold the Company harmless from and against any and all claims, damages, losses, suits, actions, demands, proceedings, expenses, and/or liabilities (including but not limited to reasonable legal fees incurred and/or those necessary to successfully establish the right to indemnification) filed/incurred by the User or any third party against the Company arising out of including but not limited to a breach of any warranty, representation, defamation, false allegations of written and /or spoken, or obligation hereunder.         
  
30. TERMINATION  

30.1 In the event that you violate any provision of these Terms or we deem necessary at our sole discretion, we may suspend or terminate your access to all or any part of the Marketplace at any time, with or without cause, effective immediately, without giving any prior notice to you.  

30.2 You acknowledge and agree that you may terminate your access to and use of the Marketplace at any time, provided that all provisions of these Terms, which shall by their nature survive termination, including without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability. You may terminate these Terms by deleting your account at any time, in accordance with Clause 31.  

30.3 If your account is terminated or your access to the Marketplace is restricted, you may continue using certain aspects of the Marketplace (such as viewing only) without an account, and these Terms will continue to apply to such use. If you believe that the termination or suspension of your account has been made in error, you can submit an appeal to us at the contact details stipulated under Clause 40. 

30.4 We reserve the right to suspend, terminate or cancel your account or your access to the Marketplace if you materially breach any of the provisions contained in these Terms. Specifically, we may take one or more of the following actions:  
  
  (a) suspend, whether temporarily or permanently, your right to access the Marketplace at our sole discretion; 
  (b) issue you with a written warning if you have violated these Terms prior to suspension or termination of your account. If you do not remedy your default within the notice period as in the written warning, these Terms shall terminate with immediate effect onthe expiry of such notice period; 
  (c) take legal proceedings against you for reimbursement of any and all relevant costs on an indemnity basis resulting from your breach; 
  (d) take further legal action against you as may be appropriate; 
  (e) disclose such information to any law enforcement authorities requires us to do so; and/or 
  (f) any other actions which we deem reasonably appropriate (and lawful).  

30.5 Termination does not immediately relieve you of any and all obligations incurred by you underthese Terms. In the event that these Terms terminate for any reason whatsoever, the following shall be applicable:  (a) your access to the Marketplace shall terminate with immediate effect; (b) you shall continue to comply with all of the obligations on your part under these Termswhich are not affected by termination; (c) we reserve the right (but have no obligation) to dispose and delete any data stored on the Marketplace without further reference to you; (d) we will not be liable to you for compensation, reimbursement, or damages related to your use of the Marketplace, or any termination or suspension of the Marketplace or deletion of your information; (e) any claim which either party may have against the other in respect of any breach or non-performance or repudiation of any of the provisions of these Terms which shall have occurred prior to such termination shall not be affected or prejudiced; and (f) you are still liable to us for any fees or fines, or other financial obligations incurred by you or through your use of the Marketplace prior to termination.  

30.6 The obligations and liabilities of the parties incurred prior to the termination of these Terms shall survive the termination of these Terms for all purposes. If the parties have executed a separate agreement that contains confidentiality terms prior to or contemporaneously with these Terms, those separate confidentiality terms shall remain in full force to the extent they do not conflict.     31. ACCOUNT DELETION  31.1 You may delete your account at any time, by clicking ‘DELETE ACCOUNT’.  31.2 Prior to the deletion of the account, you are advised to withdraw all rental income from EBRIC Labuan and transfer all your BRIC out of the Wallet. In the event that there is a remaining BRIC in your Wallet after the deletion of the account, the remaining BRIC will be withdrawn from your Wallet and transferred to the Marketplace’s designated wallet.  31.3 You hereby accept and acknowledge that, once the account is deleted: 
  (a) you will have no access to it;  
  (b) the Company will be under no obligation to notify you of, or provide to you, any BRIC that is associated with your account; and  
  (c) the Company reserves the right (but has no obligation) to permanently delete all your information and data entered and provided by you in relation to the use of Marketplace, and also reserves the right to retain any data and information as required in accordance with our Privacy Policy to comply with our legal obligations and for purposes such as security, fraud, accounting, reconciliation, anti-money laundering and reporting purposes.  31.4 In connection thereof, if you wish to re-register as a User using the same email address which was previously registered, all existing information retained in our database may be retrieved and reassign to the new account registered provided however that the identification information matched and answered correctly.  31.5 You further accept and acknowledge that the Company shall not be liable to you or any third party in relation to the deletion of your data and information or the account.  32. SEVERABILITY  32.1 If any of the provisions in these Terms is determined to be unenforceable, unlawful or void (including any provision in which we exclude our liability to you), such provision shall nonetheless be enforceable to the fullest extent permitted by applicable laws, and the unenforceable portion shall be deemed to be severed from these Terms and the enforceability of any other provisions of these Terms shall not be affected.  33. DISCLAIMERS  33.1 To the maximum extent permitted by all applicable laws, regulations, and rules and except as otherwise provided in these Terms, the Company hereby expressly disclaims its liability and shall in no case be liable to the User or any person for:  (a) any sale or transfer of any BRICs acquired by the User to any person at any time; (b) cryptocurrencies used to purchase BRICs being obtained through any acts in connection with money laundering, terrorism financing or any other acts in breach or contravention of any applicable law, regulation or rule; (c) use of BRICs for any purpose in connection with money laundering, terrorism financing or any other acts in breach or contravention of any applicable law, regulation or rule; 
  (d) rejection of purchases of BRICs or termination of the BRIC sale pursuant to the Terms outlined herein; 
  (e) failure or delay in the delivery by EBRIC Labuan, and receipt by the User, of BRICs; 
  (f) failure, malfunction or breakdowns due to hacks, mining attacks (including but not limited to double-spend attacks, majority mining power attacks and “selfish- mining” attacks), cyber-attacks, distributed denials of service, errors, vulnerabilities, defects, flaws in programming or source code or otherwise, regardless of when such failure, malfunction, breakdown, or disruption occurs; 
  (g) failure, malfunction, breakdowns or disruption to any blockchain, blockchain- based software systems or any blockchain technology due to hardforking, hacks, mining attacks (including but not limited to double-spend attacks, majority mining power attacks and “selfish-mining” attacks), cyber- attacks, distributed denials of service, errors, vulnerabilities, defects, flaws in programming or source code or otherwise, regardless of when such failure, malfunction, breakdown, or disruption occurs; 
  (h) any virus, error, bug, flaw, defect or otherwise adversely affecting the BRICs in any manner; 
  (i) traded prices or trading volume of BRICs (after BRIC issue); 
  (j) failure to disclose information relating to the progress of sales of BRICs; 
  (k) loss of possession of the credentials for accessing, or (where applicable) loss or destruction of the private keys of the User’s Wallet in any manner and to any extent; 
  (l) failure or delay in the availability of BRICs for trading on any cryptocurrency exchange; 
  (m) any rejection of trading of BRICs by a cryptocurrency exchange; 
  (n) any prohibition, restriction or regulation by any government or regulatory authority in any jurisdiction of the operation, functionality, usage, storage, transmission mechanisms, transferability or tradability (after BRIC issue) or other material characteristics of the BRICs; 
  (o) any risks associated with the Company, the Whitepaper, the Channels, the Marketplace, the BRIC sale, BRICs, the User’s purchase of BRICs, the Wallet, the User’s provision of the Wallet address, the Designated Account, and the Designated Web Address; 
  (p) all other risks, direct, indirect or ancillary, whether in relation to the Company, Whitepaper, the Channels, the Marketplace, the BRIC sale, BRICs, the User’s purchase of BRICs, the Wallet, the User’s provision of the Wallet address to the Marketplace, the Designated Account and the Designated Web Address which are not specifically or explicitly contained in or stated in these Terms; and 
  (q) the Company does not in any way guarantee a positive return over any time period for the purchase or holding of BRICs.  33.2 In the event of any loss, hack or theft of funds from the Designated Account, the Receiving Address or the Wallet, the User acknowledges and confirms that the User shall have no right(s), claim(s) or causes of action in any way whatsoever against the Marketplace.  
  
  34. MISCELLANEOUS  
  
  34.1 No agency, partnership, joint venture, employee-employer or franchisor-franchisee relationship is intended or created by these Terms. Neither party shall have the power or the right to bind, commit or pledge the credit of the other party.  
  
  34.2 In our sole discretion, we may assign these Terms or any right and obligation hereunder to any third party upon notice to you. Without our prior written consent, you may not directly or indirectly assign these Terms or any right and obligation hereunder to any third party.  
  
  34.3 Headings are for reference purposes only and do not limit the scope or extent of such sections.  
  
  34.4 Any failure and/or to exercise in exercising on our part of any right(s), power(s) or privilege(s) hereunder shall not operate as a waiver thereof nor shall any single or partial exercise of any right(s), power(s) or privilege(s) preclude any other right(s), power(s) or privilege(s) of us. The rights and remedies provided in these Terms are cumulative and not exclusive of any rights or remedies otherwise provided by law.  
  
  34.5 We do not represent or warrant that the access to and use the Marketplace or any part of it, will be uninterrupted, reliable or fault-free. 
  
  34.6 Notwithstanding the sale of all BRICs for the Underlying Property, any delivery of BRICs to the User or any termination of the BRIC sale pursuant to these Terms shall remain valid and in full force and effect.  
  
  35. THIRD-PARTY WEBSITES AND TRANSACTIONS  
  
  35.1 The Marketplace may contain third-party content and may provide links to third-party websites (“Linked Sites”) that are not affiliated with us, being a service to those interested in such information. Unless expressly stated, we are not responsible and do not control, endorse or adopt any Linked Sites and make no representation or warranties of any kind regarding the Linked Sites, including without limitation regarding its accuracy or completeness. You are responsible for evaluating whether you want to access or use them. You shall evaluate the Linked Sites on your own and assume all risks. 
  
  35.2 If you connect to the Linked Sites through the Marketplace and have any transaction with such third party, you shall conduct an investigation that you deem necessary or appropriate. Such transaction is between you and such third party, and has nothing to do with the Company. You acknowledge and agree that the Company is not responsible or liable in any manner for any harm or damages related to the purchase or use of goods, services, resources, content, or any other transactions made in connection with any of the Linked Sites.  
  
  35.3 We do not warrant and will not have any liability or responsibility for any of the contents in the Linked Sites. We undertake no responsibility to update or review any Linked Sites, therefore you shall carefully review the Linked Sites’ policies and practices and make sure that you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding the Linked Sites should be directed to the third party.  
  
  35.4 We may use a third-party credit card merchant to receive your payment. Such third party will check and process your payment details. There are strict obligations that govern credit card merchants' handling of personal data. However, we cannot be held responsible for actions by such third party. We accept no liability for any losses and/or damages that you may suffer as a result of such third party's acts and/or omissions. You are advised to print and retain a copy ofeach monetary transaction for future reference.  
  
  36. NO IMPLIED WAIVERS; REMEDIES  
  
  36.1 No failure or delay on the part of any party in exercising any right, privilege, power, or remedy under these Terms, and no course of dealing shall operate as a waiver of any such right, privilege, power or remedy; nor shall any single or partial exercise of any right, privilege, power or remedy under these Terms preclude any other or further exercise of any such right, privilege, power or remedy or the exercise of any other right, privilege, power or remedy.  
  
  36.2 No waiver shall be asserted against any party unless signed in writing by such party.  
  
  36.3 The rights, privileges, powers and remedies available to the parties are cumulative and not exclusive of any other rights, privileges, powers or remedies provided by statute, at law, in equity or otherwise.  
  
  36.4 Except as provided in these Terms, no notice to or demand on any party in any case shall entitle such party to any other or further notice or demand in any similar or other circumstances or constitute a waiver of the right of the party giving such notice or making such demand to take any other or further action in any circumstances without notice or demand.    
  
  37. TAXES  
  
  37.1 The purchase amount that the User transfers as payment for purchase of BRICs shall be exclusive of all taxes that are applicable to the User’s purchase of, receipt and holding of BRICs in any jurisdiction (“Payable Tax”).  
  
  37.2 The User shall be solely responsible for determining any Payable Tax and declaring, withholding, collecting, reporting and remitting the correct amount of Payable Tax to the appropriate tax authorities.  
  
  37.3 The User shall be solely liable for all penalties, claims, fines, punishments, or other liabilities arising from the non-fulfilment or non-performance to any extent of any obligations in relation to the Payable Tax.  
  
  37.4 We shall not be responsible for determining any Payable Tax and declaring, withholding, collecting, reporting and remitting the correct amount of Payable Tax to the appropriate tax authorities.  
  
  38. AGE REQUIREMENT  
  
  38.1 Our Marketplace is not intentionally designed for or directed to any individuals under 18 years of age. By agreeing to these Terms, you represent and warrant that you are at least 18 years of age,and you have the legal right and capacity to enter into and to comply with these Terms. You further agree that you have given us your consent to allow any of your minor dependents to use the Marketplace. By accepting these Terms, you shall take responsibility for your actions and any charges associated with your use of any of the Marketplace.  
  
  39. GOVERNING LAW AND LEGAL DISPUTES  
  
  39.1 These Terms shall be construed in accordance with and governed by the laws of Malaysia, without giving effect to the choice of law rules.  
  
  39.2 A party shall give prompt written notice of any Dispute to the other Party (a "Dispute Notice"). Such Dispute Notice will include sufficient details of the Dispute to enable the other Party to consider its position in relation to the Dispute.  
  
  39.3 Each party agrees to use its best endeavours to settle any Dispute amicably between the parties within a period of 30 days from the date of the Dispute Notice given.  
  
  39.4 Only in the event that a Dispute is not settled then either party may, by notice in writing to the other party, refer the Dispute to arbitration.  
  
  39.5 In the event that either party refers a Dispute, such Dispute shall be referred to and finally resolved by arbitration administered by the Asian International Arbitration Centre in accordance with the Arbitration Rules of the Asian International Arbitration Centre for the time being in force which rules are deemed to be incorporated by reference in these Terms. The seat of the arbitration shall be in Labuan. The Tribunal shall consist of one (1) arbitrator to be nominated by the Company. The language of the arbitration shall be in English.  
  
  39.6 Notwithstanding any Dispute or reference of certain Disputes (or part of certain Disputes) for determination by arbitration, the parties will continue to comply with their respective obligations under these Terms.  39.7 Notwithstanding anything to the contrary, each of the parties hereby irrevocably agrees that the courts of Malaysia shall have exclusive jurisdiction in connection with any actions or proceedings arising between the parties under these Terms. Each of the parties hereby irrevocably consents and submits to the jurisdiction of said courts for any such action or proceeding. Each of the parties hereby waives the defense of an inconvenient forum to the maintenance of any such action or proceeding in said courts.

''', 
                        softWrap: true,
                        style: GoogleFonts.figtree(textStyle: TextStyle(fontSize: adjustResolution(context, Resolution.normal.index, 14), fontWeight: FontWeight.w400)),
                      )
                    
                  )
                ],),
              )
            ],
          ),
        )
      );
  }
}


   


