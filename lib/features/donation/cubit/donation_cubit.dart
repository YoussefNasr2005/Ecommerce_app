import 'package:ecommerce_app/features/donation/cubit/donation_state.dart';
import 'package:ecommerce_app/features/donation/data/data_sources/donation_local_data_source.dart';
import 'package:ecommerce_app/features/donation/data/models/donation_clothes_model.dart';
import 'package:ecommerce_app/features/donation/data/models/donation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationCubit extends Cubit<DonationState> {
  final DonationLocalDataSource _dataSource;

  DonationCubit(this._dataSource) : super(const DonationInitialState());

  DonationClothesModel? selectedClothes;
  DonationStatus? status;
  String? selectedOrganization;
  String? selectedContactPhone;
  String? selectedPickupTime;

  String get organizationName => selectedOrganization ?? 'Not specified';
  String get contactType => selectedContactPhone ?? 'Not specified';
  String get pickupTime => selectedPickupTime ?? 'Not specified';

  void setSelectedClothes(DonationClothesModel clothes) {
    selectedClothes = clothes;
  }

  void setSelectedOrganization(String organization) {
    selectedOrganization = organization;
  }

  void setContactPhoneAndPicupTime(String contactPhone, String pickupTime) {
    selectedContactPhone = contactPhone;
    selectedPickupTime = pickupTime;
  }

  Future<void> submitDonation() async {
    emit(const DonationLoadingState());
    try {
      final donation = DonationModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          clothes: selectedClothes!,
          organizationName: selectedOrganization!,
          contactMethod: selectedContactPhone!,
          pickupTime: selectedPickupTime!,
          status: DonationStatus.pending,
          createdAt: DateTime.now());

      await _dataSource.saveDonation(donation);
      emit(const DonationSubmitSuccessState());
    } catch (_) {
      emit(const DonationErrorState());
    }
  }

  void fetchAllDonations() {
    emit(const DonationLoadingState());
    try {
      final donations = _dataSource.getAllDonations();
      final pendingDonation = _dataSource.getPendingDonations();
      final acceptedDonation = _dataSource.getAcceptedDonations();
      final completedDonation = _dataSource.getCompletedDonations();

      emit(DonationsLoadedState(
          donations: donations,
          pendingDonation: pendingDonation,
          acceptedDonation: acceptedDonation,
          completedDonation: completedDonation));
    } catch (e) {
      emit(DonationErrorState(e.toString()));
    }
  }

  void fetchAcceptedDonations() {
    emit(const DonationLoadingState());
    try {
      final acceptedDonations = _dataSource.getAcceptedDonations();
      emit(DonationsLoadedState(donations: acceptedDonations));
    } catch (e) {
      emit(DonationErrorState(e.toString()));
    }
  }

  void fetchCompletedDonations() {
    emit(const DonationLoadingState());
    try {
      final completedDonations = _dataSource.getCompletedDonations();
      emit(DonationsLoadedState(donations: completedDonations));
    } catch (e) {
      emit(DonationErrorState(e.toString()));
    }
  }

  void fetchPendingDonations() {
    emit(const DonationLoadingState());
    try {
      final pendingDonations = _dataSource.getPendingDonations();
      emit(DonationsLoadedState(donations: pendingDonations));
    } catch (e) {
      emit(DonationErrorState(e.toString()));
    }
  }

  Future<void> addDonation(DonationModel donationModel) async {
    emit(const DonationLoadingState());
    try {
      await _dataSource.saveDonation(donationModel);
      emit(const DonationSubmitSuccessState());
    } catch (e) {
      emit(DonationErrorState(e.toString()));
    }
  }

  Future<void> removeDonation(String id) async {
    emit(const DonationLoadingState());
    try {
      await _dataSource.deleteDonation(id);
      fetchAllDonations();
    } catch (e) {
      emit(DonationErrorState(e.toString()));
    }
  }
}
