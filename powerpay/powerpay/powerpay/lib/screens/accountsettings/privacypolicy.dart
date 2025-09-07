import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:powerpay/screens/splashscreen/splashscreen.dart';
import 'package:powerpay/util/assetdata.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicy();
}

class _PrivacyPolicy extends ResumableState<PrivacyPolicy> {

  @override
  void onResume() {
    // Implement your code inside here
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash(mode:1)));
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
        title: Text("Privacy Policy", style: GoogleFonts.figtree(textStyle: TextStyle( fontSize: adjustResolution(context, Resolution.normal.index, 16), fontWeight: FontWeight.w600, color: buttonColor))),
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

1. INTRODUCTION

1.1. We, PowerPay Sdn Bhd (Company No. 20202324H) (the “Company”) is committed to protect the privacy and security of any personal data that you may provide, and strive to provide a safe and secure user experience.

1.2. This privacy policy (this “Privacy Policy”) governs the use of the services provided by us and is intended to explain our existing policies and practices with regards to the collection, use, disclosure and protection of your personal information that you may submit/provide to us. The services provided by us include, but not limited to, services provided via our online platform at www.powerpay. The personal data that may be provided to us includes your name, e-mail address, phone number, personal information which that can be linked or directed to you and other non-public information that is associated with the foregoing (“Personal Data”).

1.3. By accessing or otherwise using our Platform, you agree to the terms and conditions of this Privacy Policy, which is incorporated into and forms a part of our terms of service you expressly consent to the processing of your Personal Data according to this Privacy Policy.

1.4. Your Personal Data will be processed and stored in Malaysia, and governed by the Personal Data Protection Act 2010 (“PDPA”). Your Personal Data will not be used or disclosed for purposes for which you have not given consent or which are not permitted under applicable law.

2. COLLECTION OF INFORMATION AND DOCUMENTS

2.1. In general, we collect Personal Data that you submit to us voluntarily in the course of your present or future dealings with the Company on the Platform, its subsidiary, holding company or associated company. For avoidance of doubt, any reference to “We”, “Our” “Us” or “Company” in this Privacy Policy shall include any member of the Company.
  
2.2. We may obtain your Personal Data through your participation in certain parts of the Platform, through the use of cookies and from other sources with which you have expressly consented to. We may also request further information, documents, photograph and live videos through your participation on the Platform, either via the website, mobile application or electronic mail.
  
2.3. As you use the Platform, certain information may also be passively collected and stored on our or our service providers’ server logs, including your Internet protocol address.
  
2.4. We will collect your Personal Data when you:\n
\t\t\t\t\t(a) use the service provided on the Platform;
\t\t\t\t\t(b) provide comments or submit a problem to us;
\t\t\t\t\t(c) request information from us and provide your name or return contact information;
\t\t\t\t\t(d) join any contests or surveys organized by us;
\t\t\t\t\t(e) register an account with us either through manual registration or by connecting your social media accounts such as Google or Facebook;
\t\t\t\t\t(f) making an application or executing a contract on the Platform; and
\t\t\t\t\t(g) have given consent to a third party connected to you, such as your family members, employees, joint account holders, guarantors and such other persons to disclose information relating to you.

2.5. We may process Personal Data such as:\n
\t\t\t\t\t(a) identification details and documents including but not limited to your name, date of birth, nationality, identity card or passport number;
\t\t\t\t\t(b) contact information such as your address, mobile number, and e-mail address;
\t\t\t\t\t(c) financial information such as your occupation, bank account statement and salary slip for the purpose of establishing your financial standing and creditworthiness;
\t\t\t\t\t(d) information required for the purpose of entering into any agreement between you and other users or third parties;
\t\t\t\t\t(e) conversations between you and other users;
\t\t\t\t\t(f) user behaviour such as information about what you search or read on the Platform;
\t\t\t\t\t(g) information generated from your participation in our survey or interaction with us in various other ways, such as demographic information, your comments, feedback, question or suggestions and information about a subject that may interest you;
\t\t\t\t\t(h) information such as your device ID and your location when you use the Platform;
\t\t\t\t\t(i) social media profile data such as your username, profile picture, profile ID and photo;
\t\t\t\t\t(j) your content related to the Platform such as your testimonial, review etc.;
\t\t\t\t\t(k) your activities through the Platform and various analytics;
\t\t\t\t\t(l) transactional history in order to document a transaction you may have had with us or other users; and
\t\t\t\t\t(m) information collected through the use of Cookies (as defined below).

