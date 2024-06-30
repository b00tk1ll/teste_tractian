import 'package:flutter/material.dart';

import '../../models/tree_model.dart';
import '../../store/tree_store.dart';
import '../../utils/normalize_data.dart';
import '../widgets/appbar.dart';
import '../widgets/tree.dart';

class AssetsScreen extends StatefulWidget {
  final String unit;
  const AssetsScreen({super.key, required this.unit});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  late TreeStore treeStore;

  @override
  void didChangeDependencies() {
    treeStore = TreeStore();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(
              leading: true,
              title: Text(
                "Assets",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: FutureBuilder<List<TreeNodeData>>(
              future: loadTreeData(widget.unit),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading data: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  treeStore.loadTreeData(snapshot.data!);
                  return TreeView(treeStore: treeStore);
                }
              },
              // ),
            )));
  }
}
