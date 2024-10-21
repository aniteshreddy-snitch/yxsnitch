import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'device_control_event.dart';
part 'device_control_state.dart';

class DeviceControlBloc extends Bloc<DeviceControlEvent, DeviceControlState> {
  DeviceControlBloc() : super(DeviceControlInitial()) {
    on<DeviceControlEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
