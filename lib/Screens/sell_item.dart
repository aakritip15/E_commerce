import 'package:flutter/material.dart';

class SellItem extends StatefulWidget {
  const SellItem({super.key});

  @override
  State<SellItem> createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  final _categoryList = <String>["Mobile", "Stationary", "Grocery", "Vehicle"];
  String _category = 'Mobile';

  final _location = <String>["Kathmandu", "Lalitpur", "Bhaktapur"];
  String _choosedLocation = 'Kathmandu';

  bool _isNew = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Item Details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(
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
                            const SizedBox(width: 10),
                            Container(
                              height: 95,
                              width: 95,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        const Text('Tap on images to add or delete them'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Category*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
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
                                    value: e,
                                    child: Text(e),
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
                const SizedBox(height: 16),
                const Text('Description',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                Container(
                  height: 95,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration:
                          InputDecoration.collapsed(hintText: 'Description'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Condition*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              _isNew ? Colors.green[200] : Colors.grey[300]),
                        ),
                        onPressed: () {
                          setState(() {
                            _isNew = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'New',
                            style: TextStyle(
                              color: _isNew ? Colors.black : Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              _isNew ? Colors.grey[200] : Colors.green[300]),
                        ),
                        onPressed: () {
                          _isNew = false;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Used',
                            style: TextStyle(
                              color: _isNew ? Colors.grey : Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Price*',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
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
                      onPressed: () {},
                      child: Center(
                          child: Text('Post Now',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              )))),
                )
              ],
            ),
          ),
        ));
  }
}
