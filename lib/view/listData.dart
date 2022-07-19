import 'package:bany/view/infoData.dart';
import 'package:bany/event/bloc_Event.dart';
import 'package:bany/models/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bany/bloc/create_Logic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListData extends StatefulWidget {
  ListData({Key? key}) : super(key: key);

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Person> listPerson = [];
  List<Person> searchPerson = [];
  TextEditingController controller = TextEditingController();
  Icon customIcon = Icon(Icons.search);
  Widget customSearcBar = Text(
    'DEMO FAKE BANYYY',
    style: TextStyle(fontSize: 20),
  );

  @override
  void initState() {
    final getProvider = Provider.of<BlocEven>(context, listen: false);
    getProvider.getPostData();
    super.initState();
  }

  Future refresh() async {
    final getProvider = Provider.of<BlocEven>(context, listen: false);
    await getProvider.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: customSearcBar,
              actions: [
                IconButton(
                    onPressed: () {
                      controller.clear();
                      setState(() {
                        if (this.customIcon.icon == Icons.search) {
                          this.customIcon = Icon(Icons.cancel);
                          this.customSearcBar = TextField(
                            controller: controller,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            decoration:
                                InputDecoration(hintText: 'Search BANY here'),
                          );
                        } else {
                          this.customIcon = Icon(Icons.search);
                          this.customSearcBar = Text('DEMO FAKE BANYYY');
                        }
                      });
                    },
                    icon: customIcon)
              ],
            ),
            body: Center(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: Consumer<BlocEven>(
                    builder: (_, BlocEven, __) => BlocEven.loading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            itemCount: BlocEven.listP.length,
                            itemBuilder: (_, index) {
                              Person person = BlocEven.listP[index];
                              return Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                secondaryActions: [
                                  IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text('Message'),
                                                  content: Text(
                                                      'Do you want Delete?',
                                                      style: TextStyle(
                                                          fontSize: 25)),
                                                  actions: [
                                                    FlatButton(
                                                        onPressed: () {
                                                          BlocEven.deleteData(
                                                              person.id
                                                                  .toString());
                                                          BlocEven.reloadData();
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      'Deleted: ${person.findName}')));
                                                        },
                                                        child: Text(
                                                          'YES',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('No',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)))
                                                  ],
                                                ));
                                      })
                                ],
                                child: Container(
                                  width: double.infinity,
                                  height: 90,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: Colors.green, width: 2)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => InfoData(
                                                    person.id.toString(),
                                                    person.findName.toString(),
                                                    person.jobTitle.toString(),
                                                    person.jobDescrip
                                                        .toString(),
                                                    person.avatar.toString()),
                                              ));
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 6,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      '${person.avatar.toString()}',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Expanded(
                                                  flex: 15,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Name: ${person.findName}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        'Job: ${person.jobTitle}',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              );
                            })),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateData(),
                    ));
              },
              child: Icon(Icons.add),
              tooltip: 'add',
            )));
  }
}
