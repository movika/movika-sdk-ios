//
//  PlayerController.swift
//  Sample
//
//  Created by Ishmukhametov on 15.12.2020.
//

import MovikaSDK

class PlayerViewController: MovikaPlayerViewController {
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  override func movikaPlayerViewController(_ controller: MovikaPlayerViewController,
                                           didClose result: InteractionHistory?) {
    self.dismiss(animated: true, completion:nil)
  }
  
  override func mkplayer(_ player: MKPlayer, didEndPlaying manifest: MKManifest) {
    self.dismiss(animated: true, completion:nil)
  }
  
}



