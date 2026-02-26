class SliderModel {
  SliderData? data;
  String? message;
  int? status;

  SliderModel({this.data, this.message, this.status});

  SliderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SliderData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
}

class SliderData {
  List<SliderImages>? sliders;
  SliderData({this.sliders});

  SliderData.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <SliderImages>[];
      json['sliders'].forEach((v) {
        sliders!.add(SliderImages.fromJson(v));
      });
    }
  }
}

class SliderImages {
  String? image;
  SliderImages({this.image});
  SliderImages.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }
}
