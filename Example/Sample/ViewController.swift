import UIKit
import MovikaSDK

class ViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!{
    didSet {
      activityIndicator.isHidden = false
      activityIndicator.startAnimating()
    }
  }
  
  @IBOutlet weak var stackView: UIStackView!{
    didSet {
      stackView.isHidden = true
    }
  }
  
  @IBOutlet weak var resumeBtn: UIButton!{
    didSet {
      resumeBtn.isHidden = true
    }
  }
  
  private var manifest: MKManifest? = nil
  private let testManifestURL = URL(string: "https://asazin-cache.cdnvideo.ru/asazin/test/manifest3pro/manifest-v3.json")!
  private let manifestAsset = MKManifestAsset()

  override func viewDidLoad() {
    super.viewDidLoad()
    manifestAsset.loader.load(requestURL: testManifestURL, manifestVersion: "3.0.0") { [weak self] manifest, error in
      guard let self = self else { return }
      self.activityIndicator.isHidden = true
      self.stackView.isHidden = false
      if let error = error {
        self.show(message: error.localizedDescription)
      } else {
        self.manifest = manifest
      }
    }
  }
  
  private func showPlayer(starFormGamePoint: Bool) {
    guard let manifest = manifest else {
      show(message: "Manifest not initialized")
      return
    }

    let vc = PlayerViewController()
    vc.modalPresentationStyle = .fullScreen
    self.show(vc, sender: nil)
    vc.isShowDebugView = true
    vc.setManifestAsset(MKReadyManifestAsset(manifest: manifest))
    vc.mkplayer.play()
  }
  
  @IBAction func start(_ sender: Any) {
    showPlayer(starFormGamePoint: false)
  }
  
  @IBAction func resume(_ sender: Any) {
    showPlayer(starFormGamePoint: true)
  }
  
  private func show(message: String)  {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
