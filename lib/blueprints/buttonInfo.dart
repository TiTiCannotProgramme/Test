enum ButtonType {all, ds3, test}
enum Language {en, cn}

class ButtonInfo{
  final Map<Language, String> _buttonText;
  final String _buttonFileName;
  final int _audioLength;
  final _buttonType;

  ButtonInfo(this._buttonText, this._buttonFileName, this._audioLength, this._buttonType);

  // const ButtonInfo(String text, int number, int length){
  //   _buttonText = text;
  //   _buttonNumber = number;
  //   _audioLength = length;
  // };

  String getButtonFileName(){
    return _buttonFileName;
  }

  String getButtonText(Language currentLanguage){
    return _buttonText[currentLanguage];
  }

  int getAudioLength(){
    return _audioLength;
  }

  ButtonType getButtonType(){
    return _buttonType;
  }
}