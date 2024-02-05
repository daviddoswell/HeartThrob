//
//  AudioPlayer.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import Foundation
import AVFoundation

// MARK: - PROPERTIES

var audioPlayer: AVAudioPlayer?

// MARK: - FUNCTIONS

func playSound(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print("Could not play the sound file")
    }
  }
}
