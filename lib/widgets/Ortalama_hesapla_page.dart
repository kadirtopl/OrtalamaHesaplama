import 'package:flutter/material.dart';
import 'package:untitled3/app_Contants/Sabitler.dart';
import 'package:untitled3/helper/data_helper.dart';
import 'package:untitled3/widgets/ders_listesi.dart';
import 'package:untitled3/widgets/ortalama_goster.dart';
import 'package:untitled3/model/ders.dart';


class OrtalamaHesaplamaApp extends StatefulWidget {
  const OrtalamaHesaplamaApp({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplamaApp> createState() => _OrtalamaHesaplamaAppState();
}

class _OrtalamaHesaplamaAppState extends State<OrtalamaHesaplamaApp> {
  var formKey = GlobalKey<FormState>();
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: _buildForm()),
              Expanded(
                  flex: 1,
                  child: OrtalamaGoster(
                    dersSayisi: DataHelper.tumEklenenDersler.length,
                    ortalama: DataHelper.ortalamaHesapla(),
                  ))
            ],
          ),
          Expanded(
            child: DersListesi(
              onElemanCikarildi: (index){
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {

                });

              },
            )
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFromField(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                padding: Sabitler.yatayPadding8,
                child: _buildHarfler(),
              )),
              Expanded(
                  child: Padding(
                padding: Sabitler.yatayPadding8,
                child: _buildKrediler(),
              )),
              IconButton(
                onPressed: _dersEkleveOrtalamaHesapla,
                icon: Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  _buildTextFromField() {
    return TextFormField(
      onSaved: (deger) {
        girilenDersAdi = deger!;
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Ders adını giriniz';
        } else
          return null;
      },
      decoration: InputDecoration(
        hintText: 'Matematik',
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
      ),
    );
  }

  _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double>(
        value: secilenHarfDegeri,
        elevation: 16,
        onChanged: (deger) {
          setState(() {
            secilenHarfDegeri = deger!;
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinHarfleri(),
      ),
    );
  }

  _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double>(
        value: secilenKrediDegeri,
        elevation: 16,
        onChanged: (deger) {
          setState(() {
            secilenKrediDegeri = deger!;
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinKredileri(),
      ),
    );
  }

  void _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
     DataHelper.dersEkle(eklenecekDers);
     print(DataHelper.tumEklenenDersler);
     setState(() {

     });
    }
  }
}
