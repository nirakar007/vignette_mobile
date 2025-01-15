import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}vignette_mobile.db';

    Hive.init(path);

    // Register Adapters
    
  }
}
