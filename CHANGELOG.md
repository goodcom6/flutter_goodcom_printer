## 0.0.1

initial commit

## 1.0.0

first release

## 1.0.1

1.Add new api:
  void drawNewLine();
  void drawOneLine([int? fontSize]);
  void drawCustom(String str,int fontSize,int align);
  void drawLeftRight(String left,String right,int fontSize);
  void drawImage(String path);

2.Add various bold fonts:

3.Adjust API:
  PrintText to add automatic paper feeding parameters
  Adjust some api definitions

 ## 1.0.2

 Adjusting SDK support version for compatibility with 2.7.0
 Delete api getPlatformVersion;

 ## 1.0.3

 To avoid prompting empty security issues when using higher versions of Flutter, the version supports updating to 2.15.1