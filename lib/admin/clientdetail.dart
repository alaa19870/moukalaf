import 'package:flutter/material.dart';
import 'package:moukalaf/admin/declaration.dart';
import 'package:moukalaf/admin/getfamillyclient.dart';
import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/imageDetail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ring_button_group/ring_button_group.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: prefer_typing_uninitialized_variables
var idFamilly;

class ItemClient {
  final String id;
  final String userName;
  final String password;
  final String name;
  final String telephone;
  final String email;
  final String personnelNumber;
  final String financialNumber;
  final String homeAdress;
  final String workAdress;
  final String job;
  final String eservicesUser;
  final String eservicesPass;
  final String image;

  ItemClient({
    required this.id,
    required this.userName,
    required this.password,
    required this.name,
    required this.telephone,
    required this.email,
    required this.personnelNumber,
    required this.financialNumber,
    required this.homeAdress,
    required this.workAdress,
    required this.job,
    required this.eservicesUser,
    required this.eservicesPass,
    required this.image,
  });
}

class ItemDetails extends StatelessWidget {
  final ItemClient client;

  ItemDetails({required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: x,
        centerTitle: true,
        title: Text(
          client.name,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: RingButtonGroup(
                      buttonNumber: 3,
                      icons: const [
                        Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.family_restroom_outlined,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.document_scanner,
                          color: Colors.white,
                        ),
                      ],
                      type: RingButtonGroupType.SINGLE_SELECTABLE,
                      onPressed: (index, selected) async {
                        // Define actions for each icon here
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDetails(
                                img: Pictures(picture: client.image),
                              ),
                            ),
                          );
                        } else if (index == 1) {
                          idFamilly = client.id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => getFamillyMember(),
                            ),
                          );
                        } else if (index == 2) {
                          idFamilly = client.id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FileListScreen(),
                            ),
                          );
                        }
                        return true;
                      },
                    ),
                  ),
                ),
              ),
              buildInfoTile(
                context,
                icon: Icons.work,
                title: client.job,
                trailing: "الوظيفة",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.home,
                title: client.homeAdress,
                trailing: "عنوان السكن",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.work,
                title: client.workAdress,
                trailing: "عنوان العمل",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: FontAwesomeIcons.whatsapp,
                title: client.telephone,
                trailing: "رقم الهاتف",
                onTap: () => _launchWhatsApp(context, client.telephone),
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.perm_identity,
                title: client.personnelNumber,
                trailing: "رقم الشخصي",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.perm_identity_sharp,
                title: client.financialNumber,
                trailing: "رقم المالي",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.email,
                title: client.email,
                trailing: "البريد الالكنروني",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.verified_user_rounded,
                title: client.eservicesUser,
                trailing: "حساب المالية الالكتروني",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.password,
                title: client.eservicesPass,
                trailing: "رمز المالية الالكتروني",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.support_agent,
                title: client.userName,
                trailing: "حساب العمبل",
              ),
              buildDivider(),
              buildInfoTile(
                context,
                icon: Icons.password_outlined,
                title: client.password,
                trailing: "كلمة مرور العمبل",
              ),
              buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String trailing,
      VoidCallback? onTap}) {
    return Container(
      height: 45,
      child: ListTile(
        trailing: Text(
          trailing,
          style: TextStyle(
            fontSize: 12.0,
            color: const Color(0xff3b63ff),
          ),
        ),
        leading: icon == FontAwesomeIcons.whatsapp
            ? FaIcon(icon, color: Colors.green)
            : Icon(icon, color: const Color(0xff3b63ff)),
        title: Text(
          title,
          style: TextStyle(fontSize: 14.0, color: const Color(0xff3b63ff)),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: const Color(0xff3b63ff),
      thickness: 0.5, // Set the thickness of the divider
    );
  }

  Future<void> _launchWhatsApp(BuildContext context, String phone) async {
    final Uri whatsappUrl = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phone,
    );

    if (await canLaunch(whatsappUrl.toString())) {
      await launch(whatsappUrl.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch WhatsApp')),
      );
    }
  }
}
