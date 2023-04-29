class Campaign {
  String? uid;
  String? cid;
  String? CampaignName;
  String? CampaignDetail;
  String? CampaignDate;
  String? CampaignVenue;
  String? ContactInformation;

  Campaign(
      {this.uid,
      this.cid,
      this.CampaignName,
      this.CampaignDetail,
      this.CampaignDate,
      this.CampaignVenue,
      this.ContactInformation});

  Campaign.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    cid = map["cid"];
    CampaignName = map["CampaignName"];
    CampaignDetail = map["CampaignDetail"];
    CampaignVenue = map["CampaignVenue"];
    CampaignDate = map["CampaignDate"];
    ContactInformation = map["ContactInformation"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid":uid,
      "cid":cid,
      "CampaignName": CampaignName,
      "CampaignDetail": CampaignDetail,
      "CampaignDate": CampaignDate,
      "CampaignVenue": CampaignVenue,
      "ContactInformation": ContactInformation,
    };
  }
}