2.6. Some of the information collected by us may not be explicitly submitted by you as we also automatically receive and record information on our server logs from your browser, including your IP address, cookie information, the web pages you request, your browser type and language, access times, and the referring website address.

3. PURPOSE OF PERSONAL DATA COLLECTED

3.1. In general, other than providing you with the services and other services incidental or related to the services, we may collect and process the Personal Data provided to us for the following purposes:

\t\t\t\t\t(a) to verify your identity and any and all information provided by you;
\t\t\t\t\t(b) to communicate with you;
\t\t\t\t\t(c) to respond to your enquiries;
\t\t\t\t\t(d) to process and manage the use of the services;
\t\t\t\t\t(e) to manage, verify and complete transactions with you;
\t\t\t\t\t(f) to provide our products/services to you;
\t\t\t\t\t(g) to provide you with information and updates on our services;
\t\t\t\t\t(h) research purposes including historical and statistical purposes;
\t\t\t\t\t(i) to create personalized promotions by combining your Personal Data with non-personal information about you;
\t\t\t\t\t(j) to process your payment transactions;
\t\t\t\t\t(k) for our credit control service and/or collection of debts due and owing to us;
\t\t\t\t\t(l) for general operation and maintenance of the Platform, and processing of personal data including audit, archival storage, data entry service providers, computer backup services, and disaster recovery services;
\t\t\t\t\t(m) to provide you with regular communications (other than direct marketing materials) from us relating to the services; and
\t\t\t\t\t(n) to enforce any Terms of Service between us;
\t\t\t\t\t(o) to comply with any regulatory, statutory or legal obligation imposed on us by any relevant authority;
\t\t\t\t\t(p) for investigation of complaints, suspected suspicious transactions and research for service improvement;
\t\t\t\t\t(q) to provide, maintain, protect and improve the services, to develop new services, and to protect ourselves and our users; and
\t\t\t\t\t(r) any other purposes required to operate and maintain our business.

3.2. Except as otherwise stated in this Privacy Policy, we do not sell, trade, rent, or otherwise share for marketing purposes any of your Personal Data to any third party, unless you authorize us to do so.

3.3. The Personal Data shall be processed only for the utilization of the Company and its verified strategic partners, for the purposes set forth hereinabove in accordance with the terms and conditions set out herein and in compliance with, to the extent permitted by the applicable laws and regulations in Malaysia.

4. DISCLOSURE OF PERSONAL DATA

4.1. We may share your Personal Data with:

\t\t\t\t\t(a) your immediate family members, successors in title to us and/or emergency contact person as may be notified to us from time to time;
\t\t\t\t\t(b) other users of the Platform for the purposes of negotiation or when the both of you enter into a transaction;
\t\t\t\t\t(c) our subsidiaries, associated, affiliated and group companies that are under a common control, in relation to the provision of products/services or for the purposes of developing or marketing new products, services or platforms that are developed by our related companies and informing you of such new products, services or platforms;
\t\t\t\t\t(d) service providers under contract who are appointed by us to help with our business operations on a strictly confidential basis (including, merchants, partners, fraud investigations, bill collection, monitoring of user behavior, the processing of payments for any products or services, debt collection agencies, legal advisors, accountants and auditors);
\t\t\t\t\t(e) third parties (including those overseas) who provide data processing services; and
\t\t\t\t\t(f) any person, who is under a duty of confidentiality to which has undertaken to keep such data confidential, which we have engaged to fulfill our obligations to you.

