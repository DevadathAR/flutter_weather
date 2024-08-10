import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:newtoktech_task/service/excel.dart';
import 'package:newtoktech_task/screen/user/weather.dart';

class UploadExcelScreen extends StatelessWidget {
  final ExcelService _excelService = ExcelService();

  Future<void> _pickFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
      
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.single;
        print('Picked file: ${file.name}');
        print('File bytes length: ${file.bytes?.length ?? 0}');
        
        if (file.bytes != null) {
          final data = await _excelService.parseExcel(file);
          print('Parsed data: $data');

          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return WeatherReportScreen(); 
            },
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load file bytes')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('No file selected')));
      }
    } catch (e) {
      print('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Excel'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: const Color.fromARGB(255, 165, 198, 255),
        child: Center(
          child: ElevatedButton(
            onPressed: () => _pickFile(context),
            child: const Text('Add file'),
          ),
        ),
      ),
    );
  }
}
