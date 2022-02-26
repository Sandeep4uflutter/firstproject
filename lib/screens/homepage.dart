import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apicall/getallcountries.dart';
import '../constant/app_text_constants.dart';
import '../constant/color_constants.dart';
import '../controller/controller.dart';
import '../models/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DropGetXContoller getControl = DropGetXContoller();


  // ignore: prefer_typing_uninitialized_variables
  var countries;
  //search function
  var items = [];
  var indexpostion = [];
  bool showerror = false;
  Future<void> filterSearchResults(String query) async {
    indexpostion.clear();
    List dummySearchList = [];
    dummySearchList.addAll(countries);
    if(query.isNotEmpty) {
      List dummyListData = [];
      for (var item in dummySearchList) {
        if(item.code.toString().toLowerCase()==query.toLowerCase()) {
          setState(() {
            dummyListData.add(item);
          });
        }else{

        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
        indexpostion.clear();
        for(var i=0; i<items.length; i++){
          final index = dummySearchList.indexWhere((element) =>
          element.code == items[i].code);
          indexpostion.add(index);
          debugPrint(index.toString());

        }
        if(indexpostion.isEmpty){
          getControl.changeErrorState(true);

        }else{
          getControl.changeErrorState(false);
        }
      });
      items.clear();
      for(var i=0; i<indexpostion.length; i++){
        items.add(countries[int.parse(indexpostion[i].toString())]);
      }
      return;
    } else {
      setState(() {
        items.clear();
      });
    }
  }

  Future<List<Countrys>> future = getAllCountriesx();

  // ignore: non_constant_identifier_names
  Widget ListCountries(
      BuildContext context, AsyncSnapshot<List<Countrys>> snapshot) {
    countries = snapshot.data;

    if (snapshot.connectionState == ConnectionState.done) {
      return items.isEmpty?ListView.builder(
          itemCount: countries!.length,
          itemBuilder: (BuildContext context, index){
            Countrys project = snapshot.data![index];
            snapshot.data!.sort((a, b) => a.name.compareTo(b.name));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.withOpacity(0.2),
                  child: Column(
                    children: [
                      Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Row(
                              children: [
                                const SizedBox(
                                    width: 30,
                                    child: Icon(Icons.circle, size: 16, color: Colors.grey,)),
                                Expanded(child: Text(project.name.toString(), style: const TextStyle(fontSize: 15, color: Colors.white),)),
                              ],
                            )),
                          )),
                      Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text('Country Code : ', style: TextStyle(fontSize: 15, color: Colors.black),)),
                                      Expanded(child: Text(project.code.toString(), style: const TextStyle(fontSize: 15, color: Colors.black),)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width: 40,
                                          child: Text('Flag : ', style: TextStyle(fontSize: 15, color: Colors.black),)),
                                      Expanded(child: Text(project.emoji.toString(), style: const TextStyle(fontSize: 15, color: Colors.black),)),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: const [
                            Text(
                              'Languages',
                              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 40,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                                child:ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: project.languages!.length,
                                  itemBuilder: (BuildContext context, index2){
                                    Language lang = project.languages![index2];
                                    project.languages!.sort((a, b) => a.name.compareTo(b.name));
                                    return Container(
                                      height: 40,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(lang.name.toString()),
                                            const SizedBox(width: 10,),
                                            if(index2!=project.languages!.length-1)
                                              const Icon(Icons.circle, size: 10, color: Colors.black,),
                                          ],
                                        )),
                                      ),
                                    );
                                  },
                                )),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }):
      ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, index){
            Countrys project = items[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.withOpacity(0.2),
                  child: Column(
                    children: [
                      Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Row(
                              children: [
                                const SizedBox(
                                    width: 30,
                                    child: Icon(Icons.circle, size: 16, color: Colors.grey,)),
                                Expanded(child: Text(project.name.toString(), style: const TextStyle(fontSize: 15, color: Colors.white),)),
                              ],
                            )),
                          )),
                      Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text('Country Code : ', style: TextStyle(fontSize: 15, color: Colors.black),)),
                                      Expanded(child: Text(project.code.toString(), style: const TextStyle(fontSize: 15, color: Colors.black),)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width: 40,
                                          child: Text('Flag : ', style: TextStyle(fontSize: 15, color: Colors.black),)),
                                      Expanded(child: Text(project.emoji.toString(), style: const TextStyle(fontSize: 15, color: Colors.black),)),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: const [
                            Text(
                              'Languages',
                              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 40,
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                                child:ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: project.languages!.length,
                                  itemBuilder: (BuildContext context, index2){
                                    Language lang = project.languages![index2];
                                    project.languages!.sort((a, b) => a.name.compareTo(b.name));
                                    return Container(
                                      height: 40,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(lang.name.toString()),
                                            const SizedBox(width: 10,),
                                            if(index2!=project.languages!.length-1)
                                              const Icon(Icons.circle, size: 10, color: Colors.black,),
                                          ],
                                        )),
                                      ),
                                    );
                                  },
                                )),
                          )),
                    ],
                  ),
                ),
              ),
            );
          });
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 35,
          title: Text(AppBarTitle,style: const TextStyle(color: Colors.black),),
          backgroundColor: AppBarBackColor
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:  Column(
            children: [
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(()=>TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          labelText: getControl.search_hint.value,
                          fillColor: Colors.white70),
                      onChanged: (String? value) {
                        if(value!.isNotEmpty) {
                          filterSearchResults(value);
                        }
                        else{
                          indexpostion.clear();
                          items.clear();
                          getControl.changeErrorState(false);
                        }
                      },
                    ))
                ),
              ),
              if(getControl.showError.value==true)
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('No country with this country code !', style: TextStyle(fontSize: 15, color: Colors.red),),
                    ),
                  ],
                ),
              Expanded(
                child: FutureBuilder<List<Countrys>>(
                  future: future,
                  builder: (context, snapshot) {
                    return ListCountries(context, snapshot);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
