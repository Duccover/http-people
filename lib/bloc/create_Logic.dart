import 'package:bany/event/bloc_Event.dart';
import 'package:bany/models/person.dart';
import 'package:bany/view/listData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateData extends StatefulWidget {
  const CreateData({Key? key}) : super(key: key);

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  TextEditingController name = TextEditingController();
  TextEditingController job= TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
 String url = '';
 bool _loadingImage = false;
  @override
  Widget build(BuildContext context) {
    void loadImage() {
      _loadingImage = true;
      precacheImage(NetworkImage(url), context,
          onError: (exception, stackTrace){
        setState(() {
          _loadingImage = false;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Bany'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Name'),
                  controller: name,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Job'),
                  controller: job,
                ),

              ],
            ),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Message'),
            controller: desc,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],


                    ),
                    _loadingImage == false
                        ? Positioned(
                            top: 5, left: 5, child: Icon(Icons.image_outlined))
                        : Container(
                            width: 100,
                            height: 100,
                            child: Image(
                              image: NetworkImage(url),fit: BoxFit.cover,
                            ))
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Image Url'),
                    controller:  imageUrl,
                    onChanged: (value){
                      setState(() {
                         url = value;
                         loadImage();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: onPress,
              child: Expanded(child: Container(child: Text('Create'))))
        ],
      ),
    );
  }
  Future<void> onPress() async{
    Person person = Person(findName: name.text,jobTitle: job.text,jobDescrip: desc.text,avatar:imageUrl.text);
    var provider = Provider.of<BlocEven>(context,listen: false);
    await provider.createData(person);
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Create Success')));
    if(provider.isBack){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ListData(),));

    }
  }
}
