import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/tree_model.dart';
import '../../store/tree_store.dart';

class TreeView extends StatelessWidget {
  final TreeStore treeStore;

  const TreeView({super.key, required this.treeStore});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 8),
        _buildFilterButtons(),
        const SizedBox(height: 16),
        const Divider(color: Color(0xFFEAEEF2), thickness: 1, height: 1),
        const SizedBox(height: 8),
        Expanded(
          child: Observer(
            builder: (_) => CustomTreeView(
              nodes: treeStore.filteredTreeData,
              treeStore: treeStore,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextField(
        style: const TextStyle(color: Color(0xFF8E98A3)),
        cursorColor: const Color(0xFF8E98A3),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              colorFilter: const ColorFilter.mode(Color(0xFF8E98A3), BlendMode.srcIn),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(maxWidth: 38, maxHeight: 14),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          filled: true,
          fillColor: const Color(0xFFEAEFF3),
          hintText: 'Buscar Ativo ou Local',
          hintStyle: const TextStyle(
            color: Color(0xFF8E98A3),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          constraints: const BoxConstraints(maxHeight: 32),
        ),
        onChanged: treeStore.updateSearchText,
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Observer(
            builder: (_) => _buildFilterButton(
              onPressed: treeStore.toggleFilterEnergySensors,
              isActive: treeStore.filterEnergySensors,
              icon: 'assets/icons/bolt.svg',
              label: 'Sensor de Energia',
            ),
          ),
          const SizedBox(width: 8),
          Observer(
            builder: (_) => _buildFilterButton(
              onPressed: treeStore.toggleFilterAlerts,
              isActive: treeStore.filterAlerts,
              icon: 'assets/icons/ExclamationCircle.svg',
              label: 'Crítico',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required VoidCallback onPressed,
    required bool isActive,
    required String icon,
    required String label,
  }) {
    return SizedBox(
      height: 32,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            isActive ? const Color(0xFF2188FF) : Colors.white,
          ),
          alignment: Alignment.centerLeft,
          side: WidgetStateProperty.all(const BorderSide(color: Color(0xFFD8DFE6))),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              height: 16,
              width: 16,
              colorFilter: ColorFilter.mode(
                isActive ? Colors.white : const Color(0xFF77818C),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF77818C),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTreeView extends StatelessWidget {
  final List<TreeNodeData> nodes;
  final TreeStore treeStore;

  const CustomTreeView({
    super.key,
    required this.nodes,
    required this.treeStore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nodes.length,
      itemBuilder: (context, index) {
        return _buildTreeNode(nodes[index], 0);
      },
    );
  }

  Widget _buildTreeNode(TreeNodeData node, int level) {
    return Observer(
      builder: (_) {
        final isExpanded = treeStore.expandedNodes.contains(node.id);
        final hasChildren = node.children.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: hasChildren ? () => treeStore.toggleExpansion(node) : null,
              child: Padding(
                padding: EdgeInsets.only(left: hasChildren || level > 0 ? level * 16 : 0, bottom: 9),
                child: _buildTreeNodeContent(node, isExpanded, hasChildren, level),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: isExpanded && hasChildren ? null : 0,
              child: isExpanded && hasChildren
                  ? ListView.builder(
                      itemCount: node.children.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildTreeNode(node.children[index], level + 1);
                      },
                    )
                  : null,
            ),
          ],
        );
      },
    );
  }

  Widget _buildTreeNodeContent(
    TreeNodeData data,
    bool isExpanded,
    bool hasChildren,
    int level,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: !hasChildren && level > 0 ? 26 : 8),
      child: Row(
        children: [
          if (hasChildren)
            SvgPicture.asset(
              isExpanded ? 'assets/icons/Up.svg' : 'assets/icons/Down.svg',
              height: 12,
              width: 12,
            ),
          SizedBox(width: hasChildren ? 6 : 0),
          _getIconForNode(data),
          const SizedBox(width: 8),
          Text(
            data.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          if (data.status != null) ...[
            const SizedBox(width: 4),
            data.status != 'alert'
                ? SvgPicture.asset(
                    'assets/icons/AiFillThunderbolt.svg',
                    height: 14,
                    width: 14,
                    colorFilter: const ColorFilter.mode(Color(0xFF52C41A), BlendMode.srcIn),
                  )
                : Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
          ],
        ],
      ),
    );
  }

  Widget _getIconForNode(TreeNodeData data) {
    final String iconPath;
    switch (data.type) {
      case 'location':
        iconPath = 'assets/icons/GoLocation.svg';
        break;
      case 'asset':
        iconPath = 'assets/icons/IoCubeOutline.svg';
        break;
      case 'component':
        iconPath = 'assets/icons/Codepen.svg';
        break;
      default:
        iconPath = 'assets/icons/IoCubeOutline.svg';
        break;
    }

    return SvgPicture.asset(
      iconPath,
      height: 24,
      width: 24,
      colorFilter: const ColorFilter.mode(Color(0xFF2188FF), BlendMode.srcIn),
    );
  }
}
