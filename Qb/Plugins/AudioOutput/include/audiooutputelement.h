/* Webcamod, webcam capture plasmoid.
 * Copyright (C) 2011-2013  Gonzalo Exequiel Pedone
 *
 * Webcamod is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamod is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamod. If not, see <http://www.gnu.org/licenses/>.
 *
 * Email     : hipersayan DOT x AT gmail DOT com
 * Web-Site 1: http://github.com/hipersayanX/Webcamoid
 * Web-Site 2: http://kde-apps.org/content/show.php/Webcamoid?content=144796
 */

#ifndef AUDIOOUTPUTELEMENT_H
#define AUDIOOUTPUTELEMENT_H

#include <QtMultimedia>
#include <qb.h>

extern "C"
{
    #include <libavformat/avformat.h>
    #include <libswresample/swresample.h>
}

class AudioOutputElement: public QbElement
{
    Q_OBJECT
    Q_PROPERTY(QString audioSystem READ audioSystem
                                   WRITE setAudioSystem
                                   RESET resetAudioSystem)

    Q_PROPERTY(QStringList availableAudioSystem READ availableAudioSystem)
    Q_PROPERTY(QString dataMode READ dataMode WRITE setDataMode RESET resetDataMode)

    public:
        explicit AudioOutputElement();

        Q_INVOKABLE QString audioSystem() const;
        Q_INVOKABLE QStringList availableAudioSystem() const;
        Q_INVOKABLE QString dataMode() const;

    private:
        QString m_audioSystem;
        QString m_dataMode;

        QbElementPtr m_audioConvert;
        QbElementPtr m_outputSink;
        QAudioDeviceInfo m_qtOutputInfo;
        QAudioOutput *m_audioOutput;
        QBuffer m_outputBuffer;
        QIODevice *m_outputBufferPtr;

        QbCaps findBestOptions(const QbCaps &caps,
                               const QAudioDeviceInfo &deviceInfo,
                               QAudioFormat *bestOption=NULL) const;

    public slots:
        void setAudioSystem(const QString &audioSystem);
        void setDataMode(const QString &dataMode);
        void resetAudioSystem();
        void resetDataMode();
        void processFrame(const QbPacket &packet);

        void iStream(const QbPacket &packet);
        void setState(QbElement::ElementState state);
};

#endif // AUDIOOUTPUTELEMENT_H
