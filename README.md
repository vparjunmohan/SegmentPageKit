# SegmentPageKit
SegmentPageKit is a powerful and flexible UI component for iOS applications, combining a segmented control with a page view controller. It allows developers to create a seamless and interactive tabbed interface with ease.

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

## Customization

SegmentPageKit allows for extensive customization of the segmented control appearance and behavior:

### Segmentor Properties

- segmentColorNormal: The background color of the unselected segments.
- segmentColorSelected: The background color of the selected segment.
- titleColorNormal: The color of the unselected segment titles.
- titleColorSelected: The color of the selected segment title.
- indicatorColor: The color of the indicator.

Example:

```
segmentedVC.segmentor.segmentColorNormal = .lightGray // default: UIColor.clear
segmentedVC.segmentor.segmentColorSelected = .blue // default: UIColor.clear
segmentedVC.segmentor.titleColorNormal = .black
segmentedVC.segmentor.titleColorSelected = .blue
segmentedVC.segmentor.indicatorColor = .red
segmentedVC.segmentor.segmentSpacing = 10 // default: CGFloat.zero
```

## Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.


## License

SegmentPageKit is available under the MIT license.
