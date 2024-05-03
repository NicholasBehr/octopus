import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TransactionData extends Equatable {
  const TransactionData({
    this.uid,
    this.transactionDate,
    this.transactionValue,
  }) : assert(uid != '', 'uid cannot be empty');

  /// Create [TransactionData] model from firebase [DocumentSnapshot]
  factory TransactionData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    // function format defined by firestore
    // ignore: avoid_unused_constructor_parameters
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TransactionData(
      uid: snapshot.reference.id,
      transactionDate: (data?['transactionDate'] as Timestamp?)?.toDate(),
      transactionValue: data?['transactionValue'] as double?,
    );
  }

  /// The unique identifier of the transaction within the account.
  ///
  /// Can be null if the transaction is not in the database
  /// Cannot be empty
  final String? uid;

  /// This is the date on which the actual transaction occurs.
  /// It is the day when goods are sold, services are rendered,
  /// or any other financial activity takes place.
  final DateTime? transactionDate;

  /// This term is used to describe the total monetary value of a transaction.
  /// The sign of the number is positive if it's an increase (debit)
  /// or negative decrease (credit) to the account.
  final double? transactionValue;

  /// Create firebase json from [TransactionData] model
  Map<String, dynamic> toFirestore() {
    return {
      if (transactionDate != null)
        'transactionDate': Timestamp.fromDate(transactionDate!),
      if (transactionValue != null) 'transactionValue': transactionValue,
    };
  }

  @override
  List<Object?> get props => [uid, transactionDate, transactionValue];
}
