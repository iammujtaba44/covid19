import 'package:covid19/services/models/DataModel.dart';
import 'package:http/http.dart' as http;

class DataBase {
  DataModel getdata(qs) {
    return qs.docs.map((ds) {
      return DataModel();
    }).toList();
  }

  Stream<DataModel> get userStream {
    return fetchData().asStream();
    //user.snapshots().map(getuser);
  }

  Future<DataModel> fetchData() async {
    final response = await http.get('https://api.covid19api.com/summary');

    if (response.statusCode == 200) {
      return dataModelFromJson(response.body);
    } else {
      print('Error');
      throw Exception('Failed to load post');
    }
  }
}
