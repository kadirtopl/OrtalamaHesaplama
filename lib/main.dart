import "package:flutter/material.dart";
import "package:untitled3/app_Contants/Sabitler.dart";
import "package:untitled3/widgets/Ortalama_hesapla_page.dart";
void main (){
  runApp(MyApp());
}
    class MyApp extends StatelessWidget {
      const MyApp({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Dinamik Not Ortalaması Hesapla",
          theme: ThemeData(
              primarySwatch:Sabitler.anaRenk,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: OrtalamaHesaplamaApp(),
        );

      }

    }