4.2. We post testimonials on our Platform that may contain your personal information such as your name and profile picture. We will obtain your consent to use your name, profile picture and testimonial prior to posting a testimonial on the Platform. If you subsequently wish to update, or delete your testimonial, please contact us and indicate your name, testimonial location, and contact information in order for us to further proceed with your request.

4.3. We may, as permitted by applicable law, disclose your Personal Data if we believe in good faith that such disclosure is necessary to:

\t\t\t\t\t(a) comply with relevant laws or government’s order or to respond to subpoenas or warrants served on us;
\t\t\t\t\t(b) oblige to investigation of fraud, infringement, piracy, tax avoidance and evasion or other unlawful activity and you expressly authorize us to make such disclosures; or
\t\t\t\t\t(c) to protect and defend our rights or property, you, or third parties.

4.4. If we are merged or acquired by another entity, Personal Data may be transferred to that entity as a part of the merger or acquisition. We will disclose your Personal Data to third parties for legal reasons or in the context of an acquisition or a merger.

4.5. You are also aware and agree that we may extract from and share your Personal Data with credit reporting agencies for the purposes of processing your credit information including CCRIS, CTOS and cheque details from Bank Negara Malaysia. We may also share your Personal Data with debt collecting agencies in the event of a default in any payment. Such credit reporting agencies and debt collectors are third parties that we engage to help us to verify your creditworthiness or to collect outstanding payments.

4.6. You hereby acknowledge that such disclosure and transfer may occur and permit us to disclose and transfer your Personal Data to such third party and its advisors/representatives and/or any other person reasonably requiring the same in order for us to operate and maintain our business or carry out the activities set out in the purposes. Except in situations where you have given your consent, we do not license or sell your Personal Data to third party companies for their own marketing purposes. Their identity will be disclosed at the time your consent is sought.

4.7. The Platform may contain links to other third-party websites (“Linked Sites”) and some of your Personal Data may be made public. We are not responsible for the privacy policies or practices or the content of such other Linked Sites. Those websites do not operate under this Privacy Policy and therefore, we are not responsible or liable for the privacy policy in regard to any collection, usage, maintenance and/or sharing of Personal Data of such Linked Site. You hereby agree to waive any claim against the Company with respect to the Linked Sites.
  
5. RETENTION OF PERSONAL DATA

5.1. The Personal Data is collected to provide you access to, process orders for our services, improve, better tailor the features, performance, and support of our Platform and to offer you additional information, opportunities, promotions and functionality from us.

5.2. We will keep any Personal Data you provide/submit to us to comply with the relevant personal data protection laws and regulations in Malaysia.

6. PERSONAL DATA FROM OTHER INDIVIDUALS

6.1. To the extent that you have provided (or will provide) Personal Data about your family, spouse and/or other dependents, you confirm that:

\t\t\t\t\t(a) the other person has appointed you to act on his/her behalf and has agreed that you can give consent on his/her behalf to the processing (including disclosure and transfer) of his or her Personal Data in accordance with this Privacy Policy;
\t\t\t\t\t(b) in respect of individuals under 18 years of age (“Minor”) or individuals not legally competent to give consent, they have appointed you to act for them, to consent on their behalf to the processing (including disclosure and transfer) of his or her Personal Data in accordance with this Privacy Policy;
\t\t\t\t\t(c) you have explained to them that their Personal Data will be provided to, and processed by us;
\t\t\t\t\t(d) receive in his or her behalf any data protection notices; and
\t\t\t\t\t(e) you have obtained his/her consent for us to store his or her Personal Data or have the right to allow us to process his or her Personal Data.
  
7. TRANSFER OF PERSONAL DATA

