import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data/components/my_button.dart';
import 'package:user_data/components/my_dropdown.dart';
import 'package:user_data/components/my_textfield.dart';
import 'package:user_data/pages/home/submit_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubmitProvider>(
      builder: (context, c, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Image.asset(
                        'assets/ill.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    // status
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 4,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Kamu adalah Seorang  ',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 24,
                          ),
                          children: [
                            TextSpan(
                              text: c.isBeginer == true ? 'Sepuh' : 'Pemula',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade300,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // input nama
                    MyTextField(
                      controller: c.nameController,
                      hintText: 'Nama',
                      keyboadType: TextInputType.name,
                    ),
                    const SizedBox(height: 8),

                    // input nomer hp
                    MyTextField(
                      controller: c.phoneController,
                      hintText: 'Nomer Handphone',
                      keyboadType: TextInputType.phone,
                    ),
                    const SizedBox(height: 8),

                    // apa yang kamu pikirkan?
                    MyTextField(
                      controller: c.descController,
                      hintText: 'Apa yang kamu pikirkan?',
                      keyboadType: TextInputType.multiline,
                      maxLines: 4,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // pilih gender
                        Flexible(
                          child: MyDropdown(
                            value: c.selectedGender,
                            items: c.genders.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              c.selectedGender = value!;
                            },
                          ),
                        ),

                        // is Beginer
                        Flexible(
                          child: Switch(
                            value: c.isBeginer,
                            activeColor: Colors.grey.shade300,
                            inactiveThumbColor: Colors.grey.shade300,
                            onChanged: (value) {
                              c.isBeginer = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // button submit
                    c.isLoading == false
                        ? MyButton(
                            label: 'Kirim',
                            onPressed: () => c.insert(context),
                          )
                        : CircularProgressIndicator(
                            color: Colors.purple.shade800,
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
