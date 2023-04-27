import 'package:app_1/Screens/donationCampaign.dart';
import 'package:app_1/Screens/donationDetail.dart';
import 'package:app_1/models/donationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Donation extends StatefulWidget {
  final User? firebaseUser;

  const Donation({super.key, required this.firebaseUser});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  Future<List<Campaign>>? campaignFuture;
  @override
  void initState() {
    super.initState();
    campaignFuture = getCampaigns();
  }

  Future<List<Campaign>> getCampaigns() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    List<Campaign> campaign = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Campaigns').get();

    for (var element in snapshot.docs) {
      campaign.add(Campaign.fromMap(element.data() as Map<String, dynamic>));
    }

    return campaign;
  }

  List<String> images = [
    'images/donation/donation1.jpg',
    'images/donation/donation2.jpg',
    'images/donation/donation3.jpg',
    'images/donation/donation4.jpg',
    'images/donation/donation5.jpg',
    'images/donation/donation6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: const Text('Upcoming Events',
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/donation/donation.png'),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                const Positioned(
                    left: 40,
                    top: 50,
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Help world by \n",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "donating",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      )
                    ]))),
                Positioned(
                  left: 35,
                  bottom: 35,
                  child: Container(
                    height: 55,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DonationCampaign(
                                      firebaseUser: widget.firebaseUser))));
                        },
                        child: const Text('Start Campaign',
                            style: TextStyle(
                              color: Colors.black,
                            ))),
                  ),
                ),
              ],
            ),
            ListDisplay(campaignFuture),
            const SizedBox(height: 32),
          ],
        ));
  }

  FutureBuilder<List<Campaign>> ListDisplay(total) {
    return FutureBuilder(
        future: total,
        builder:
            (BuildContext context, AsyncSnapshot<List<Campaign>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            List<Campaign> campaign = snapshot.data!;
            return Expanded(
              child: SizedBox(
                width: 350,
                child: ListView.builder(
                  itemCount: campaign.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DonationBox(context,
                        campaign: campaign[index], images: images[index]);
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              ),
            );
          }
        });
  }
}

DonationBox(context, {required Campaign campaign, required String images}) {
  String? CampaignName = campaign.CampaignName;
  return Padding(
    padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(images), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(35)),
          ),
        ),
        Positioned(
          left: 80,
          bottom: -35,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
            child: Container(
              height: 120,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(35)),
              child: Stack(
                children: [
                  Positioned(
                    left: 35,
                    top: 30,
                    child: Container(
                      height: 28,
                      width: 160,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '$CampaignName',
                          style: const TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 73,
                    child: Container(
                      height: 25,
                      width: 70,
                      color: Colors.white,
                      child: const Text(
                        'Join Us',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 122,
                    top: 65,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [BoxShadow(blurRadius: 5)]),
                        child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DonationDetail(
                                                campaign: campaign,
                                                image: images,
                                              )));
                                },
                                icon: const Icon(
                                  Icons.arrow_right_alt,
                                )))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
