import 'file.dart';

class OpenSpaceFormData {
  OpenSpaceFormData({this.formFields, this.files});
  Map<String, dynamic> formFields;
  List<OpenSpaceFile> files;
}
