import 'package:bany/event/bloc_Event.dart';
import 'package:bany/models/person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/listData.dart';

class UpdateData extends StatelessWidget {
  String? id, ten, tenJob, mieuTa, urlAnh;

  UpdateData(this.id, this.ten, this.tenJob, this.mieuTa, this.urlAnh);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController(text: ten);
    TextEditingController jobTitle = TextEditingController(text: tenJob);
    TextEditingController message = TextEditingController(text: mieuTa);
    TextEditingController imageUrl = TextEditingController(text: urlAnh);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Your ID: ${id} '),
            TextField(
              decoration: InputDecoration(hintText: ' Name'),
              controller: name,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Job Title'),
              controller: jobTitle,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Message'),
              controller: message,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Image Url'),
              controller: imageUrl,
            ),
            ElevatedButton(
                onPressed: () async {
                  Person per = Person(
                      id: id,
                      findName: name.text,
                      jobTitle: jobTitle.text,
                      jobDescrip: message.text,
                      avatar: imageUrl.text);
                  var provider = Provider.of<BlocEven>(context,listen: false);
                  await provider.updateData(id.toString(), per);
                  if(provider.isBack){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListData(),));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated')));
                  }
                },
                child: Text('Update')),
          ],
        ),
      ),
    );
  }
}
