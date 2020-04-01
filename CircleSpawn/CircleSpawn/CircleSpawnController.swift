import UIKit

class CircleSpawnController: UIViewController {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}
    
    private var circles: [UICircleView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap(_:)))
        tripleTap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripleTap)
    }

    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        let spawnedView = UICircleView(backgroundColor: UIColor.randomBrightColor(), center: tap.location(in: view))
        view.addSubview(spawnedView)
        circles.append(spawnedView)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        spawnedView.addGestureRecognizer(doubleTap)
        
        spawnedView.easeIn()
    }

    @objc func handleDoubleTap(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        let circle = view as! UICircleView
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
}
