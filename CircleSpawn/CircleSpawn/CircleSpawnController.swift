import UIKit

class CircleSpawnController: UIViewController, UIGestureRecognizerDelegate {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}
    
    private var circles: [CircleView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }

    @objc func handleDoubleTap(_ tap: UITapGestureRecognizer) {
        let circle = CircleView(backgroundColor: UIColor.randomBrightColor(), center: tap.location(in: view))
        view.addSubview(circle)
        circles.append(circle)
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap(_:)))
        tripleTap.numberOfTapsRequired = 3
        circle.addGestureRecognizer(tripleTap)
        
        circle.easeIn()
    }

    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        let circle = view as! CircleView
        circle.easeOut() { [weak self] completed in
            if let index = self?.circles.firstIndex(of: circle) {
                self?.circles.remove(at: index)
            }
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        for circle in circles {
            circle.easeOut() { [weak self] completed in
                if let index = self?.circles.firstIndex(of: circle) {
                    self?.circles.remove(at: index)
                }
            }
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
