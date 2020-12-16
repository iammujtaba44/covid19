import 'package:covid19/utils/ProjectTheme.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatefulWidget {
  final data;
  DetailsView({this.data});
  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBAr(height: _height),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Container(
          height: _height,
          width: _width,
          child: Column(children: [
            getRow(
                ft: 'TOTAL CASES',
                fText: widget.data['tCases'],
                st: 'TOTAL DEATHS',
                sText: widget.data['tDeaths'],
                width: _width * 0.22),
            SizedBox(
              height: _height * 0.04,
            ),
            getRow(
                ft: 'NEW CASES',
                fText: widget.data['nCases'],
                st: 'NEW DEATHS',
                sText: widget.data['nDeaths'],
                width: _width * 0.25),
            SizedBox(
              height: _height * 0.04,
            ),
            getRow(
                ft: 'NEW RECOVERED',
                fText: widget.data['nRecovered'],
                st: 'TOTAL RECOVERED',
                sText: widget.data['tRecovered'],
                width: _width * 0.17),
          ]),
        ),
      ),
    );
  }

  Widget getRow(
      {String ft, String st, String fText, String sText, double width}) {
    return Row(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '${ft}',
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '${fText}',
          style: TextStyle(
              color: Colors.black54,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        )
      ]),
      SizedBox(
        width: width,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '${st}',
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '${sText}',
          style: TextStyle(
              color: Colors.black54,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        )
      ]),
    ]);
  }

  myAppBAr({double height}) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Ptheme.primaryThemeColor,
      toolbarHeight: height * 0.4,
      leading: SizedBox(),
      flexibleSpace: Stack(
        children: [
          Center(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.data['cName']}',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'CORONA STATS OVERVIEW',
                      style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, left: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
