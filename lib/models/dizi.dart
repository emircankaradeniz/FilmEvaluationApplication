import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:io';

const uuid = Uuid();
final bicimlendirici = DateFormat.yMd(Platform.localeName);

enum Kategori { bilimKurgu, dram, korku, macera, polisiye }

enum SiralamaKriteri { isim, puan, tarih, kategori }

const ikonlar = {
  Kategori.bilimKurgu: Icons.rocket_launch,
  Kategori.dram: Icons.theater_comedy,
  Kategori.korku: Icons.bug_report,
  Kategori.macera: Icons.directions_run,
  Kategori.polisiye: Icons.local_police,
};

class Dizi {
  Dizi({
    required this.isim,
    this.not = '',
    required this.puan,
    required this.izlemeTarihi,
    required this.kategori,
    this.isFavourite = false,
  }) : id = uuid.v4();

  Dizi.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isim = json['isim'],
        not = json['not'],
        puan = json['puan'].toDouble(),
        izlemeTarihi = DateTime.parse(json['izlemeTarihi']),
        kategori = Kategori.values
            .firstWhere((element) => element.name == json['kategori']),
        isFavourite = json['isFavourite'] ?? false;

  final String id;
  final String isim;
  final String not;
  final double puan;
  final DateTime izlemeTarihi;
  final Kategori kategori;
  bool isFavourite;

  String get bicimliTarih {
    return bicimlendirici.format(izlemeTarihi);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'isim': isim,
    'not': not,
    'puan': puan,
    'izlemeTarihi': izlemeTarihi.toIso8601String(),
    'kategori': kategori.name,
    'isFavourite': isFavourite,
  };
}
