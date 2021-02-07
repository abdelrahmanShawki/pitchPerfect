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
    override func viewDidLoad() {
        super.viewDidLoad()
        stopOutlet.isEnabled = false
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
        
    
    @IBAction func recordAudio(_ sender: Any) {
        stopOutlet.isEnabled = true
        recordAudioOutlet.isEnabled = false
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
        recordAudioOutlet.isEnabled = true
        stopOutlet.isEnabled = false
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
        if segue.identifier == "stop record"{
            let playSoundVC = segue.destination as! playSoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

