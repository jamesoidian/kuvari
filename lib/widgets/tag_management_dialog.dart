import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuvari_app/models/tag.dart';
import 'package:kuvari_app/models/image_story.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';
import 'package:kuvari_app/services/storage_constants.dart';

class TagManagementDialog extends StatefulWidget {
  final List<String> initialTagIds;
  final Box<Tag>? tagsBox;
  final Box<ImageStory>? imageStoriesBox;

  const TagManagementDialog({
    super.key,
    required this.initialTagIds,
    this.tagsBox,
    this.imageStoriesBox,
  });

  @override
  State<TagManagementDialog> createState() => _TagManagementDialogState();
}

class _TagManagementDialogState extends State<TagManagementDialog> {
  late final Box<Tag> _tagsBox;
  late final Box<ImageStory> _storiesBox;
  late List<String> _selectedTagIds;

  @override
  void initState() {
    super.initState();
    _tagsBox = widget.tagsBox ?? Hive.box<Tag>(StorageConstants.tagsBox);
    _storiesBox = widget.imageStoriesBox ?? Hive.box<ImageStory>(StorageConstants.imageStoriesBox);
    _selectedTagIds = List<String>.from(widget.initialTagIds);
  }
  String _searchQuery = '';
  final TextEditingController _newTagNameController = TextEditingController();

  @override
  void dispose() {
    _newTagNameController.dispose();
    super.dispose();
  }

  void _showCreateTagDialog({Tag? tagToEdit}) {
    final bool isEditing = tagToEdit != null;
    _newTagNameController.text = isEditing ? tagToEdit.name : '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.createTag),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _newTagNameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.tagName,
                    ),
                    onChanged: (value) => setDialogState(() {}),
                    autofocus: true,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                ElevatedButton(
                  onPressed: _newTagNameController.text.trim().isEmpty
                      ? null
                      : () async {
                          final name = _newTagNameController.text.trim();
                          if (isEditing) {
                            final updatedTag =
                                Tag(name: name, id: tagToEdit.id);
                            await _tagsBox.put(
                                tagToEdit.key ?? tagToEdit.id, updatedTag);
                          } else {
                            final newTag = Tag(name: name);
                            await _tagsBox.add(newTag);
                            setState(() {
                              _selectedTagIds.add(newTag.id);
                            });
                          }
                          if (mounted) Navigator.pop(context);
                        },
                  child: Text(AppLocalizations.of(context)!.ok),
                ),
              ],
            );
          },
        );
      },
    );
  }

  int _getTagUsageCount(String tagId) {
    return _storiesBox.values
        .where((story) => story.tagIds.contains(tagId))
        .length;
  }

  Future<void> _deleteTag(Tag tag) async {
    final usageCount = _getTagUsageCount(tag.id);

    if (usageCount > 0) {
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.deleteTag),
          content: Text(AppLocalizations.of(context)!
              .tagInUseWarning(usageCount.toString())),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(AppLocalizations.of(context)!.deleteTag),
            ),
          ],
        ),
      );

      if (confirm != true) return;
    }

    // Update stories
    final storiesToUpdate = _storiesBox.values
        .where((story) => story.tagIds.contains(tag.id))
        .toList();
    for (final story in storiesToUpdate) {
      final newTagIds = List<String>.from(story.tagIds)..remove(tag.id);
      await _storiesBox.put(
          story.key ?? story.id,
          ImageStory(
            id: story.id,
            name: story.name,
            images: story.images,
            tagIds: newTagIds,
          ));
    }

    // Delete tag
    await _tagsBox.delete(tag.key ?? tag.id);
    setState(() {
      _selectedTagIds.remove(tag.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.manageTags),
      content: SizedBox(
        width: double.maxFinite,
        height: 300, // Reduced height to prevent overflows in test environments
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchTags,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _tagsBox.listenable(),
                builder: (context, Box<Tag> box, _) {
                  final tags = box.values
                      .where((tag) =>
                          tag.name.toLowerCase().contains(_searchQuery))
                      .toList();

                  if (tags.isEmpty && _searchQuery.isEmpty) {
                    return Center(
                      child: Text(AppLocalizations.of(context)!.noResults),
                    );
                  }

                  return ListView.builder(
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      final tag = tags[index];
                      final isSelected = _selectedTagIds.contains(tag.id);
                      final usageCount = _getTagUsageCount(tag.id);

                      return ListTile(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedTagIds.remove(tag.id);
                            } else {
                              _selectedTagIds.add(tag.id);
                            }
                          });
                        },
                        leading: Checkbox(
                          value: isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                _selectedTagIds.add(tag.id);
                              } else {
                                _selectedTagIds.remove(tag.id);
                              }
                            });
                          },
                        ),
                        title: Text(tag.name),
                        subtitle: usageCount == 0
                            ? Text(
                                AppLocalizations.of(context)!.unused,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              )
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () =>
                                  _showCreateTagDialog(tagToEdit: tag),
                              tooltip: AppLocalizations.of(context)!.editTag,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  size: 20, color: Colors.red),
                              onPressed: () => _deleteTag(tag),
                              tooltip: AppLocalizations.of(context)!.deleteTag,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _showCreateTagDialog,
          child: Text(AppLocalizations.of(context)!.addTag),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _selectedTagIds),
          child: Text(AppLocalizations.of(context)!.ok),
        ),
      ],
    );
  }
}
