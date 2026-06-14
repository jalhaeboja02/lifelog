import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.97, green: 0.95, blue: 1.0, alpha: 1.0)
        
        titleLabel.text = "오늘의 나를\n기록할 준비가 되었어요 📸"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = UIColor.systemPurple
        
        recordButton.setTitle("📷  지금 기록하기", for: .normal)
        recordButton.backgroundColor = .systemPurple
        recordButton.setTitleColor(.white, for: .normal)
        recordButton.layer.cornerRadius = 16
        recordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        // 벨 이모지 라벨 추가
        let bellLabel = UILabel()
        bellLabel.text = "🔔"
        bellLabel.font = UIFont.systemFont(ofSize: 60)
        bellLabel.textAlignment = .center
        bellLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bellLabel)
        
        // 부제목 라벨 추가
        let subLabel = UILabel()
        subLabel.text = "하루에 한 번, 랜덤한 순간을 기록합니다"
        subLabel.font = UIFont.systemFont(ofSize: 14)
        subLabel.textColor = .gray
        subLabel.textAlignment = .center
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            bellLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bellLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            LogStore.shared.add(image: image)
        }
        dismiss(animated: true) {
            self.showCompleteAlert()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func showCompleteAlert() {
        let alert = UIAlertController(title: "기록 완료! ✅",
                                      message: "오늘의 순간이 저장되었습니다.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
