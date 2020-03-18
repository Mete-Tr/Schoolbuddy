import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x/database/moor_database.dart';
import 'package:x/provider/homeworkProv.dart';
import 'package:x/widgets/app_drawer.dart';

import 'new_HM_screen.dart';

class Homework extends StatefulWidget {
  static const routhName = '/homeworks';
  @override
  _HomeworkState createState() => _HomeworkState();
}

bool show = false;

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Hausaufgaben'),
        elevation: 0,
        actions: <Widget>[
          Center(child: Text('alle zeigen')),
          Switch(
            value: show,
            onChanged: (val) {
              setState(() {
                show = val;
              });
            },
            activeColor: Colors.white,
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(NewHMScreen.routhName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 5, right: 5),
        child: HomeworkList(),
      ),
    );
  }
}

class HomeworkList extends StatefulWidget {
  @override
  _HomeworkListState createState() => _HomeworkListState();
}

class _HomeworkListState extends State<HomeworkList> {
  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    final dao = Provider.of<HomeworkDataDao>(context);
    final hmProv = Provider.of<HomeworkProv>(context);

    return StreamBuilder(
      stream:
          show == true ? dao.watchAllHomeworks() : dao.watchDoneHomeworks(),
      builder: (context, AsyncSnapshot<List<HomeworkData>> snapshot) {
        final list = snapshot.data ?? List();
        return Container(
          height: device.height,
          child: list.isEmpty
              ? Center(
                  child: Text(
                    'Noch keine Hausaufgaben eingetragen',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, i) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    list[i].title,
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    list[i].task,
                                    style: TextStyle(fontSize: 22),
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 28,
                              ),
                              onPressed: () {
                                hmProv.deleteHomework(list[i], context);
                              },
                            ),
                            Checkbox(
                              value: list[i].done,
                              onChanged: (val) {
                                setState(() {
                                  hmProv.updateHomework(
                                      list[i].copyWith(done: val), context);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
