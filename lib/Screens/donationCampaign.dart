import 'dart:math';

import 'package:app_1/Screens/donation.dart';
import 'package:app_1/models/donationModel.dart';
import 'package:app_1/models/firebaseHelper.dart';
import 'package:app_1/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationCampaign extends StatefulWidget {
  final User? firebaseUser;

  const DonationCampaign({super.key, required this.firebaseUser});

  @override
  State<DonationCampaign> createState() => _DonationCampaignState();
}

class _DonationCampaignState extends State<DonationCampaign> {
  TextEditingController campaignName = TextEditingController();

  TextEditingController campaignDetail = TextEditingController();

  TextEditingController campaignDate = TextEditingController();

  TextEditingController campaignVenue = TextEditingController();

  TextEditingController ContactInformation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Campaign name',
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
                    controller: campaignName,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Donate clothes..'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Detail about campaign',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 10),
              Container(
                height: 125,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: campaignDetail,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Detail about campaign'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Event date',
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
                    controller: campaignDate,
                    decoration:
                        const InputDecoration.collapsed(hintText: '2023/02/15'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Event venue',
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
                    controller: campaignVenue,
                    decoration:
                        const InputDecoration.collapsed(hintText: '28 kilo KU'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Contact information',
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
                    controller: ContactInformation,
                    decoration:
                        const InputDecoration.collapsed(hintText: '9841852112'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: () async {
                      Random random = Random.secure();
                      String cid = random.nextInt(7000).toString();
                      UserModel? EventOrganizer =
                          await FirebaseHelper.getUserModelById(
                              widget.firebaseUser!.uid);
                      Campaign campaign = Campaign(
                        uid: widget.firebaseUser!.uid,
                        cid: cid,
                        CampaignName: campaignName.text.toString(),
                        CampaignDetail: campaignDetail.text.toString(),
                        CampaignDate: campaignDate.text.toString(),
                        CampaignVenue: campaignVenue.text.toString(),
                        ContactInformation: ContactInformation.text.toString(),
                      );
                      await FirebaseFirestore.instance
                          .collection('Campaigns')
                          .doc(cid)
                          .set(campaign.toMap())
                          .then((value) =>Navigator.push(context, MaterialPageRoute(builder: (context)=>Donation(firebaseUser: widget.firebaseUser))));
                          
                    },
                    child: const Center(
                        child: Text('Post Campaign',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
