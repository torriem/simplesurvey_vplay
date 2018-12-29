import QtQuick 2.0

Row {
    //width: parent.width
    id: row1
    width: parent.width

    function __update() {
        if (children.length>1) {
            var field1 = children[0];
            field1.width = row1.width - children[1].width
        }
    }

    onChildrenChanged: __update()
    onVisibleChanged: __update()
    onWidthChanged: __update()
}
