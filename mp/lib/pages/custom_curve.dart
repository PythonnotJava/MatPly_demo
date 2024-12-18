import '../matply/src/core.dart' show GeometryGenerator, MatrixType;
import 'dart:math';


class CurveExample {
  // 1. 阿基米德螺线
  static double archimedeanX(double theta, dynamic params) {
    double a = params['a'];
    return a * theta * cos(theta);
  }

  static double archimedeanY(double theta, dynamic params) {
    double a = params['a'];
    return a * theta * sin(theta);
  }

  // 2. 摆线
  static double cycloidX(double theta, dynamic params) {
    double a = params['a'];
    return a * (theta - sin(theta));
  }

  static double cycloidY(double theta, dynamic params) {
    double a = params['a'];
    return a * (1 - cos(theta));
  }

  // 3. 正弦波
  static double sineX(double theta, dynamic params) {
    return theta; // x 直接等于角度
  }

  static double sineY(double theta, dynamic params) {
    double a = params['a'];
    double b = params['b'];
    return a * sin(b * theta);
  }

  static Future<MatrixType> spiral = GeometryGenerator.custom_curve_async(
    size: 1000,
    xFunc: archimedeanX,
    yFunc: archimedeanY,
    params: {'a': 0.1},
    thetaStart: 0.0,
    thetaStep: pi / 20,
  );

  // 生成摆线
  static Future<MatrixType> cycloid = GeometryGenerator.custom_curve_async(
    size: 1000,
    xFunc: cycloidX,
    yFunc: cycloidY,
    params: {'a': 2.0},
    thetaStart: 0.0,
    thetaStep: pi / 20,
  );

  // 生成正弦波
  static Future<MatrixType> sineWave = GeometryGenerator.custom_curve_async(
    size: 1000,
    xFunc: sineX,
    yFunc: sineY,
    params: {'a': 1.0, 'b': 2.0},
    thetaStart: 0.0,
    thetaStep: pi / 20,
  );
}
