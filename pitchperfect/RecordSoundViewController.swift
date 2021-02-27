//
//  RecordSoundViewController.swift
//  pitchperfect
//
//  Created by shawki on 28/01/2021.
//

import UIKit
import AVFoundation
class RecordSoundViewController: UIViewController , AVAudioRecorderDelegate {
    var audioRecorder : AVAudioRecorder!
    @IBOutlet weak var recordAudioOutlet: UIButton!
    @IBOutlet weak var stopOutlet: UIButton!
    @IBOutlet weak var recordingStatue: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        isRecordNow(state: false)
    }
    
  
    enum recordingStatueLabel : String {
        case recording = "recording ..."
        case notRecording =  "tap to record"
    }
    
    func isRecordNow(state : Bool) {
        
        stopOutlet.isEnabled = state
        recordAudioOutlet.isEnabled = !state
        switch state {
            case true:
                recordingStatue.text = recordingStatueLabel.recording.rawValue
            default:
            recordingStatue.text = recordingStatueLabel.notRecording.rawValue
        }
     
    }
    
    
    @IBAction func recordAudio(_ sender: Any) {
        isRecordNow(state: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = URL(string: pathArray.joined(separator: "/"))

            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

            try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
    }
   
    
    @IBAction func stopRecord(_ sender: Any) {
       isRecordNow(state: false)
        audioRecorder.stop()
           let audioSession = AVAudioSession.sharedInstance()
           try! audioSession.setActive(false)
    }
    
     func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder,
                                                  successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecord" , sender : audioRecorder.url)
        }
        else{
            print("record wasnt succcfull")
        }
    }
    
    override func prepare(for segue : UIStoryboardSegue , sender: Any?){
        if segue.identifier == "stopRecord"{
            let playSoundVC = segue.destination as! playSoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
       
    }
    
}

