import AudioKit
import Foundation
import AudioKitEX

struct RecorderData {
    var isRecording = false
    var isPlaying = false
}


@objcMembers
public class RecorderConductor: NSObject, ObservableObject {
    let engine = AudioEngine()
    var recorder: NodeRecorder?
    let player = AudioPlayer()
    var silencer: Fader?
    let mixer = Mixer()

    
    @Published var data = RecorderData() {
        didSet {
            if data.isRecording {
                do {
                    try recorder?.record()
                } catch let err {
                    print(err)
                }
            } else {
                recorder?.stop()
            }

            if data.isPlaying {
                if let file = recorder?.audioFile {
                    player.file = file
                    player.play()
                }
            } else {
                player.stop()
            }
        }
    }

    @objc public func record() {
        data.isRecording = true;
        data.isPlaying = false;
    }
    
    @objc public func playAudio() {
        data.isRecording = false;
        data.isPlaying = true;
    }
    
    @objc public func stopEverything() {
        data.isRecording = false;
        data.isPlaying = false;
    }
    
    @objc public func startEngine() {
        if !engine.avEngine.isRunning {
            do {
                try engine.start()
            } catch let error {
                print("Failed to start the audio engine: \(error)")
                return
            }
        }
    }


    // ... Other methods ...

    override init() {
        super.init()

        guard let input = engine.input else {
            fatalError()
        }

        do {
            recorder = try NodeRecorder(node: input)
        } catch let err {
            fatalError("\(err)")
        }
        let silencer = Fader(input, gain: 0)
        self.silencer = silencer
        mixer.addInput(silencer)
        mixer.addInput(player)
        engine.output = mixer
    }
}
