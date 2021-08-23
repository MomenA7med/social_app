class MessageModel {
  String senderId;
  String recieverId;
  String dateTime;
  String text;


  MessageModel(this.senderId,this.recieverId,this.dateTime,this.text);

  Map<String,String> toMap(){
    return {
      'senderId' : senderId,
      'recieverId' : recieverId,
      'dateTime' : dateTime,
      'text' : text,
    };
  }

  factory MessageModel.fromMap(Map<String,dynamic> json){
    return MessageModel(json['senderId'],json['recieverId'],json['dateTime'],json['text']);
  }
}