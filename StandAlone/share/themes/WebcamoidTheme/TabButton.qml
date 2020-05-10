/* Webcamoid, webcam capture application.
 * Copyright (C) 2019  Gonzalo Exequiel Pedone
 *
 * Webcamoid is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamoid is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
 *
 * Web-Site: http://webcamoid.github.io/
 */

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Templates 2.5 as T
import Ak 1.0
import "Private"

T.TabButton {
    id: control
    font.bold: true
    icon.width: AkUnit.create(18 * AkTheme.controlScale, "dp").pixels
    icon.height: AkUnit.create(18 * AkTheme.controlScale, "dp").pixels
    icon.color: AkTheme.palette.active.windowText
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    padding: AkUnit.create(8 * AkTheme.controlScale, "dp").pixels
    spacing: AkUnit.create(8 * AkTheme.controlScale, "dp").pixels
    hoverEnabled: true

    readonly property int animationTime: 200

    contentItem: Item {
        id: buttonContent
        implicitWidth:
            iconLabel.implicitWidth
            + AkUnit.create(18 * AkTheme.controlScale, "dp").pixels
        implicitHeight: iconLabel.implicitHeight

        IconLabel {
            id: iconLabel
            spacing: control.spacing
            mirrored: control.mirrored
            display: control.display
            anchors.verticalCenter: buttonContent.verticalCenter
            anchors.horizontalCenter: buttonContent.horizontalCenter
            iconName: control.icon.name
            iconSource: control.icon.source
            iconWidth: control.icon.width
            iconHeight: control.icon.height
            iconColor: control.icon.color
            text: control.text
            font: control.font
            color: AkTheme.palette.active.windowText
            enabled: control.enabled
        }
    }

    background: Rectangle {
        id: buttonRectangleBelow
        implicitWidth:
            AkUnit.create(64 * AkTheme.controlScale, "dp").pixels
        implicitHeight:
            AkUnit.create(36 * AkTheme.controlScale, "dp").pixels
        color: AkTheme.shade(AkTheme.palette.active.window, 0.0, 0.0)
    }

    states: [
        State {
            name: "Disabled"
            when: !control.enabled

            PropertyChanges {
                target: iconLabel
                color: AkTheme.palette.disabled.windowText
            }
            PropertyChanges {
                target: buttonRectangleBelow
                color: AkTheme.shade(AkTheme.palette.disabled.window, 0.0, 0.0)
            }
        },
        State {
            name: "Hovered"
            when: control.enabled
                  && !control.checked
                  && (control.hovered
                      || control.visualFocus
                      || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: buttonRectangleBelow
                color: AkTheme.constShade(AkTheme.palette.active.highlight,
                                                0.0,
                                                0.1)
            }
        },
        State {
            name: "Pressed"
            when: control.enabled
                  && !control.checked
                  && control.pressed

            PropertyChanges {
                target: buttonRectangleBelow
                color: AkTheme.constShade(AkTheme.palette.active.highlight,
                                                0.0,
                                                0.2)
            }
        },
        State {
            name: "Checked"
            when: control.enabled
                  && control.checked
                  && !(control.hovered
                       || control.visualFocus
                       || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: iconLabel
                color: AkTheme.palette.active.highlight
            }
        },
        State {
            name: "CheckedHovered"
            when: control.enabled
                  && control.checked
                  && (control.hovered
                      || control.visualFocus
                      || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: iconLabel
                color: AkTheme.palette.active.highlight
            }
            PropertyChanges {
                target: buttonRectangleBelow
                color: AkTheme.constShade(AkTheme.palette.active.highlight,
                                                0.0,
                                                0.3)
            }
        },
        State {
            name: "CheckedPressed"
            when: control.enabled
                  && control.checked
                  && control.pressed

            PropertyChanges {
                target: iconLabel
                color: AkTheme.palette.active.highlight
            }
            PropertyChanges {
                target: buttonRectangleBelow
                color: AkTheme.constShade(AkTheme.palette.active.highlight,
                                                0.0,
                                                0.4)
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            target: iconLabel
            properties: "color,icon.color"
            duration: control.animationTime
        }
        ColorAnimation {
            target: buttonRectangleBelow
            duration: control.animationTime
        }
    }
}
