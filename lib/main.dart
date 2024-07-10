import 'package:cashbook_app/core/services/db_helper.dart';
import 'package:cashbook_app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dbHelper = DBHelper();
  await dbHelper.database; // Inisialisasi database
  runApp(const MyApp());
}
