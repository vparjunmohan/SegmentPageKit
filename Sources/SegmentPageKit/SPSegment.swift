//
//  SPSegment.swift
//
//
//  Created by Arjun Mohan on 22/06/24.
//

import UIKit

public class SPSegment: UIControl {
    
    private let scrollView = UIScrollView()
    private let indicatorView: SPIndicatorView
    private var buttons = [SPButton]()
    private var titles: [String]
    private let stackView = UIStackView()
    
    private var _segmentColorNormal: UIColor = .clear
    private var _segmentColorSelected: UIColor = .clear
    private var _titleColorNormal: UIColor = .systemGray
    private var _titleColorSelected: UIColor = .systemBlue
    private var _indicatorColor: UIColor = .clear
    private var _segmentSpacing: CGFloat = CGFloat.zero
    
    public var segmentColorNormal: UIColor {
        get { _segmentColorNormal }
        set {
            _segmentColorNormal = newValue
            updateButtonAppearance()
        }
    }
    
    public var segmentColorSelected: UIColor {
        get { _segmentColorSelected }
        set {
            _segmentColorSelected = newValue
            updateButtonAppearance()
        }
    }
    
    public var titleColorNormal: UIColor {
        get { _titleColorNormal }
        set {
            _titleColorNormal = newValue
            updateButtonAppearance()
        }
    }
    
    public var titleColorSelected: UIColor {
        get { _titleColorSelected }
        set {
            _titleColorSelected = newValue
            updateButtonAppearance()
        }
    }
    
    public var indicatorColor: UIColor {
        get { _indicatorColor }
        set {
            _indicatorColor = newValue
            updateIndicatorAppearance()
        }
    }
    
    public var segmentSpacing: CGFloat {
        get { _segmentSpacing }
        set {
            _segmentSpacing = newValue
            updateSegmentStackAppearance()
        }
    }
    
    public var selectedSegmentIndex = 0 {
        didSet {
            updateIndicatorPosition()
            updateButtonStates()
            scrollToButton(at: selectedSegmentIndex)
            updateButtonAppearance()
        }
    }
    
    var currentSegmentIndex: Int?
    
    init(frame: CGRect, titles: [String], indicatorColor: UIColor = .clear, selectedSegmentIndex: Int = 0, segmentColorNormal: UIColor = .clear, segmentColorSelected: UIColor = .clear, titleColorNormal: UIColor = .systemGray, titleColorSelected: UIColor = .systemBlue, segmentSpacing: CGFloat = .zero) {
        self.titles = titles
        self.indicatorView = SPIndicatorView(indicatorColor: indicatorColor)
        super.init(frame: frame)
        self.selectedSegmentIndex = selectedSegmentIndex
        self.currentSegmentIndex = selectedSegmentIndex
        self.segmentColorNormal = segmentColorNormal
        self.segmentColorSelected = segmentColorSelected
        self.titleColorNormal = titleColorNormal
        self.titleColorSelected = titleColorSelected
        self.segmentSpacing = segmentSpacing
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        layoutButtons()
        updateIndicatorPosition(isInitialLayout: true)
        updateButtonStates()
        updateButtonAppearance()
    }
    
    private func setupView() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        
        stackView.axis = .horizontal
        stackView.spacing = _segmentSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        scrollView.addSubview(stackView)
        
        titles.enumerated().forEach { index, title in
            let button = SPButton(title: title, index: index)
            button.addTarget(self, action: #selector(segmentButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        scrollView.addSubview(indicatorView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor)
        ])
    }
    
    private func layoutButtons() {
        var totalWidth: CGFloat = 0
        let buttonPadding: CGFloat = 20
        let buttonHeight = scrollView.frame.height
        
        for button in buttons {
            let buttonWidth = button.intrinsicContentSize.width + buttonPadding
            button.frame = CGRect(x: totalWidth, y: 0, width: buttonWidth, height: buttonHeight)
            totalWidth += buttonWidth
        }
        
        scrollView.contentSize = CGSize(width: max(totalWidth, scrollView.frame.width), height: scrollView.frame.height)
        layoutIfNeeded()
    }
    
    private func updateIndicatorPosition(isInitialLayout: Bool = false) {
        guard !buttons.isEmpty, selectedSegmentIndex >= 0, selectedSegmentIndex < buttons.count else { return }
        let selectedButton = buttons[selectedSegmentIndex]
        let indicatorFrame = CGRect(x: selectedButton.frame.origin.x,
                                    y: scrollView.frame.height - 2,
                                    width: selectedButton.frame.width,
                                    height: 2)
        
        let animations = {
            self.indicatorView.frame = indicatorFrame
        }
        isInitialLayout ? animations() :  UIView.animate(withDuration: 0.3, animations: animations)
    }
    
    private func updateButtonStates() {
        buttons.enumerated().forEach { index, button in
            button.isSelected = index == selectedSegmentIndex
            button.setTitleColor(button.isSelected ? _titleColorSelected : _titleColorNormal, for: .normal)
        }
    }
    
    private func updateButtonAppearance() {
        buttons.enumerated().forEach { index, button in
            button.backgroundColor = index == selectedSegmentIndex ? _segmentColorSelected : _segmentColorNormal
        }
    }
    
    private func updateIndicatorAppearance() {
        indicatorView.backgroundColor = _indicatorColor
    }
    
    private func updateSegmentStackAppearance() {
        stackView.spacing = _segmentSpacing
    }
    
    @objc private func segmentButtonTapped(_ sender: SPButton) {
        let index = sender.tag
        selectedSegmentIndex = index
        sendActions(for: .valueChanged)
    }
    
    private func scrollToButton(at index: Int) {
        guard index >= 0, index < buttons.count else { return }
        let button = buttons[index]
        scrollView.scrollRectToVisible(button.frame, animated: true)
    }
}
