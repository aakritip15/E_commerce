import 'package:app_1/models/donationModel.dart';
import 'package:flutter/material.dart';

class DonationDetail extends StatefulWidget {
  final Campaign campaign;
  final String image;

  const DonationDetail({Key? key, required this.campaign,required this.image}) : super(key: key);

  @override
  State<DonationDetail> createState() => _DonationDetailState();
}

class _DonationDetailState extends State<DonationDetail> {
  @override
  Widget build(BuildContext context) {
    String CampaignName = widget.campaign.CampaignName.toString();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                    image:  DecorationImage(
                        image: AssetImage(
                            widget.image),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(35)),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    IntrinsicHeight(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const VerticalDivider(
                            color: Colors.black, width: 50, thickness: 4),
                        Text(
                          CampaignName,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.campaign.CampaignDetail.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Event date:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                widget.campaign.CampaignDate.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            width: 30,
                            thickness: 2,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Event venue:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                widget.campaign.CampaignVenue.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            width: 30,
                            thickness: 2,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Contact \ninformation:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                '${widget.campaign.ContactInformation}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
