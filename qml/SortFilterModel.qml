import QtQuick 2.0
import QtQml.Models 2.3

DelegateModel {

    id: delegateModel

    property var filterAcceptsItem: function(item) { return true; }
    property var lessThan: function(left, right) { return true; }

    function update() {
        if (items.count > 0) {
            items.setGroups(0, items.count, "items");
        }

        // Filter items
        var visible = [];
        for (var i = 0; i < items.count; ++i) {
            var item = items.get(i);
            if (filterAcceptsItem(item.model)) {
                visible.push(item);
            }
        }

        // Sort the list of visible items
         visible.sort(function(a, b) {
             var res = lessThan(a.model, b.model) ? -1 : 1
             return res;
         });

        // Add all items to the visible group:
        for (i = 0; i < visible.length; ++i) {
            item = visible[i];
            item.inVisible = true;
            if (item.visibleIndex !== i) {
                visibleItems.move(item.visibleIndex, i, 1);
            }
        }
    }

    items.onChanged: update()
    onLessThanChanged: update()
    onFilterAcceptsItemChanged: update()

    groups: DelegateModelGroup {
        id: visibleItems

        name: "visible"
        includeByDefault: false
    }

    filterOnGroup: "visible"
}