The Personal Data may be transferred, stored and processed outside Malaysia in the course of the Company’s business operation, in connection with the purposes set out in this Privacy Policy. Besides that, your Personal Data may be disclosed or transferred to entities located outside Malaysia or where you access the Platform from countries outside Malaysia. For this reason, you hereby expressly consent to us to transfer your Personal Data to other countries that may have different laws and data protection compliance requirements to those that apply in Malaysia for such purpose. We shall endeavour to ensure that reasonable steps are taken to procure that all such third parties outside of Malaysia shall not use your Personal Data other than for that part of the purposes set out in this Privacy Policy and to adequately protect the confidentiality and privacy of yourPersonal Data.

8. DATA SUBJECT’S OBLIGATIONS
  
8.1. It is necessary for us to collect and retain customers/clients’ Personal Data as accurate, complete, not misleading, up-to-date and reliable as possible. Therefore, you shall have the obligation to supply Personal Data to us in the most accurate manner. If you do not provide us with Personal Data, we are unable to process Personal Data on your behalf, for the purpose stated herein, or effectively render our services to you, and all relationships created or to be created between us shall then be terminated and ceased to be in effect immediately.
  
8.2. You shall promptly update us as and when such Personal Data provided earlier to us becomes inaccurate, incomplete, misleading, outdated or changes in any way whatsoever by contacting us at the contact details below.
  
9. CONFIDENTIALITY
  
The Personal Data held by us shall be treated and kept confidential, in accordance with this Privacy Policy, Personal Data Protection Act 2010 and with all applicable personal data protection laws and regulations in Malaysia that may from time to time be in force.
  
10. STORAGE SECURITY & PERSONAL DATA PROTECTION
  
10.1. Strict procedures and security features will be adhered in order to prevent unauthorized access wherever possible. Personal Data provided to us via our Platform is protected during transit using encryption software and strict security standards. When Personal Data is stored by us, we endeavour, where applicable, to use appropriate security measures in accordance with the applicable laws and regulations and industry standard to protect the Personal Data from the unauthorized or unlawful access, modification or disclosure. The level of security of Personal Data which kept in a non-electronic environment are also treated with strict procedures and means.
  
10.2. However, the transmission of information via the Internet is, unfortunately, not completely secure. We endeavour to protect your Personal Data, but we cannot guarantee the security of the Personal Data during transmission through our Platform. Any transmission is at your own risk and the Company does not guarantee unauthorized or accidental access to the Personal Data that is beyond ourreasonable control.

10.3. The Company shall not be held liable nor responsible for any information and/or contents that have been revealed and/or abused at large and/or already within public knowledge and for any risks and/or occurrences by publishing any of the contents and information given herein.

10.4. Once we have received your information, we will use strict security procedures with regards to the Platform to prevent unauthorised access.

10.5. You shall have the obligation to ensure that your password is secure and never reveal your password to anyone else. You are responsible for keeping this password confidential and for any use of your account. You should also make use of any privacy settings or controls we provide you in our Platform.

11. USE OF COOKIES

11.1. “Cookies” are data files that may be downloaded to your computer when you use the Platform and permit the Platform to identify your computer whenever you use the Platform. We use Cookies to recognize repeat use by users of the Platform and to collect information about our users’ interactions with the Platform. These Cookies contain identification information that enables us to streamline your experiences using the Platform. In addition, Cookies are of a temporary nature, used solely to improve the efficiency of the last transmission. Users may configure their browser to notify them of the reception of Cookies and to prevent their installation on their computer.

11.2. We may also use small pieces of code called “web beacons” or “clear gifs” to collect anonymous and aggregate advertising metrics, such as counting page views, promotion views, or advertising responses. A web beacon is an electronic image called a single-pixel or clear GIF. Web beacons can recognize certain types of information, such as a user’s cookie number, time and date of a page view, and description of the page where the web beacon is placed. These web beacons may be used to deliver cookies that conform to our cookie policy.

11.3. The Cookies used by the Platform are solely associated to anonymous users and their computers and all such information collected through Cookies is not Personal Data and you cannot be identified from this information. Some Cookies are used by third parties to provide us with data on the effectiveness of its engagements and promotions.

