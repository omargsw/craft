import 'package:craft/components/font.dart';
import 'package:craft/components/main_app_bar.dart';
import 'package:craft/components/text_field_withColor.dart';
import 'package:flutter/material.dart';

class ApproveRequestsPage extends StatefulWidget {
  final String? name;
  final String? profileImage;
  final String? phoneNumber;
  final String? desc;
  final String? image;
  const ApproveRequestsPage({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.desc,
    required this.image,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<ApproveRequestsPage> createState() => _ApproveRequestsPageState();
}

class _ApproveRequestsPageState extends State<ApproveRequestsPage> {
  GlobalKey<FormState> formDesc = GlobalKey<FormState>();
  GlobalKey<FormState> formPrice = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool isApprove = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(title: "Request Details"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: ListTile(
                title: Text(
                  widget.name!,
                  style: AppFonts.tajawal20BlackW600,
                ),
                subtitle: Text(
                  widget.phoneNumber!,
                  style: AppFonts.tajawal14Black45W400,
                ),
                leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        AssetImage("assets/images/nouserimage.jpg")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                widget.desc!,
                style: AppFonts.tajawal14BlackW600,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(4, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Image.asset(widget.image!),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithColorWidget(
              formKey: formDesc,
              controller: descController,
              labelText: "What do you need to fixed",
              inputType: TextInputType.name,
              ob: true,
              prefixIcon: null,
              suffixIconButton: null,
              type: "name",
            ),
            TextFieldWithColorWidget(
              formKey: formPrice,
              controller: priceController,
              labelText: "Price",
              inputType: TextInputType.phone,
              ob: true,
              prefixIcon: null,
              suffixIconButton: null,
              type: "name",
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                onPressed: () {
                  // Get.to(const AddPost());
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'SEND',
                    style: AppFonts.tajawal16BlackW600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
