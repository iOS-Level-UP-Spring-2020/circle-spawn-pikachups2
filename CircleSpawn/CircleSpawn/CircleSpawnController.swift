import UIKit

class CircleSpawnController: UIViewController {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}
    private var circles: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap(_:)))
        tripleTap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripleTap)
    }

    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        let size: CGFloat = 100
        let spawnedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        spawnedView.center = tap.location(in: view)
        spawnedView.backgroundColor = UIColor.randomBrightColor()
        spawnedView.layer.cornerRadius = size * 0.5
        view.addSubview(spawnedView)
        circles.append(spawnedView)
        
        spawnedView.alpha = 0
        spawnedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, animations: {
            spawnedView.alpha = 1
            spawnedView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { completed in
            UIView.animate(withDuration: 0.1, animations: {
                spawnedView.transform = .identity
            })
        })
    }
}
