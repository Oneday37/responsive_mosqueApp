import 'package:daftar_masjid/list_masjid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detail_page.dart';
import 'masjid_models.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Masjid"),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth <= 500) {
            return ListView(
              children: _listMasjidPotrait(),
            );
          } else if (constraints.maxWidth <= 700) {
            return GridView.count(
                crossAxisCount: 2, children: _listMasjidLandscape());
          } else if (constraints.maxWidth <= 1000) {
            return GridView.count(
              crossAxisCount: 3,
              children: _listMasjidLandscape(),
            );
          } else if (constraints.maxWidth <= 1500) {
            return GridView.count(
              crossAxisCount: 4,
              children: _listMasjidLandscape(),
            );
          } else {
            return GridView.count(
              crossAxisCount: 5,
              children: _listMasjidLandscape(),
            );
          }
        }));
  }

  List<Widget> _listMasjidPotrait() {
    return List<Widget>.generate(masjid.length, (index) {
      Masjid mosque = masjid[index];
      return Card(
        child: ListTile(
          leading: Image.network(
            height: double.infinity,
            width: 80,
            mosque.urlImage,
            fit: BoxFit.cover,
          ),
          title: Text(mosque.nama,
              style: GoogleFonts.oswald(
                  fontSize: 17, fontWeight: FontWeight.bold)),
          subtitle: Text(
            "${mosque.kota} - ${mosque.provinsi}",
            style: TextStyle(fontSize: 13),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_rounded),
          onTap: () {
            Get.to(DetailPage(mosque: mosque));
          },
        ),
      );
    });
  }

  List<Widget> _listMasjidLandscape() {
    return List<Widget>.generate(masjid.length, (index) {
      Masjid mosque = masjid[index];
      return Card(
        child: InkWell(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Image.network(
                  width: double.infinity,
                  mosque.urlImage,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: ListTile(
                    title: Text(mosque.nama),
                    subtitle: Text("${mosque.kota} - ${mosque.provinsi}")),
              )
            ],
          ),
          onTap: () {
            Get.to(DetailPage(mosque: mosque));
          },
        ),
      );
    });
  }
}
