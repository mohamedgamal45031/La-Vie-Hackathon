class UserModel {
    String? type;
    String? message;
    UserData? user;

    UserModel({
     this.type,
     this.message,
     this.user
  });

    UserModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
     Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class UserData {
    String? id;
    String? firstName;
    String? lastName;
    String? email;
    String? imageUrl;

    UserData({required this.id,required this.firstName,required this.lastName,required this.email,required this.imageUrl});

    UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}