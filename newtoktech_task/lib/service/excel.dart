import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:newtoktech_task/service/firestore.dart';

class ExcelService {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<Map<String, String>>> parseExcel(PlatformFile file) async {
    try {
      var bytes = file.bytes;
      if (bytes == null) throw Exception('File bytes are null');
      
      var excel = Excel.decodeBytes(bytes);
      List<Map<String, String>> data = [];

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]?.rows ?? []) {
          var entry = {
            'country': row[0]?.toString() ?? '',
            'state': row[1]?.toString() ?? '',
            'district': row[2]?.toString() ?? '',
            'city': row[3]?.toString() ?? '',
          };
          data.add(entry);

          await _firestoreService.addLocation(entry);
        }
      }
      return data;
    } catch (e) {
      print('Failed to parse Excel file: $e');
      throw e;
    }
  }
}
