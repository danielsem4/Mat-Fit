import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class PDFApi {
  static Future<File> _storeFile(String url,List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes,flush: true);
    return file;
  }



  static Future<File> loadFirebase(String url) async {
    final refPdf = FirebaseStorage.instance.ref().child(url);
    final bytes = await refPdf.getData();

    return _storeFile(url,bytes);
  }
}