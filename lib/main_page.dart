import 'dart:ui';

import 'package:daftar_masjid/list_masjid.dart';
import 'package:flutter/cupertino.dart';
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

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List Masjid"),
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
            style: const TextStyle(fontSize: 13),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          onTap: () {
            Get.to(DetailPage(mosque: mosque));
          },
        ),
      );
    });
  }

  List<Widget> _listMasjidLandscape() {
    //Membuat sebuah controller untuk animasi yang berisikan durasi yang akan digunakan pada proses animasi
    final AnimationController _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

//Mengatur posisi awal dari animasi
    final Animation<Offset> _animation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
        //properties parent akan mengembalikan var _controller yang berisikan durasi animasi
        //dan properties curve akan menentukan animasinya, seperti apa
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    return List<Widget>.generate(masjid.length, (index) {
      Masjid mosque = masjid[index];
      return MouseRegion(
        //Sebuah function jika cursor mouse berada pada widget maka animasi akan bergerak maju / ke tempat tujuan
        onEnter: (event) {
          _controller.forward();
        },
        //Sebuah function jika cursor mouse tidak berada pada area widget maka animasi akan bergerak mundur / ke tempat asal
        onExit: (event) {
          _controller.reverse();
        },
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Card(
                elevation: 5,
                child: GestureDetector(
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
                            subtitle:
                                Text("${mosque.kota} - ${mosque.provinsi}")),
                      )
                    ],
                  ),
                  onTap: () {
                    Get.to(DetailPage(mosque: mosque));
                  },
                ),
              ),
              SlideTransition(
                //Widget untuk membuat efek transisi secara slide / bergesar
                position: _animation,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mosque.nama,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 1.7,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              mosque.desc,
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.justify,
                              maxLines: 5,
                            )
                          ],
                        ),
                        onTap: () {
                          Get.to(DetailPage(mosque: mosque));
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
