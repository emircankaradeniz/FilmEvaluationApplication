import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dizileruygulamasi/models/dizi.dart';

typedef DiziSilCallback = void Function(Dizi dizi);
typedef DiziDuzenleCallback = void Function(Dizi dizi);
typedef DiziFavoriCallback = void Function(Dizi dizi);

class DiziListesi extends StatelessWidget {
  final List<Dizi> diziler;
  final DiziSilCallback diziSil;
  final DiziDuzenleCallback diziDuzenle;
  final DiziFavoriCallback diziFavori;

  const DiziListesi({
    required this.diziler,
    required this.diziSil,
    required this.diziDuzenle,
    required this.diziFavori,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: diziler.length,
      itemBuilder: (context, index) {
        final dizi = diziler[index];
        return Slidable(
          key: Key(dizi.isim),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => diziFavori(dizi),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: dizi.isFavourite ? Icons.favorite : Icons.favorite_border,
                label: dizi.isFavourite ? 'Favorilerden Çıkar' : 'Favorilere Ekle',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => diziDuzenle(dizi),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Düzenle',
              ),
              SlidableAction(
                onPressed: (context) => diziSil(dizi),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Sil',
              ),
            ],
          ),
          child: ListTile(
            title: Text(dizi.isim),
            trailing: dizi.isFavourite
                ? Icon(Icons.favorite, color: Colors.red)
                : null,
          ),
        );
      },
    );
  }
}
