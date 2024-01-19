import 'package:expence_tracker_app/models/expence.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class Database {
  //create  the database reference
  final _myBox = Hive.box("expenceDatabase");

  List<ExpenceModel> expenceList = [];

  //create the init expence list function
  void createInitialData() {
    expenceList = [
      ExpenceModel(
          id: const Uuid().v4(),
          title: "Pepper",
          amount: 10,
          date: DateTime.now(),
          category: Category.leisure),
      ExpenceModel(
          id: const Uuid().v4(),
          title: "Tomato",
          amount: 15,
          date: DateTime.now(),
          category: Category.work)
    ];
  }

  //load the data
  void loadData() {
    final dynamic data = _myBox.get("EXP_DATA"); // Get the data as dynamic
    if (data != null && data is List<dynamic>) {
      // Check if the data is not null and is a List<dynamic>
      expenceList =
          data.cast<ExpenceModel>().toList(); // Cast it to List<ExpenceModel>
    }
  }

  // update the data
  Future<void> updateData() async {
    await _myBox.put("EXP_DATA", expenceList);

    print("saved data");
  }
}
