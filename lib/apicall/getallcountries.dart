// returns a country with the given country code
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import '../models/model.dart';
import 'api.dart';


const _getAllCountries = r'''
query {
  countries {
    code,
    name,
    emoji,
    languages {
      code,
      name
    }
  }
  }
''';


  Future<List<Countrys>> getAllCountriesx() async {
    var result = await client.query(
      QueryOptions(
        document: gql(_getAllCountries),
      ),
    );
    if (result.hasException) {
      throw result.exception!;
    }
    debugPrint(result.toString());
    var json = result.data!["countries"];
    List<Countrys> countries = [];
    for (var res in json) {
      var country = Countrys.fromJson(res);
      countries.add(country);
    }
   //debugPrint(json.toString());
    return countries;
  }

