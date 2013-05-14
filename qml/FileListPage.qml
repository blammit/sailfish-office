import QtQuick 1.1
import Sailfish.Silica 1.0
import Sailfish.Office 1.0
import Sailfish.Office.Files 1.0

Page {
    id: page
    property alias model: listView.model;
    property string title: "Documents"

    allowedOrientations: Orientation.All;

    SilicaListView {
        id: listView;
        anchors.fill: parent
        
        /*PullDownMenu {
            MenuItem {
                text: "Action";
                onClicked: console.log("Hello World!");
            }
        }*/
        
        children: ScrollDecorator { }
        header: PageHeader { title: page.title; }
        //model: DocumentListModel { path: "/home/nemo/Documents"; }
        
        spacing: theme.paddingLarge;
        
        delegate: BackgroundItem {
            Label {
                anchors {
                    left: parent.left;
                    leftMargin: theme.paddingLarge;
                    top: parent.top;
                    topMargin: theme.paddingSmall;
                }
                text: model.fileName;
                
                font.pixelSize: theme.fontSizeLarge;
            }
            Label {
                anchors {
                    left: parent.left;
                    leftMargin: theme.paddingLarge;
                    bottom: parent.bottom;
                    bottomMargin: theme.paddingSmall;
                }
                text: model.fileType;
                
                font.pixelSize: theme.fontSizeSmall;
                color: theme.secondaryColor;
            }
            Label {
                anchors {
                    right: parent.right;
                    rightMargin: theme.paddingLarge;
                    bottom: parent.bottom;
                    bottomMargin: theme.paddingSmall;
                }
                
                text: model.fileSize;
                
                font.pixelSize: theme.fontSizeSmall;
                color: theme.secondaryColor;
            }
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    switch(model.fileDocumentClass) {
                        case DocumentListModel.TextDocument:
                            pageStack.push(textDocumentPage, { title: model.fileName, path: model.filePath, mimeType: model.fileMimeType });
                        case DocumentListModel.SpreadSheetDocument:
                            pageStack.push(spreadsheetPage, { title: model.fileName, path: model.filePath, mimeType: model.fileMimeType });
                        case DocumentListModel.PresentationDocument:
                            pageStack.push(presentationPage, { title: model.fileName, path: model.filePath, mimeType: model.fileMimeType });
                        case DocumentListModel.PDFDocument:
                            pageStack.push(pdfPage, { title: model.fileName, path: model.filePath, mimeType: model.fileMimeType });
                        default:
                            console.log("Unknown file format for file " + model.fileName + " with stated mimetype " + model.fileMimeType);
                    }
                }
            }
        }
    }

    Component {
        id: textDocumentPage;
        TextDocumentPage { }
    }

    Component {
        id: spreadsheetPage;
        SpreadsheetPage { }
    }

    Component {
        id: presentationPage;
        PresentationPage { }
    }

    Component {
        id: pdfPage;
        PDFDocumentPage { }
    }
}
