import 'package:bloc/bloc.dart';
import 'package:cruise_buddy/core/model/booking_response_model/booking_response_model.dart';
import 'package:cruise_buddy/core/services/book/booking_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_my_cruise_event.dart';
part 'book_my_cruise_state.dart';
part 'book_my_cruise_bloc.freezed.dart';

class BookMyCruiseBloc extends Bloc<BookMyCruiseEvent, BookMyCruiseState> {
  BookMyCruiseBloc() : super(_Initial()) {
    BookingService bookingService = BookingService();
    on<_BookMyCruiseEventboats>((event, emit) async {
      emit(const BookMyCruiseState.loading());

      try {
        final result = await bookingService.addItemToBookeditem(
            packageId: 'packageId',
            bookingTypeId: 'bookingTypeId',
            vegCount: 'vegCount',
            nonVegCount: 'nonVegCount',
            jainVegCount: 'jainVegCount',
            customerNote: 'customerNote',
            startDate: event.date,
            totalAmount: 'totalAmount');

        await result.fold((failure) async {
          if (failure == "No internet") {
            emit(const BookMyCruiseState.noInternet());
          } else {
            emit(BookMyCruiseState.getBookedFailure(  error: failure));
          }
        }, (success) async {

          emit(
            BookMyCruiseState.getBookedBoats(
              bookingresponse: success,
            ),
          );
        });
      } catch (e) {
        emit(BookMyCruiseState.getBookedFailure(
            error: 'An error occurred: $e'));
      }
    });
  }
}
