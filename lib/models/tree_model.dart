class TreeNodeData {
  final String name;
  final String id;
  final String type;
  final String? parentId;
  final String? sensorType;
  final String? status;
  final String? locationId;
  final List<TreeNodeData> children;

  TreeNodeData({
    required this.name,
    required this.id,
    required this.type,
    this.parentId,
    this.sensorType,
    this.status,
    this.locationId,
    this.children = const [],
  });

  factory TreeNodeData.fromJson(Map<String, dynamic> json) {
    return TreeNodeData(
      name: json['name'],
      id: json['id'],
      type: json['type'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      status: json['status'],
      locationId: json['locationId'],
      children: (json['children'] as List).map((child) => TreeNodeData.fromJson(child)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'type': type,
      if (sensorType != null) 'sensorType': sensorType,
      if (status != null) 'status': status,
      if (locationId != null) 'locationId': locationId,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  bool validate() {
    return name.isNotEmpty && id.isNotEmpty;
  }
}
