import 'package:covid19/services/database.dart';
import 'package:covid19/services/models/DataModel.dart';
import 'package:covid19/ui/DetailsView.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _ctr = TextEditingController();
  var duplicateItems =
      List<Country>(); //List<String>.generate(10000, (i) => "Item $i");
  var items = List<Country>();
  DataBase db = DataBase();

  getData() async {
    DataModel dm = await db.fetchData();
    setState(() {
      dm.countries.forEach((element) {
        duplicateItems.add(element);
      });
      //items.addAll(duplicateItems);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: _height * 0.06,
          left: 10,
          right: 10,
        ),
        child: Column(children: [
          TextFormField(
            onTap: () {
              print('tapped');
            },
            onChanged: (value) {
              filterSearchResults(value.toLowerCase());
            },
            controller: _ctr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            decoration: getSearchDecoration(),
          ),
          Flexible(
            child: Container(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return getWidget(country: items[index], height: _height);
                  }),
            ),
          )
        ]),
      ),
    );
  }

  Widget getWidget({Country country, double height}) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(
          top: height * 0.01,
          left: 20,
          right: 20,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailsView(
                      data: {
                        'cName': country.country,
                        'nCases': country.newConfirmed.toString(),
                        'nDeaths': country.newDeaths.toString(),
                        'nRecovered': country.newRecovered.toString(),
                        'tCases': country.totalConfirmed.toString(),
                        'tDeaths': country.totalDeaths.toString(),
                        'tRecovered': country.totalRecovered.toString(),
                      },
                    )));
          },
          child: Row(children: [
            Text(
              '${country.country}',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            Spacer(),
            Text('${country.totalConfirmed}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
          ]),
        ),
      ),
      Divider(
        thickness: 1.5,
      ),
    ]);
  }

  static getSearchDecoration() {
    return InputDecoration(
      prefixIcon: Icon(
        Icons.search,
        color: Colors.black,
      ),
      fillColor: Colors.grey[250],
      filled: true,
      contentPadding: EdgeInsets.only(top: 5.0),
      hintText: 'Search',
      hintStyle: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.0),
      //  contentPadding: EdgeInsets.all(50.0),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
    );
  }

  void filterSearchResults(String query) {
    List<Country> dummySearchList = List<Country>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<Country> dummyListData = List<Country>();
      dummySearchList.forEach((item) {
        if (item.country.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        //  items.addAll(duplicateItems);
      });
    }
  }
}
