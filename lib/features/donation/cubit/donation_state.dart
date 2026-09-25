import 'package:ecommerce_app/features/donation/data/models/donation_model.dart';
import 'package:equatable/equatable.dart';

abstract class DonationState extends Equatable {
  const DonationState();

  @override
  List<Object?> get props => [];
}

class DonationInitialState extends DonationState {
  const DonationInitialState();
}

class DonationLoadingState extends DonationState {
  const DonationLoadingState();
}

class DonationSubmitSuccessState extends DonationState {
  const DonationSubmitSuccessState();
}

class DonationsLoadedState extends DonationState {
  final List<DonationModel> donations;
  final List<DonationModel>? pendingDonation;
  final List<DonationModel>? acceptedDonation;
  final List<DonationModel>? completedDonation;

  const DonationsLoadedState({
    required this.donations,
     this.pendingDonation,
     this.acceptedDonation,
     this.completedDonation,
  });

  @override
  List<Object?> get props =>
      [donations, pendingDonation, acceptedDonation, completedDonation];
}

class SingleDonationLoadedState extends DonationState {
  final DonationModel donation;

  const SingleDonationLoadedState(this.donation);

  @override
  List<Object?> get props => [donation];
}

class DonationErrorState extends DonationState {
  final String? message;

  const DonationErrorState([this.message = 'Something went wrong!']);

  @override
  List<Object?> get props => [message];
}
