import 'package:mobx/mobx.dart';

import '../models/tree_model.dart';

part 'tree_store.g.dart';

class TreeStore = _TreeStore with _$TreeStore;

abstract class _TreeStore with Store {
  @observable
  ObservableList<TreeNodeData> treeData = ObservableList<TreeNodeData>();

  @observable
  ObservableSet<String> expandedNodes = ObservableSet<String>();

  @observable
  String searchText = '';

  @observable
  bool filterEnergySensors = false;

  @observable
  bool filterAlerts = false;

  @computed
  List<TreeNodeData> get filteredTreeData {
    return _filterNodes(treeData);
  }

  @action
  void loadTreeData(List<TreeNodeData> data) {
    treeData = ObservableList.of(data);
    expandedNodes = ObservableSet.of(data.map((node) => node.id));
  }

  @action
  void toggleExpansion(TreeNodeData node) {
    if (expandedNodes.contains(node.id)) {
      expandedNodes.remove(node.id);
    } else {
      expandedNodes.add(node.id);
    }
  }

  @action
  void updateSearchText(String text) {
    searchText = text;
  }

  @action
  void toggleFilterEnergySensors() {
    filterEnergySensors = !filterEnergySensors;
  }

  @action
  void toggleFilterAlerts() {
    filterAlerts = !filterAlerts;
  }

  List<TreeNodeData> _filterNodes(List<TreeNodeData> nodes) {
    List<TreeNodeData> result = [];
    for (var node in nodes) {
      if (_matchesFilter(node)) {
        result.add(node);
      } else if (node.children.isNotEmpty) {
        var filteredChildren = _filterNodes(node.children);
        if (filteredChildren.isNotEmpty) {
          result.add(TreeNodeData(
            name: node.name,
            id: node.id,
            type: node.type,
            parentId: node.parentId,
            sensorType: node.sensorType,
            status: node.status,
            locationId: node.locationId,
            children: filteredChildren,
          ));
        }
      }
    }
    return result;
  }

  bool _matchesFilter(TreeNodeData node) {
    bool matchesSearch = searchText.isEmpty || node.name.toLowerCase().contains(searchText.toLowerCase());
    bool matchesEnergySensor = !filterEnergySensors || node.sensorType == 'energy';
    bool matchesAlert = !filterAlerts || node.status == 'alert';

    return matchesSearch && matchesEnergySensor && matchesAlert;
  }
}
