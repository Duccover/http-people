
class Person {
  final String? id, findName, jobTitle, jobDescrip, avatar;

  Person({this.id, this.findName, this.jobTitle, this.jobDescrip, this.avatar});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        id: json['id'],
        findName: json['find_name'],
        jobTitle: json['job_title'],
        jobDescrip: json['job_descrip'],
        avatar: json['avatar']);
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['find_name'] = this.findName;
    data['job_title'] = this.jobTitle;
    data['job_descrip'] = this.jobDescrip;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    return data;
  }
}
