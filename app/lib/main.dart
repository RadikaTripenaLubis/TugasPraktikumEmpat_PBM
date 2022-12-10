import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:something/splash.dart';
import 'package:something/stok.dart';
import 'package:something/models/barang.dart';

import 'stok_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StokProvider(),
      builder: (context, child) {
        return child!;
      },
      child: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (snapshot.data!.getBool('login') == null) {
            snapshot.data!.setBool('login', false);
          }

          return MaterialApp(
            home: snapshot.data!.getBool('login') == true ? HomeScreen() : const Splash(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Barang> listBarang = [
    Barang(
        name: 'EXO',
        price: '3200000',
        description:
            'EXO adalah boyband asal Korea Selatan yang dibentuk oleh SM Entertainment pada tahun 2011. EXO memiliki 9 anggota, yaitu: Suho, Baekhyun, Chanyeol, D.O., Kai, Sehun, Xiumin, Lay, dan Chen.'),
    Barang(
        name: '2NE1',
        price: '2800000',
        description:
            '2NE1 adalah girlband asal Korea Selatan yang dibentuk oleh YG Entertainment pada tahun 2009. 2NE1 memiliki 4 anggota, yaitu: CL, Dara, Bom, dan Minzy.'),
    Barang(
        name: 'Blackpink',
        price: '2100000',
        description:
            'Blackpink adalah girlband asal Korea Selatan yang dibentuk oleh YG Entertainment pada tahun 2016. Blackpink memiliki 4 anggota, yaitu: Jennie, Lisa, Jisoo, dan Rosé.'),
    Barang(
        name: 'Super Junior',
        price: '1500000',
        description:
            'Super Junior adalah boyband asal Korea Selatan yang dibentuk oleh SM Entertainment pada tahun 2005. Super Junior memiliki 13 anggota, yaitu: Leeteuk, Heechul, Yesung, Shindong, Eunhyuk, Siwon, Donghae, Ryeowook, Kyuhyun, Sungmin, Zhoumi, Kibum, dan Hankyung.'),
    Barang(
        name: 'NCT',
        price: '2100000',
        description:
            'NCT adalah boyband asal Korea Selatan yang dibentuk oleh SM Entertainment pada tahun 2016. NCT memiliki 23 anggota, yaitu: Taeyong, Taeil, Johnny, Yuta, Doyoung, Jaehyun, Winwin, Jungwoo, Mark, Haechan, Chenle, Jeno, Jaemin, Renjun, Jisung, Lucas, Ten, Kun, Xiaojun, Hendery, Yangyang, and Shotaro.'),
    Barang(
        name: 'Seventeen',
        price: '2800000',
        description:
            'Seventeen adalah boyband asal Korea Selatan yang dibentuk oleh Pledis Entertainment pada tahun 2015. Seventeen memiliki 13 anggota, yaitu: S.Coups, Jeonghan, Joshua, Jun, Hoshi, Wonwoo, Woozi, DK, Mingyu, The8, Seungkwan, Vernon, dan Dino.'),
    Barang(
        name: 'Presure',
        price: '3000000',
        description:
            'Presure adalah boyband asal Korea Selatan yang dibentuk oleh Pledis Entertainment pada tahun 2019. Presure memiliki 5 anggota, yaitu: Jisung, Woojin, Mingyu, Seungkwan, dan Vernon.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: ListView.builder(
        itemCount: listBarang.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listBarang[index].name),
            subtitle: Text('Rp. ${listBarang[index].price}'),
            onTap: () {},
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    await context.read<StokProvider>().tambahBarang(listBarang[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const Stok();
              },
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