11.4. The Cookies used by the Platform do not in any way record Personal Data that could be used to identify a specific user permanently and are not stored on your computer’s hard drive.

12. CONSENT AND RIGHTS

12.1. You are accorded with rights stipulated in the PDPA and any Personal Data provided by you shall be protected according to the PDPA.

12.2. Subject to the exceptions provided under the PDPA, you have the rights to request for access to Personal Data processed by us on with reasonable notice and request for correction and/or update of the source of your Personal Data that is inaccurate, incomplete or outdated. The Company reserves the right to charge a prescribed fee (such amount as permitted by the PDPA) to cover the administration costs incurred in processing your request to access your Personal Data.

12.3. Your right to request for access to Personal Data is limited to the Personal Data that you have provided to us and is processed based on your consent. It does not cover Personal Data that we may have received on the other grounds or from other sources.

12.4. In respect of your right to access and/or correct your Personal Data, we have the right to withhold or refuse your request to access and/or correct your Personal Data for the reasons permitted under the law.

12.5. You are entitled to limit our processing of Personal Data by expressly withdrawing the consent given previously for future marketing communication, through notice in writing to inform us subject to any applicable legal restrictions, contractual conditions and within a reasonable duration of time for the withdrawal of consent to be affected. However, such withdrawal of consent could result in certain legal consequences arising from such withdrawal. In this regard, depending on the extent of your withdrawal of consent for us to process your Personal Data, it may mean that we will not be able to continue with your existing relationship with us and/or the account you have registered with us will have to be deleted.

13. CONSEQUENCES OF NOT CONSENTING TO THIS POLICY 

The collection of your Personal Data by us may be mandatory or voluntary in nature depending on the purposes for which your Personal Data is collected. Where it is obligatory for you to provide us with your Personal Data, and you fail or choose not to provide us with such data, or do not consent to the above or this Privacy Policy, we will not be able to provide products and/or services or otherwise deal with you.

14. MINOR’S PRIVACY

14.1. Our Platform is not intentionally designed for or directed to any Minor (i.e. individuals under 18 years of age).

14.2. We do not and will not knowingly collect Personal Data from any Minor. If you are a parent or guardian and you are aware that your Minor has provided us with any Personal Data, please contact us immediately. If we become aware that we have collected Personal Data from any Minor without verification of parental consent, we will take necessary steps to remove all information relating to such Minor from our storage facilities and servers.

16. LANGUAGE

In accordance with Section 7(3) of the PDPA, this Privacy Policy is issued in both English and Bahasa Malaysia. In case of any discrepancy between the English version and the Bahasa Malaysia version of this Privacy Policy, the English version shall prevail.

17. CHANGES TO PRIVACY POLICY

17.1. We reserve the right to amend or revise this Privacy Policy from time to time without any prior notice to you. Any changes to this Privacy Policy will be uploaded on the Platform at www.powerpay.my. Once posted, the amended and restated Privacy Policy will become immediately effective unless otherwise specified. Any amendment to this Privacy Policy will have a prospective effect.

17.2. If you do not agree to the latest new changes in our Privacy Policy, you must notify us in writing and cease using our Platform. Any further use shall indicate your acknowledgement of such changes and agreement to be bound by the terms and conditions of such changes.

17.3. If we amend this Privacy Policy, the amendment will only apply to Personal Data collected after we have posted the revised Privacy Policy.

17.4. We are committed to comply with the PDPA, in particular, its policies as well as corresponding guidelines and orders.

18. ACKNOWLEDGMENT AND CONSENT

By communicating, engaging with the Company or using the Company’s products and services, you acknowledge that you have read and understood this Privacy Policy and agree and consent to the use, processing, disclosure and transfer of your Personal Data by the Company as described in this Privacy Policy. Any email sent to you from Company will contain an automated unsubscribe link so that you can opt-out of the mailing list.

Last Update: [**]

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


   


