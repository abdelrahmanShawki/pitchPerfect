//
//  ViewController.swift
//  pitchperfect
//
//  Created by shawki on 28/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    
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
        recordLabel.text = "reacrding in progress"
    }
    
    @IBAction func stopRecord(_ sender: Any) {
        recordAudioOutlet.isEnabled = true
        stopOutlet.isEnabled = false
        recordLabel.text = "tab to record"
    }
}

