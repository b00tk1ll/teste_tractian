import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/tree_model.dart';

Future<List<TreeNodeData>> loadTreeData(String unit) async {
  try {
    // Carrega os dados dos arquivos JSON correspondentes à unidade especificada
    final locationsData = jsonDecode(await rootBundle.loadString('assets/data/${unit}_unit_locations.json')) as List;
    final assetsData = jsonDecode(await rootBundle.loadString('assets/data/${unit}_unit_assets.json')) as List;

    // Converte os dados de localização em TreeNodeData com tipo 'location'
    final locations = locationsData.map((json) {
      return TreeNodeData.fromJson({
        ...json,
        'type': 'location',
        'children': [],
      });
    }).toList();

    // Converte os dados de ativos em TreeNodeData com tipo 'component' ou 'asset'
    final assets = assetsData.map((json) {
      return TreeNodeData.fromJson({
        ...json,
        'type': json['sensorType'] != null ? 'component' : 'asset',
        'children': [],
      });
    }).toList();

    // Combina todos os nós em uma única lista
    final allNodes = [...locations, ...assets];
    final nodesById = {for (var node in allNodes) node.id: node};

    // Constrói a estrutura da árvore
    for (var node in allNodes) {
      if (node.parentId != null && nodesById.containsKey(node.parentId)) {
        nodesById[node.parentId]!.children.add(node);
      } else if (node.locationId != null && nodesById.containsKey(node.locationId)) {
        nodesById[node.locationId]!.children.add(node);
      }
    }

    // Função para ordenar os filhos de cada nó
    void sortChildren(List<TreeNodeData> nodes) {
      for (var node in nodes) {
        if (node.children.isNotEmpty) {
          sortChildren(node.children);
        }
        node.children.sort((a, b) {
          if (a.children.isNotEmpty && b.children.isEmpty) return -1;
          if (a.children.isEmpty && b.children.isNotEmpty) return 1;
          return 0;
        });
      }
    }

    // Obtém os nós raiz (aqueles sem parentId e locationId)
    final rootNodes = allNodes.where((node) => node.parentId == null && node.locationId == null).toList();

    // Ordena os nós raiz para garantir que os nós com filhos venham primeiro
    rootNodes.sort((a, b) {
      if (a.children.isNotEmpty && b.children.isEmpty) return -1;
      if (a.children.isEmpty && b.children.isNotEmpty) return 1;
      return 0;
    });

    // Aplica a ordenação à estrutura inteira da árvore
    sortChildren(rootNodes);

    return rootNodes;
  } catch (e) {
    return [];
  }
}
