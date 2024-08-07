# SegmentPageKit
SegmentPageKit is a powerful and flexible UI component for iOS applications, combining a segmented control with a page view controller. It allows developers to create a seamless and interactive tabbed interface with ease.

## Demo
https://github.com/vparjunmohan/SegmentPageKit/assets/62532677/57ec5fa7-6408-456b-a7cc-8ee33ae3b4b5

## Features
- Customizable segmented control with adjustable colors and titles
- Smooth integration with `UIPageViewController` for easy page transitions
- Automatic updating of segment and page view on selection
- Highly configurable and easy to use

## Installation

### Swift Package Manager

To integrate SegmentPageKit into your project using Swift Package Manager:

- File > Swift Packages > Add Package Dependency
- Add https://github.com/vparjunmohan/SegmentPageKit.git

## Usage

Here is a basic example of how to set up SegmentPageKit in your view controller:

```
import UIKit
import SegmentPageKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let titles = ["Home", "Profile", "Settings"]
        let homeVC = HomeViewController()
        let profileVC = ProfileViewController()
        let settingsVC = SettingnsViewController()
        

        let segmentedVC = SPViewController(titles: titles, viewControllers: [homeVC, profileVC, settingsVC])

        addChild(segmentedVC)
        view.addSubview(segmentedVC.view)
        segmentedVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            segmentedVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        segmentedVC.didMove(toParent: self)
    }
}
```

If segmented controllers are not required and if you want to use only the segmented tabs, the following initializer can be used:
```
import UIKit
import SegmentPageKit

class ViewController: UIViewController {
    
    private let segmentControl: SPSegment = {
        let titles = ["Action", "Drama", "Horror", "Romance", "Sci-fi", "Thriller", "Fantasy", "Crime", "Anime"]
        let control = SPSegment(frame: .zero, titles: titles)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(segmentControl)
        segmentControl.delegate = self
        
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - SPSEGMENT DELEGATE
extension ViewController: SPSegmentDelegate {
    func didTapSegment(index: Int) {
        print("segment index \(index)")
    }
}
```

## Customization

SegmentPageKit allows for extensive customization of the segmented control appearance and behavior:

### Segmentor Properties

- segmentColorNormal: The background color of the unselected segments.
- segmentColorSelected: The background color of the selected segment.
- titleColorNormal: The color of the unselected segment titles.
- titleColorSelected: The color of the selected segment title.
- indicatorColor: The color of the indicator.
- indicatorHeight: The height of the indicator.
- shouldHideIndicator: Hide/show the segment indicator.
- segmentSpacing: The spacing between each segment.
- selectedSegmentIndex: The index of segment which is selected by default.
- segmentFont: The font of segment titles.

Example:

```
segmentedVC.segmentor.segmentColorNormal = .lightGray // default: UIColor.clear
segmentedVC.segmentor.segmentColorSelected = .blue // default: UIColor.clear
segmentedVC.segmentor.titleColorNormal = .black // default: UIColor.systemGray
segmentedVC.segmentor.titleColorSelected = .blue // default: UIColor.systemBlue
segmentedVC.segmentor.indicatorColor = .red // default: UIColor.clear
segmentedVC.segmentor.indicatorHeight = 5.0 // default: 2.0
segmentedVC.segmentor.shouldHideIndicator = true // default: false
segmentedVC.segmentor.segmentSpacing = 10 // default: CGFloat.zero
segmentedVC.segmentor.selectedSegmentIndex = 0 // default: 0
segmentedVC.segmentor.segmentFont = UIFont(name: "Poppins-Bold", size: 14) // default: UIFont.systemFont(ofSize: 14)
```

## Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

As a rule of thumb, if you're proposing an API-breaking change or a change to existing functionality, consider proposing it by opening an issue, rather than a pull request; we'll use the issue as a public forum for discussing whether the proposal makes sense or not. See [CONTRIBUTING](https://github.com/vparjunmohan/SegmentPageKit/blob/70ff87b9d0a5f314108838f06df6f089b0a5ce26/CONTRIBUTING.md) for more details.


## License

SegmentPageKit is available under the MIT license. See [LICENSE](https://github.com/vparjunmohan/SegmentPageKit/blob/d024dbcf79976d87295b4c9004816dd2adea6ccb/LICENSE) for details.
