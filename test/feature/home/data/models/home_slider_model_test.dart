import 'package:flutter_test/flutter_test.dart';
import 'package:bookia/feature/home/data/models/home_slider_model.dart';

void main() {
  group('SliderModel', () {
    final json = {
      'status': 200,
      'message': 'success',
      'data': {
        'sliders': [
          {'image': 'https://example.com/slide1.jpg'},
          {'image': 'https://example.com/slide2.jpg'},
        ],
      },
    };

    test('fromJson parses top-level fields', () {
      final model = SliderModel.fromJson(json);
      expect(model.status, 200);
      expect(model.message, 'success');
      expect(model.data, isNotNull);
    });

    test('fromJson parses sliders list', () {
      final model = SliderModel.fromJson(json);
      expect(model.data!.sliders, hasLength(2));
      expect(model.data!.sliders!.first.image, 'https://example.com/slide1.jpg');
      expect(model.data!.sliders!.last.image, 'https://example.com/slide2.jpg');
    });

    test('fromJson returns null data when data key is absent', () {
      final model = SliderModel.fromJson({'status': 500});
      expect(model.data, isNull);
    });
  });

  group('SliderImages.fromJson', () {
    test('parses image field correctly', () {
      final img = SliderImages.fromJson({'image': 'https://example.com/img.png'});
      expect(img.image, 'https://example.com/img.png');
    });

    test('handles missing image field gracefully', () {
      final img = SliderImages.fromJson({});
      expect(img.image, isNull);
    });
  });
}
