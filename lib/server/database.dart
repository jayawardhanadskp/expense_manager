import 'package:hive/hive.dart';

import '../model/expence.dart';

class Database {

  // create a database reference
  final _muBox = Hive.box('expenseDatabase');

  List<ExpenceModel> expenceList = [];

  // create the init expence list function
  void createInialDatabase() {
    expenceList = [
      ExpenceModel(
        amount: 12.5,
        date: DateTime.now(),
        title: 'Carrot',
        category: Category.food,
      ),
      ExpenceModel(
        amount: 10,
        date: DateTime.now(),
        title: 'Football',
        category: Category.leasure,
      ),
      ExpenceModel(
        amount: 10,
        date: DateTime.now(),
        title: 'Football',
        category: Category.leasure,
      ),
    ];
  }

  // load data
  void loadData() {
    final dynamic data = _muBox.get('EXP_DATA');
    
    // validate the data
    if (data != null && data is List<dynamic>) {
      expenceList = data.cast<ExpenceModel>().toList();
    }  
  }

  // update data
  Future <void> updateData() async {
    await _muBox.put('EXP_DATA', expenceList);
    print('data saved');
  }

}