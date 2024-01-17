import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user_data/components/my_bottom_dialog.dart';
import 'package:user_data/models/user.dart';
import 'package:user_data/service/gsheets_service.dart';

class SubmitProvider extends ChangeNotifier {
  bool isLoading = false;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descController = TextEditingController();
  TextEditingController get nameController => _nameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get descController => _descController;

  List<String> genders = ['Laki-laki', 'Perempuan'];

  String _selectedGender = 'Laki-laki'; //default = laki-laki
  String get selectedGender => _selectedGender;
  set selectedGender(String? value) {
    _selectedGender = value!;
    notifyListeners();
  }

  bool _isBeginer = false;
  bool get isBeginer => _isBeginer;
  set isBeginer(bool value) {
    _isBeginer = value;
    notifyListeners();
  }

  void reset() {
    _nameController.clear();
    _phoneController.clear();
    _descController.clear();
    _nameController.text = '';
    _phoneController.text = '';
    _descController.text = '';

    // gender & isBeginer
    _selectedGender = genders[0];
    _isBeginer = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _descController.dispose();
  }

  bool valueOnchanged() {
    return _nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _descController.text.isNotEmpty;
  }

  Future<void> showModalEmptyValue(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return const MyBottomDialog();
      },
    );
  }

  Future<void> insert(BuildContext context) async {
    bool isValid = valueOnchanged();
    String name = _nameController.text;
    String phone = _phoneController.text;
    String gender = _selectedGender;
    String description = _descController.text;

    isLoading = true;
    notifyListeners();
    try {
      if (isValid) {
        await Future.delayed(const Duration(seconds: 3));

        final List<UserFields> users = [
          UserFields(
            id: 1,
            name: name,
            phone: phone,
            gender: gender,
            description: description,
            isBeginer: isBeginer,
          ),
        ];

        await GSheetsService.insert(
          users.map((user) => user.toJson()).toList(),
        );

        reset();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Yey.. Berhasil menambahkan user',
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              duration: const Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.purple.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                right: 20,
                left: 20,
              ),
            ),
          );
        }
      } else {
        showModalEmptyValue(context);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
