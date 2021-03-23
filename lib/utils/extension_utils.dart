import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TabletSizeExtension on num {
  double get tws_1_5 =>
      ScreenUtil().setWidth(this) * (Device.get().isTablet ? 1.5 : 1);

  double get sp_1_5 =>
      ScreenUtil().setSp(this) * (Device.get().isTablet ? 1.5 : 1);

  double get tws_2 =>
      ScreenUtil().setWidth(this) * (Device.get().isTablet ? 2 : 1);

  double get ths_2 =>
      ScreenUtil().setHeight(this) * (Device.get().isTablet ? 2 : 1);
}
