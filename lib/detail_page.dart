import 'package:daftar_masjid/list_masjid.dart';
import 'package:daftar_masjid/masjid_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final Masjid mosque;
  const DetailPage({super.key, required this.mosque});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mosque.nama, style: GoogleFonts.oswald(fontSize: 30)),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth <= 600) {
            return _potraitLayout();
          } else {
            return _landscapeLayout(context);
          }
        }));
  }

  ListView _potraitLayout() {
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
              width: double.infinity, mosque.urlImage, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Icon(Icons.location_on),
              Text(
                "${mosque.kota}, ${mosque.provinsi}",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            mosque.desc,
            style: GoogleFonts.poppins(fontSize: 17),
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }

  _landscapeLayout(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Image.network(mosque.urlImage,
                              fit: BoxFit.cover)),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Expanded(
                              child:
                                  Text("${mosque.kota} - ${mosque.provinsi}"))
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                mosque.desc,
                style: GoogleFonts.poppins(fontSize: 17),
                textAlign: TextAlign.justify,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
