import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              fontFamily: 'Times',
              wordSpacing: 0,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kBrown,
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
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
                        width: 70,
                        height: 27,

                        // color: kBlue,
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                            child: Text(
                          'Edit',
                          style: TextStyle(
                            fontFamily: 'Times',
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              const Text(
                'Name',
                style: TextStyle(
                  fontFamily: 'Times',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Username',
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          gapPadding: 4.0,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      //color: Colors.white12,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              const Text(
                'Email',
                style: TextStyle(
                  fontFamily: 'Times',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'username@gmail.com',
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          gapPadding: 4.0,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      //color: Colors.white12,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              const Text(
                'Phone',
                style: TextStyle(
                  fontFamily: 'Times',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: '+977-',
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          gapPadding: 4.0,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      //color: Colors.white12,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              const Text(
                'Address',
                style: TextStyle(
                  fontFamily: 'Times',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Address',
                        filled: true,
                        fillColor: Color(0xffD9D9D9),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          gapPadding: 4.0,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      //color: Colors.white12,
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.0),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {},
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                    child: Text(
                      'Change Now',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
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
