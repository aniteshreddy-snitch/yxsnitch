import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'policies_event.dart';
part 'policies_state.dart';

class PoliciesBloc extends Bloc<PoliciesEvent, PoliciesState> {
  PoliciesBloc() : super(PoliciesInitial()) {
    on<PoliciesEvent>((event, emit) {
     
    });
  }
}
