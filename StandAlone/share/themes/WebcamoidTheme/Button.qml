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

T.Button {
    id: control
    font.bold: true
    icon.width: AkUnit.create(18 * AkTheme.controlScale, "dp").pixels
    icon.height: AkUnit.create(18 * AkTheme.controlScale, "dp").pixels
    icon.color: AkTheme.palette.active.buttonText
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    padding: AkUnit.create(8 * AkTheme.controlScale, "dp").pixels
    spacing: AkUnit.create(8 * AkTheme.controlScale, "dp").pixels
    hoverEnabled: true

    readonly property int radius:
        AkUnit.create(6 * AkTheme.controlScale, "dp").pixels
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
            iconName: control.icon.name
            iconSource: control.icon.source
            iconWidth: control.icon.width
            iconHeight: control.icon.height
            iconColor:
                control.highlighted?
                    AkTheme.palette.active.highlightedText:
                control.flat?
                    AkTheme.palette.active.highlight:
                    control.icon.color
            text: control.text
            font: control.font
            color:
                control.highlighted?
                    AkTheme.palette.active.highlightedText:
                control.flat?
                    AkTheme.palette.active.highlight:
                    AkTheme.palette.active.buttonText
            enabled: control.enabled
            anchors.verticalCenter: buttonContent.verticalCenter
            anchors.horizontalCenter: buttonContent.horizontalCenter
        }
    }
    background: Item {
        id: back
        implicitWidth:
            AkUnit.create(64 * AkTheme.controlScale, "dp").pixels
        implicitHeight:
            AkUnit.create(36 * AkTheme.controlScale, "dp").pixels

        // Rectangle
        Rectangle {
            id: buttonRectangle
            anchors.fill: parent
            radius: AkUnit.create(6 * AkTheme.controlScale, "dp").pixels
            border.width:
                AkUnit.create(1 * AkTheme.controlScale, "dp").pixels
            border.color:
                control.highlighted || control.flat?
                    AkTheme.shade(AkTheme.palette.active.window, 0, 0):
                    AkTheme.palette.active.dark
            color: control.highlighted?
                       AkTheme.palette.active.highlight:
                   control.flat?
                       AkTheme.shade(AkTheme.palette.active.window, 0, 0):
                       AkTheme.palette.active.button

            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: AkTheme.palette.active.window.hslLightness < 0.5?
                               Qt.tint(buttonRectangle.color,
                                       AkTheme.shade(AkTheme.palette.active.dark, 0, 0.25)):
                               Qt.tint(buttonRectangle.color,
                                       AkTheme.shade(AkTheme.palette.active.light, 0, 0.25))
                }
                GradientStop {
                    position: 1
                    color: AkTheme.palette.active.window.hslLightness < 0.5?
                               Qt.tint(buttonRectangle.color,
                                       AkTheme.shade(AkTheme.palette.active.light, 0, 0.25)):
                               Qt.tint(buttonRectangle.color,
                                       AkTheme.shade(AkTheme.palette.active.dark, 0, 0.25))
                }
            }
        }

        // Checked indicator
        Rectangle {
            id: buttonCheckableIndicator
            height: AkUnit.create(8 * AkTheme.controlScale, "dp").pixels
            color:
                control.checkable && control.checked && control.highlighted?
                    AkTheme.palette.active.highlightedText:
                control.checkable && control.checked?
                    AkTheme.palette.active.highlight:
                control.checkable?
                    AkTheme.palette.active.dark:
                control.highlighted || control.flat?
                    AkTheme.shade(AkTheme.palette.active.window, 0, 0):
                    AkTheme.palette.active.dark
            anchors.right: back.right
            anchors.bottom: back.bottom
            anchors.left: back.left
            visible: control.checkable
        }
    }

    states: [
        State {
            name: "Disabled"
            when: !control.enabled

            PropertyChanges {
                target: iconLabel
                color: control.highlighted?
                           AkTheme.palette.disabled.highlightedText:
                       control.flat?
                           AkTheme.palette.disabled.highlight:
                           AkTheme.palette.disabled.buttonText
            }
            PropertyChanges {
                target: buttonCheckableIndicator
                color:
                    control.checkable && control.checked && control.highlighted?
                        AkTheme.palette.disabled.highlightedText:
                    control.checkable && control.checked?
                        AkTheme.palette.disabled.highlight:
                    control.checkable?
                        AkTheme.palette.disabled.dark:
                    control.highlighted || control.flat?
                        AkTheme.shade(AkTheme.palette.disabled.window, 0, 0):
                        AkTheme.palette.disabled.dark
            }
            PropertyChanges {
                target: buttonRectangle
                border.color:
                    control.highlighted || control.flat?
                        AkTheme.shade(AkTheme.palette.disabled.window, 0, 0):
                        AkTheme.palette.disabled.dark
                color: control.highlighted?
                           AkTheme.palette.disabled.highlight:
                       control.flat?
                           AkTheme.shade(AkTheme.palette.disabled.window, 0, 0):
                           AkTheme.palette.disabled.button
            }
        },
        State {
            name: "Hovered"
            when: control.enabled
                  && control.hovered
                  && !(control.activeFocus || control.visualFocus)
                  && !control.pressed

            PropertyChanges {
                target: buttonRectangle
                color: control.highlighted?
                           AkTheme.constShade(AkTheme.palette.active.highlight, 0.1):
                       control.flat?
                           AkTheme.shade(AkTheme.palette.active.mid, 0, 0.5):
                           AkTheme.palette.active.mid
            }
        },
        State {
            name: "Focused"
            when: control.enabled
                  && (control.activeFocus || control.visualFocus)
                  && !control.pressed

            PropertyChanges {
                target: buttonRectangle
                border.width:
                    AkUnit.create(2 * AkTheme.controlScale, "dp").pixels
                border.color:
                    control.highlighted || control.flat?
                        AkTheme.shade(AkTheme.palette.active.window, 0, 0):
                        AkTheme.palette.active.highlight
                color: control.highlighted?
                           AkTheme.constShade(AkTheme.palette.active.highlight, 0.2):
                       control.flat?
                           AkTheme.shade(AkTheme.palette.active.mid, 0, 0.5):
                           AkTheme.palette.active.mid
            }
        },
        State {
            name: "Pressed"
            when: control.enabled
                  && control.pressed

            PropertyChanges {
                target: buttonRectangle
                border.width:
                    AkUnit.create(2 * AkTheme.controlScale, "dp").pixels
                border.color:
                    control.highlighted || control.flat?
                        AkTheme.shade(AkTheme.palette.active.window, 0, 0):
                        AkTheme.palette.active.highlight
                color: control.highlighted?
                           AkTheme.constShade(AkTheme.palette.active.highlight, 0.3):
                       control.flat?
                           AkTheme.shade(AkTheme.palette.active.dark, 0, 0.5):
                           AkTheme.palette.active.dark
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            target: buttonRectangle
            properties: "color,border.color,border.width"
            duration: control.animationTime
        }
    }
}
