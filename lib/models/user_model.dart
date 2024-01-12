class UserModel{
  String id;
  String name;
  int age;
  String email;

UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
  });

UserModel.fromJason(Map<String,dynamic> from):
      this(
  id :from["id"],
  name :from["name"],
  age :from["age"],
  email :from["email"],
);

Map<String,dynamic> toJason(){
  return {
    "id" :id,
    "name" :name,
    "age" :age,
    "email" :email,
  };
}

}