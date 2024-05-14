 class ChatValidation{
  String? nameValidate(String? name){
    if(name!.isEmpty)return 'invalid name';
    return null ;
  }
  String? passwordValidate(String? pass){
    if((pass?.length??0)>=10){
      return null;
    }
    return 'invalid password';
  }
  String? emailValidate(String? mail){
    String source=r"^(\w){5,15}@gmail.com$";
    RegExp regExp=RegExp(source);
    bool accept =regExp.hasMatch(mail!);
    if(accept)return null;
    return 'invalid email';
  }
}
