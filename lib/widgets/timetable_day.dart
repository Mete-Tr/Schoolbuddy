import 'package:flutter/material.dart';

class TimetableDay extends StatelessWidget {
  final String day;
  TimetableDay(this.day);

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    print(device.height);

    List<String> list = ['Subjekt'];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.blueGrey),
      ),
      padding: EdgeInsets.all(4),
      width: device.width / 5 - 2,
      // height: device.height,
      child: Column(
        children: <Widget>[
          Text(
            day,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Divider(
            thickness: 2,
            color: Colors.blueGrey,
          ),
          Container(
            width: device.width / 5,
            //TODO height muss variabel sein!
            height: device.height * 0.8141,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                return list.isEmpty
                    ? Center(
                        child: Text(
                          'No data yet',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Card(
                        //... card isnt good at this point
                        elevation: 8,
                        child: Container(
                          width: device.width / 5,
                          child: Column(
                            children: <Widget>[
                              Text(list[i]),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
