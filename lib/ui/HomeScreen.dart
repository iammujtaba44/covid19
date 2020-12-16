import 'package:covid19/services/database.dart';
import 'package:covid19/services/models/DataModel.dart';
import 'package:covid19/ui/DetailsView.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataBase ds = DataBase();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
        stream: ds.userStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          DataModel dm = snapshot.data;
          //  print(dm.global.newConfirmed);
          return Container(
            height: _height,
            width: _width,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: _height * 0.06,
                          left: 10,
                          right: 10,
                          bottom: 10.0),
                      child: Row(children: [
                        Text(
                          'WORLD',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text('${dm.global.totalConfirmed}',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold))
                      ]),
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Column(
                        children: List.generate(dm.countries.length, (index) {
                      return getWidget(
                          country: dm.countries[index], height: _height);
                    }))
                  ]),
            ),
          );
        },
      ),
    );
  }

  Widget getWidget({Country country, double height}) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(
          top: height * 0.01,
          left: 10,
          right: 10,
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
}
