import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PDFScreen(),
    );
  }
}

class PDFScreen extends StatefulWidget {
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final TextEditingController textController = TextEditingController();


  Future<void> saveAsPDF() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document();

    // إضافة صفحة جديدة للمستند
    pdf.addPage(pw.Page(
      // بناء محتوى الصفحة
      build: (pw.Context context) {
        // يتم وضع النص المدخل في وسط الصفحة
        return pw.Center(
          child: pw.Text(textController.text),
        );
      },
    ));

    // الحصول على مسار مجلد Documents على الجهاز
    final directory = await getApplicationDocumentsDirectory();

    // إنشاء ملف PDF باسم example.pdf داخل مجلد Documents
    final file = File('${directory.path}/example.pdf');

    // كتابة البيانات كملف PDF
    await file.writeAsBytes(await pdf.save());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save as PDF Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: const  InputDecoration(hintText: 'Enter text to save as PDF'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveAsPDF();
              },
              child: const Text('Save as PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
