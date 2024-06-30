// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TreeStore on _TreeStore, Store {
  Computed<List<TreeNodeData>>? _$filteredTreeDataComputed;

  @override
  List<TreeNodeData> get filteredTreeData => (_$filteredTreeDataComputed ??=
          Computed<List<TreeNodeData>>(() => super.filteredTreeData,
              name: '_TreeStore.filteredTreeData'))
      .value;

  late final _$treeDataAtom =
      Atom(name: '_TreeStore.treeData', context: context);

  @override
  ObservableList<TreeNodeData> get treeData {
    _$treeDataAtom.reportRead();
    return super.treeData;
  }

  @override
  set treeData(ObservableList<TreeNodeData> value) {
    _$treeDataAtom.reportWrite(value, super.treeData, () {
      super.treeData = value;
    });
  }

  late final _$expandedNodesAtom =
      Atom(name: '_TreeStore.expandedNodes', context: context);

  @override
  ObservableSet<String> get expandedNodes {
    _$expandedNodesAtom.reportRead();
    return super.expandedNodes;
  }

  @override
  set expandedNodes(ObservableSet<String> value) {
    _$expandedNodesAtom.reportWrite(value, super.expandedNodes, () {
      super.expandedNodes = value;
    });
  }

  late final _$searchTextAtom =
      Atom(name: '_TreeStore.searchText', context: context);

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$filterEnergySensorsAtom =
      Atom(name: '_TreeStore.filterEnergySensors', context: context);

  @override
  bool get filterEnergySensors {
    _$filterEnergySensorsAtom.reportRead();
    return super.filterEnergySensors;
  }

  @override
  set filterEnergySensors(bool value) {
    _$filterEnergySensorsAtom.reportWrite(value, super.filterEnergySensors, () {
      super.filterEnergySensors = value;
    });
  }

  late final _$filterAlertsAtom =
      Atom(name: '_TreeStore.filterAlerts', context: context);

  @override
  bool get filterAlerts {
    _$filterAlertsAtom.reportRead();
    return super.filterAlerts;
  }

  @override
  set filterAlerts(bool value) {
    _$filterAlertsAtom.reportWrite(value, super.filterAlerts, () {
      super.filterAlerts = value;
    });
  }

  late final _$_TreeStoreActionController =
      ActionController(name: '_TreeStore', context: context);

  @override
  void loadTreeData(List<TreeNodeData> data) {
    final _$actionInfo = _$_TreeStoreActionController.startAction(
        name: '_TreeStore.loadTreeData');
    try {
      return super.loadTreeData(data);
    } finally {
      _$_TreeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleExpansion(TreeNodeData node) {
    final _$actionInfo = _$_TreeStoreActionController.startAction(
        name: '_TreeStore.toggleExpansion');
    try {
      return super.toggleExpansion(node);
    } finally {
      _$_TreeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSearchText(String text) {
    final _$actionInfo = _$_TreeStoreActionController.startAction(
        name: '_TreeStore.updateSearchText');
    try {
      return super.updateSearchText(text);
    } finally {
      _$_TreeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFilterEnergySensors() {
    final _$actionInfo = _$_TreeStoreActionController.startAction(
        name: '_TreeStore.toggleFilterEnergySensors');
    try {
      return super.toggleFilterEnergySensors();
    } finally {
      _$_TreeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFilterAlerts() {
    final _$actionInfo = _$_TreeStoreActionController.startAction(
        name: '_TreeStore.toggleFilterAlerts');
    try {
      return super.toggleFilterAlerts();
    } finally {
      _$_TreeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
treeData: ${treeData},
expandedNodes: ${expandedNodes},
searchText: ${searchText},
filterEnergySensors: ${filterEnergySensors},
filterAlerts: ${filterAlerts},
filteredTreeData: ${filteredTreeData}
    ''';
  }
}
