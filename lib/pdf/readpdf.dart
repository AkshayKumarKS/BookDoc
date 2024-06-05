

import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class ReadPdf extends StatefulWidget {
  final String pdfurl;
  const ReadPdf({Key? key, required this.pdfurl}) : super(key: key);

  @override
  State<ReadPdf> createState() => _ReadPdfState();
}

class _ReadPdfState extends State<ReadPdf> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: FutureBuilder<PDFDocument>(
        future: PDFDocument.fromAsset(widget.pdfurl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading PDF: ${snapshot.error}'));
          } else {
            return PDFViewer(document: snapshot.data!);
          }
        },
      ),
    );
  }
}
