import 'package:flutter/material.dart';
import '/consts/colors.dart';
import '/widgets/customTextFormField.dart';
import '/widgets/myTextField.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: Icon(Icons.arrow_back_rounded),
          backgroundColor: kAlmond,
          foregroundColor: kBrown,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: kBrown,
                        child: Icon(Icons.photo_camera_back_rounded),
                        radius: 60.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //TODO: Add functionality to Edit Button
                      },
                      child: Container(
                        width: 60,
                        height: 25,

                        // color: kBlue,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(child: Text('Edit')),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text('Name'),
              textFieldEditInfo(text: 'username'),
              SizedBox(height: 8.0),
              Text('Email:'),
              textFieldEditInfo(text: 'username@gmail.com'),
              SizedBox(height: 8.0),
              Text('Phone'),
              textFieldEditInfo(text: '+977-'),
              SizedBox(height: 8.0),
              Text('Address:'),
              textFieldEditInfo(text: 'address'),
              SizedBox(height: 15.0),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 15.0),
                    child: Text(
                      'Change Now',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
