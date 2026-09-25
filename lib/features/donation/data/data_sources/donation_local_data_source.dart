import 'package:ecommerce_app/features/donation/data/models/donation_model.dart';
import 'package:hive_flutter/adapters.dart';

class DonationLocalDataSource {
  final Box<DonationModel> _donationBox;
  DonationLocalDataSource(this._donationBox);

  Future<void> saveDonation(DonationModel donation) async {
    return await _donationBox.put(donation.id, donation);
  }

  Future<void> deleteDonation(String donationId) async {
    return await _donationBox.delete(donationId);
  }

  List<DonationModel> getAllDonations() {
    return _donationBox.values.toList();
  }

  List<DonationModel> getPendingDonations() {
    return _donationBox.values
        .where((d) => d.status == DonationStatus.pending)
        .toList();
  }

  List<DonationModel> getAcceptedDonations() {
    return _donationBox.values
        .where((d) => d.status == DonationStatus.accepted)
        .toList();
  }

  List<DonationModel> getCompletedDonations() {
    return _donationBox.values
        .where((d) => d.status == DonationStatus.completed)
        .toList();
  }
}
