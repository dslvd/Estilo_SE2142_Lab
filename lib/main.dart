import 'package:flutter/material.dart';

import 'models/listing.dart';

void main() => runApp(const LostAndFoundApp());

class LostAndFoundApp extends StatelessWidget {
  const LostAndFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lost and Found Board',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const LostAndFoundHome(),
    );
  }
}

class LostAndFoundHome extends StatefulWidget {
  const LostAndFoundHome({super.key});

  @override
  State<LostAndFoundHome> createState() => _LostAndFoundHomeState();
}

class _LostAndFoundHomeState extends State<LostAndFoundHome> {
  final List<Listing> _listings = [];
  int _nextId = 1;

  Future<void> _openCreateDialog() async {
    final result = await showDialog<_ListingFormResult>(
      context: context,
      builder: (context) => const _ListingFormDialog(),
    );
    if (result == null) return;

    setState(() {
      _listings.add(
        Listing(
          id: _nextId++,
          type: result.type,
          description: result.description,
          location: result.location,
        ),
      );
    });
  }

  Future<void> _openEditDialog(Listing listing) async {
    final result = await showDialog<_ListingFormResult>(
      context: context,
      builder: (context) => _ListingFormDialog(existing: listing),
    );
    if (result == null) return;

    setState(() {
      listing.type = result.type;
      listing.description = result.description;
      listing.location = result.location;
    });
  }

  Future<void> _confirmDelete(Listing listing) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove this listing?'),
        content: Text(
          'This will remove "${listing.description}" from the board. '
          'Use this once the item has been claimed or returned.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ), // TextButton
          FilledButton.tonal(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ), // FilledButton
        ],
      ), // AlertDialog
    );

    if (confirmed != true) return;

    setState(() {
      _listings.removeWhere((item) => item.id == listing.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lost and Found Board')),
      body: _listings.isEmpty ? const _EmptyState() : _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateDialog,
        tooltip: 'Report a lost or found item',
        child: const Icon(Icons.add),
      ), // FloatingActionButton
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _listings.length,
      itemBuilder: (context, index) {
        final listing = _listings[index];
        final isLost = listing.type == ListingType.lost;
        final statusColor = isLost ? Colors.red.shade400 : Colors.green.shade600;

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: statusColor.withValues(alpha: 0.15),
              child: Icon(
                isLost ? Icons.help_outline : Icons.check_circle_outline,
                color: statusColor,
              ), // Icon
            ), // CircleAvatar
            title: Text(listing.description),
            subtitle: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ), // BoxDecoration
                  child: Text(
                    isLost ? 'LOST' : 'FOUND',
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ), // TextStyle
                  ), // Text
                ), // Container
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    listing.location,
                    overflow: TextOverflow.ellipsis,
                  ), // Text
                ), // Expanded
              ],
            ), // Row
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit listing',
                  onPressed: () => _openEditDialog(listing),
                ), // IconButton
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Remove listing',
                  onPressed: () => _confirmDelete(listing),
                ), // IconButton
              ],
            ), // Row
          ),
        ); // Card
      },
    ); // ListView.builder
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No listings yet',
              style: Theme.of(context).textTheme.titleMedium,
            ), // Text
            const SizedBox(height: 4),
            Text(
              'Tap the + button to report a lost or found item.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ), // Text
          ],
        ), // Column
      ), // Padding
    ); // Center
  }
}

/// The values collected by [_ListingFormDialog] when the user saves.
class _ListingFormResult {
  const _ListingFormResult({
    required this.type,
    required this.description,
    required this.location,
  });

  final ListingType type;
  final String description;
  final String location;
}

/// Shared Create/Update form. When [existing] is null the dialog is in
/// "create" mode; when it holds a [Listing], the fields are pre-filled and
/// the dialog is in "edit" mode. Either way it just pops a [_ListingFormResult]
/// and lets the caller decide whether to add or replace a listing.
class _ListingFormDialog extends StatefulWidget {
  const _ListingFormDialog({this.existing});

  final Listing? existing;

  @override
  State<_ListingFormDialog> createState() => _ListingFormDialogState();
}

class _ListingFormDialogState extends State<_ListingFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;
  late ListingType _type;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _descriptionController = TextEditingController(text: existing?.description ?? '');
    _locationController = TextEditingController(text: existing?.location ?? '');
    _type = existing?.type ?? ListingType.lost;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(
      _ListingFormResult(
        type: _type,
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Listing' : 'Report an Item'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<ListingType>(
                initialValue: _type,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: ListingType.lost, child: Text('Lost')),
                  DropdownMenuItem(value: ListingType.found, child: Text('Found')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _type = value);
                },
              ), // DropdownButtonFormField
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Item description',
                  hintText: 'e.g. Black umbrella with a wooden handle',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please describe the item';
                  }
                  return null;
                },
              ), // TextFormField
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'e.g. Library, 2nd floor',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ), // TextFormField
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Form
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ), // TextButton
        FilledButton(
          onPressed: _submit,
          child: const Text('Save'),
        ), // FilledButton
      ],
    ); // AlertDialog
  }
}
