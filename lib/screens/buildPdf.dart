import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:e_bajrai_mini_market/screens/mobile.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildPdf extends StatefulWidget {
  @override
  _BuildPdfState createState() => _BuildPdfState();
}

class _BuildPdfState extends State<BuildPdf> {
  final Uri _url = Uri.parse('https://flutter.dev');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Create Pdf'),
          onPressed: _createPDF,
          // onPressed : () {
          //   launchUrl(Uri.parse('assets/ProjectReport.pdf'));
          // },
        ),
      ),
    );
  }

  Future<void> _createPDF() async {

    OpenFile.open('https://www.kindacode.com/wp-content/uploads/2021/07/test.pdf');

    // PdfDocument document = PdfDocument();
    // document.pages.add();

    // List<int> bytes = document.save();
    // document.dispose();

    // saveAndLaunchFile(bytes, 'Output.pdf');
  }
}

// // main.dart
// import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';


// class BuildPdf extends StatefulWidget {
//   const BuildPdf({Key? key}) : super(key: key);

//   @override
//   State<BuildPdf> createState() => _BuildPdfState();
// }

// class _BuildPdfState extends State<BuildPdf> {
//   bool _isLoading = true;
//   late PDFDocument _pdf;

//   void _loadFile() async {
//     // Load the pdf file from the internet
//     _pdf = await PDFDocument.fromURL(
//         'https://www.kindacode.com/wp-content/uploads/2021/07/test.pdf');

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadFile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Center(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : PDFViewer(document: _pdf)),
//     );
//   }
// }