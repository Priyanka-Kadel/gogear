import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));
        // Assume registration is successful
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterError(message: e.toString()));
      }
    });
  }
}
