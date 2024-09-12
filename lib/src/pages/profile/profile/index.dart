import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iam_mobile/src/config/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilEdit extends StatefulWidget {
  const ProfilEdit({super.key});

  @override
  State<ProfilEdit> createState() => _ProfilEditState();
}

class _ProfilEditState extends State<ProfilEdit> {
  late TextEditingController _cnip;
  late TextEditingController _cpernr;
  late TextEditingController _cregisteredName;
  late TextEditingController _cposisi;
  late TextEditingController _corganisasi;
  late TextEditingController _cpersonnelArea;
  late TextEditingController _cpersonnelSubArea;
  late TextEditingController _ccompanyCode;
  late TextEditingController _cbusinessArea;
  late TextEditingController _cjenisJabatan;
  late TextEditingController _cjenjangJabatan;
  late TextEditingController _cgrade;
  late TextEditingController _cdirectOfficerName;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadData();
  }

  void _initializeControllers() {
    _cnip = TextEditingController();
    _cpernr = TextEditingController();
    _cregisteredName = TextEditingController();
    _cposisi = TextEditingController();
    _corganisasi = TextEditingController();
    _cpersonnelArea = TextEditingController();
    _cpersonnelSubArea = TextEditingController();
    _ccompanyCode = TextEditingController();
    _cbusinessArea = TextEditingController();
    _cjenisJabatan = TextEditingController();
    _cjenjangJabatan = TextEditingController();
    _cgrade = TextEditingController();
    _cdirectOfficerName = TextEditingController();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userProfileJson = prefs.getString('userProfile');

    if (userProfileJson != null) {
      Map<String, dynamic> userProfile = jsonDecode(userProfileJson);
      Map<String, dynamic> detailsKaryawan =
          userProfile['http://iam-local.xyz/svc-core/account/hrinfo'];
      Map<String, dynamic> posisi = detailsKaryawan['posisi'];
      Map<String, dynamic> organisasi = detailsKaryawan['organisasi'];
      Map<String, dynamic> personnelArea = detailsKaryawan['personnelArea'];
      Map<String, dynamic> personnelSubArea =
          detailsKaryawan['personnelSubArea'];
      Map<String, dynamic> companyCode = detailsKaryawan['companyCode'];
      Map<String, dynamic> businessArea = detailsKaryawan['businessArea'];
      Map<String, dynamic> jenisJabatan = detailsKaryawan['jenisJabatan'];
      Map<String, dynamic> jenjangJabatan = detailsKaryawan['jenjangJabatan'];
      Map<String, dynamic> directOfficer = detailsKaryawan['directOfficer'];

      String? nip = detailsKaryawan['nip'];
      int? pernr = detailsKaryawan['pernr'];
      String? registeredName = detailsKaryawan['registeredName'];
      String? posisiName = posisi['name'];
      String? organisasiName = organisasi['name'];
      String? personnelAreaName = personnelArea['name'];
      String? personnelSubAreaName = personnelSubArea['name'];
      String? companyCodeName = companyCode['name'];
      String? businessAreaName = businessArea['name'];
      String? jenisJabatanName = jenisJabatan['name'];
      String? jenjangJabatanName = jenjangJabatan['name'];
      String? grade = detailsKaryawan['grade'];
      String? directOfficerName = directOfficer['name'];

      setState(() {
        _cnip.text = nip ?? '';
        _cpernr.text = pernr?.toString() ?? '';
        _cregisteredName.text = registeredName ?? '';
        _cposisi.text = posisiName ?? '';
        _corganisasi.text = organisasiName ?? '';
        _cpersonnelArea.text = personnelSubAreaName ?? '';
        _cpersonnelSubArea.text = personnelSubAreaName ?? '';
        _ccompanyCode.text = companyCodeName ?? '';
        _cbusinessArea.text = businessAreaName ?? '';
        _cjenisJabatan.text = jenisJabatanName ?? '';
        _cjenjangJabatan.text = jenjangJabatanName ?? '';
        _cgrade.text = grade ?? '';
        _cdirectOfficerName.text = directOfficerName ?? '';
      });
    } else {
      print('No user profile found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Profile',
            style: GoogleFonts.inter(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListView(
              children: [
                Text(
                  'Personal Information',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400, fontSize: 17),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cnip,
                    decoration: InputDecoration(
                      label: const Text('NIP'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cpernr,
                    decoration: InputDecoration(
                      label: const Text('Personal Number (Pernr)'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cregisteredName,
                    decoration: InputDecoration(
                      label: const Text('Registered Name'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cposisi,
                    decoration: InputDecoration(
                      label: const Text('Posisi'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _corganisasi,
                    decoration: InputDecoration(
                      label: const Text('Organisasi'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cpersonnelArea,
                    decoration: InputDecoration(
                      label: const Text('Personal Area'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cpersonnelSubArea,
                    decoration: InputDecoration(
                      label: const Text('Personal Sub Area'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _ccompanyCode,
                    decoration: InputDecoration(
                      label: const Text('Company Code'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cbusinessArea,
                    decoration: InputDecoration(
                      label: const Text('Business Area'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cjenisJabatan,
                    decoration: InputDecoration(
                      label: const Text('Jenis Jabatan'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cjenjangJabatan,
                    decoration: InputDecoration(
                      label: const Text('Jenjang Jabatan'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    enabled: false,
                    controller: _cgrade,
                    decoration: InputDecoration(
                      label: const Text('Grade'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _cdirectOfficerName,
                    decoration: InputDecoration(
                      label: const Text('Officer'),
                      floatingLabelStyle: const TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
