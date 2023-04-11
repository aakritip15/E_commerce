class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdOn;

  MessageModel({this.messageId, this.sender, this.text, this.createdOn, this.seen});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map['messageId'];
    sender = map['sender'];
    text = map['text'];
    createdOn = map['createdOn'].toDate();
    seen = map['seen'];
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId':messageId,
      'sender': sender,
      'text': text,
      'createdOn': createdOn,
      'seen': seen,
    };
  }
}
