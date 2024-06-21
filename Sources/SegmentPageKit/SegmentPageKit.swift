import UIKit

class SPViewController: UIViewController {
    
    let segmentor: SPSegment
    private let viewControllers: [UIViewController]
    private var pageViewController: UIPageViewController!
    
    init(titles: [String], viewControllers: [UIViewController]) {
        self.segmentor = SPSegment(frame: .zero, titles: titles)
        self.viewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentor()
        setupPageViewController()
        setInitialPageViewController()
    }
    
    private func setupSegmentor() {
        view.addSubview(segmentor)
        segmentor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentor.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentor.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentor.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentor.heightAnchor.constraint(equalToConstant: 50) // Adjust as needed
        ])
        segmentor.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.backgroundColor = .clear
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: segmentor.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        pageViewController.didMove(toParent: self)
    }
    
    private func setInitialPageViewController() {
        let selectedIndex = segmentor.selectedSegmentIndex
        if selectedIndex < viewControllers.count, selectedIndex >= 0 {
            let initialVC = viewControllers[selectedIndex]
            pageViewController.setViewControllers([initialVC], direction: .forward, animated: false, completion: nil)
        }
    }
    
    @objc private func segmentChanged(_ sender: SPSegment) {
        let index = sender.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = (segmentor.currentSegmentIndex ?? 0) < index ? .forward : .reverse
        if index < viewControllers.count {
            pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true) { [weak self] _ in
                self?.segmentor.currentSegmentIndex = index
            }
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension SPViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return viewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController), currentIndex < (viewControllers.count - 1) else {
            return nil
        }
        return viewControllers[currentIndex + 1]
    }
}

// MARK: - UIPageViewControllerDelegate
extension SPViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = viewControllers.firstIndex(of: visibleViewController) {
            segmentor.selectedSegmentIndex = index
        }
    }
}
