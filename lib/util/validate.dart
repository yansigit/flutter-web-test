RegExp KOREAN_WORD_REGEXP = RegExp(r"[ㄱ-ㅎ|ㅏ-ㅣ|ㆍ|가-힣]");
RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp passwordExp = RegExp(r'^(?=.*?[a-z])([A-Z])*(?=.*?[0-9]).{8,}$');
RegExp phoneNumberExp = RegExp(r'^(0[12]0)([0-9]{3,4})([0-9]{4})$');

String? emailValidate(String? email) {
  if (email!.length > 30 || !emailRegExp.hasMatch(email)) {
    return "이메일 형식이 잘못되었습니다.";
  } else {
    return null;
  }
}

String? passwordValidate(String? password) {
  if (password!.length > 30 || !passwordExp.hasMatch(password)) {
    return " 영어 소문자 1개 이상, 숫자 1개 이상 포함하는 8자리 이상의 글자를 입력해주세요.";
  } else {
    return null;
  }
}

String? nameValidate(String? name) {
  if (name!.length < 1) {
    return "이름을 한 글자 이상 적어주세요.";
  } else {
    return null;
  }
}

String? phoneNumberValidate(String?  phoneNumber) {
{
      if (!phoneNumberExp.hasMatch(phoneNumber!)) {
          return '"-" 없이 010 혹은 020 으로 시작하는 숫자 11자리 혹은 12자리를 입력해주세요';
        } else {
          return null;
        }
      }
  }


