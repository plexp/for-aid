/*

Send it like

{
  "id": 1,
  "timestamp": 1563640432,
  "first_name": "John",
  "last_name": "Doe",
  "location": {
    "latitude": 40.446878992182626,
    "longitude": -3.6945078746128055
  }
}

*/
import 'dart:convert';

class AddScan {
  int id;
  String first_name;
  String last_name;

  double longitude;
  double latitude;

  AddScan({
      this.id,
      this.first_name,
      this.last_name,
      this.longitude,
      this.latitude,
  });

  sendRequest() async {
    String targetUrl = "https://tst.plzni.to/api/1.0/tickets/new";
    //String targetUrl = "http://hub-internal.techheaven.org/plznito/api/1.0/tickets/new";
    String json;

    if(this.name == null || this.name == "") {
      throw new Exception("Chybí název ticketu");
    }
    if(this.longitude == null || this.latitude == null) {
      throw new Exception("Chybí poloha");
    }
    if(this.category_id == null) {
      throw new Exception("Chybí kategorie");
    }


    String description;

    if(isTestVersion) {
      description = this.description + "\n Odesláno pomocí testovací verze";
    }
    else {
      description = this.description;
    }
    Map prepareJson;

    prepareJson = {
      'name' : this.name,
      'category_id' : this.category_id,
      'description' : description,
      'longitude' : this.longitude.toString(),
      'latitude' : this.latitude.toString(),
      'photos' : this.photos,
    };


    json = jsonEncode(prepareJson);
    print(json);

    http.post(targetUrl,
        headers: {"Content-Type": "application/json"},
        body: json
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response);
      print(response.headers);
      print(response.request);

    });




  }

  
}