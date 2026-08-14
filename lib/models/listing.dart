/// Whether a listing represents an item that was lost or one that was found.
enum ListingType { lost, found }

/// A single Lost and Found board entry.
///
/// [id] is a monotonically increasing counter rather than the item's
/// position in the list, so edits and deletes stay correct even after the
/// list has been reordered or filtered.
class Listing {
  Listing({
    required this.id,
    required this.type,
    required this.description,
    required this.location,
    DateTime? dateReported,
  }) : dateReported = dateReported ?? DateTime.now();

  final int id;
  ListingType type;
  String description;
  String location;
  final DateTime dateReported;
}
