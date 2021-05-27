class PlacePrediction {
  String second_text;
  String main_text;
  String place_id;

  PlacePrediction({this.main_text, this.place_id, this.second_text});

  PlacePrediction.fromJson(Map<String, dynamic> json) {
    place_id = json["place_id"];
    main_text = json["structured_formating"]["main_text"];
    second_text = json["structured_formating"]["second_text"];
  }
}
