import 'package:flutter/material.dart';

class NewVendor extends StatefulWidget {
  @override
  _NewVendorState createState() => _NewVendorState();
}

class _NewVendorState extends State<NewVendor> {
  bool vselect = true;
  bool gselect = false;
  bool mselect = false;
  bool dselect = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                'Welcome NAME,',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Your Shop Name :',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter a name...',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Shop Type,',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: ListTile(
                  onTap: () {
                    setState(() {
                      vselect = !vselect;
                    });
                  },
                  leading: Icon(
                    Icons.shopping_basket,
                    size: 60,
                  ),
                  title: Text(
                    'Vegetable Shop',
                    style: TextStyle(fontSize: 24),
                  ),
                  selected: vselect,
                  enabled: true,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: ListTile(
                  onTap: () {
                    setState(() {
                      gselect = !gselect;
                    });
                  },
                  leading: Icon(
                    Icons.shopping_cart,
                    size: 60,
                  ),
                  title: Text(
                    'Grossary Shop',
                    style: TextStyle(fontSize: 24),
                  ),
                  selected: gselect,
                  enabled: true,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: ListTile(
                  onTap: () {
                    setState(() {
                      mselect = !mselect;
                    });
                  },
                  leading: Icon(
                    Icons.local_hospital,
                    size: 60,
                  ),
                  title: Text(
                    'Medical Shop',
                    style: TextStyle(fontSize: 24),
                  ),
                  selected: mselect,
                  enabled: true,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: ListTile(
                  onTap: () {
                    setState(() {
                      dselect = !dselect;
                    });
                  },
                  leading: Image(
                    image: NetworkImage(
                        'https://static.thenounproject.com/png/79356-200.png'),
                    color: dselect ? Colors.orange : Colors.black,
                  ),
                  title: Text(
                    'Diary Shop',
                    style: TextStyle(fontSize: 24),
                  ),
                  selected: dselect,
                  enabled: true,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: screenWidth * .9,
                  height: 55,
                  color: Colors.blueAccent,
                  elevation: 4.0,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
