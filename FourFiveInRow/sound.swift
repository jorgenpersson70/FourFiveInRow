//
//  File.swift
//  FourFiveInRow
//
//  Created by jörgen persson on 2021-12-10.
//

import Foundation
import AVFoundation
var audioPlayer: AVAudioPlayer?

func playSound(fileName : String) {
    guard let path = Bundle.main.path(forResource: fileName, ofType:"mp3") else {
        return }
    let url = URL(fileURLWithPath: path)

    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}
