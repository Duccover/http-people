
import 'package:bany/bloc/update_Logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoData extends StatelessWidget {
  String id, ten, tenJob, mieuTa, urlAnh;

  InfoData(this.id,this.ten, this.tenJob, this.mieuTa, this.urlAnh);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              child: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              '${urlAnh.toString()}',
              fit: BoxFit.fill,
            ),
            centerTitle: true,
            title: Text('${ten.toString()}'),
          ),
          actions: [
            IconButton(icon: Icon(Icons.edit),tooltip: 'Edit', onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateData(id, ten, tenJob, mieuTa, urlAnh),));

            },)
          ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
              Container(padding:EdgeInsets.fromLTRB(10,0,0,0),child: Text('Job: ${tenJob.toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.fromLTRB(10,0,0,10),
                child: Text('${mieuTa.toString()}',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900),),
              )
        ]))
      ]))),
    );
  }
}
