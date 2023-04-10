import 'package:flutter/material.dart';

class SellItem extends StatefulWidget {
  const SellItem({super.key});

  @override
  State<SellItem> createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  List<String> _categoryList = <String>["Mobile", "Stationary", "Grocery","Vehicle"];
  String _category = 'Mobile';

  List<String> _location = <String>["Kathmandu", "Lalitpur", "Bhaktapur"];
  String _choosedLocation = 'Kathmandu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Item Details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 152,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 95,
                              width: 95,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 95,
                              width: 95,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                        SizedBox(height: 9),
                        Text('Tap on images to add or delete them'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Category*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          value: _category,
                          items: _categoryList
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _category = val.toString();
                            });
                          }),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Description',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  height: 95,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration:
                          InputDecoration.collapsed(hintText: 'Description'),
                    ),
                  ),
                ),
                 SizedBox(height: 16),
                Text('Condition*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                          ),
                          onPressed: (){}, 
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('New',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                            ),
                          )),
                        SizedBox(width: 10,),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green[200]),
                          ),
                          onPressed: (){}, 
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Used',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            ),
                          )),

                      ],
                    ),
            
                SizedBox(height: 16),
                Text('Price*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                    
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration.collapsed(hintText: 'Price'),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Location*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          value: _choosedLocation,
                          items: _location
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _choosedLocation = val.toString();
                            });
                          }),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    
                    onPressed: (){}, 
                    child: Center(child: Text('Post Now',
                          style:TextStyle(
                            fontSize: 18,
                            color: Colors.black,

                          )                    
                    ))
                    ),
                )
              ],
            ),
          ),
        ));
  }
}
