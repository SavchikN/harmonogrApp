//
//  OnboardingViewController.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 01/06/2023.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .blue
        return pageControl
    }()
    
    private var slides = [OnboardingView]()
    
    var slideData = OnboardingSlide()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        setupViews()
        setDelegates()
        setConstraints()
        
        slides = createSlides()
        setupSlidesScrollView(slides: slides)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(pageControl)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    private func createSlides() -> [OnboardingView] {
        let firstOnboardingView = OnboardingView()
        firstOnboardingView.setPageLabelText(text: slideData.firstSlideText)
        firstOnboardingView.setPageImage(image: slideData.firstSlideImage!)
        firstOnboardingView.setPageDescriptionLabelText(text: slideData.firstDescriptionText)
        
        let secondOnboardingView = OnboardingView()
        secondOnboardingView.setPageLabelText(text: slideData.secondSlideText)
        secondOnboardingView.setPageImage(image: slideData.secondSlideImage!)
        secondOnboardingView.setPageDescriptionLabelText(text: slideData.secondDescriptionText)
        
        let thirdOnboardingView = OnboardingView()
        thirdOnboardingView.setPageLabelText(text: slideData.thirdSlideText)
        thirdOnboardingView.setPageImage(image: slideData.thirdSlideImage!)
        thirdOnboardingView.setPageDescriptionLabelText(text: slideData.thirdDescriptionText)
        thirdOnboardingView.activateButton(active: false)
        
        return [firstOnboardingView, secondOnboardingView, thirdOnboardingView]
    }
    
    private func setupSlidesScrollView(slides: [OnboardingView]) {
        scrollView.contentSize = CGSize(
            width: view.frame.width * CGFloat(slides.count),
            height: view.frame.height / 2
        )
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(
                x: view.frame.width * CGFloat(i),
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
            scrollView.addSubview(slides[i])
        }
    }
}

extension OnboardingViewController {
    @objc func nextButtonTapped() {
        let tabBarController = TabBarController()
        navigationController?.pushViewController(tabBarController, animated: true)
        print("tapp")
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maxHorizontalOffset = scrollView.contentSize.width - view.frame.width
        let percentHorizontalOffset = scrollView.contentOffset.x / maxHorizontalOffset
        
        if percentHorizontalOffset <= 0.5 {
            let firstTransform = CGAffineTransform(
                scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                y: (0.5 - percentHorizontalOffset) / 0.5
            )
            
            let secondTransfrom = CGAffineTransform(
                scaleX: percentHorizontalOffset / 0.5,
                y: percentHorizontalOffset / 0.5
            )
            
            slides[0].setPageLabelTransform(transform: firstTransform)
            slides[0].setPageDescriptionTransform(transform: firstTransform)
            slides[1].setPageLabelTransform(transform: secondTransfrom)
            slides[1].setPageDescriptionTransform(transform: secondTransfrom)
        } else {
            let secondTransform = CGAffineTransform(
                scaleX: (1 - percentHorizontalOffset) / 0.5,
                y: (1 - percentHorizontalOffset) / 0.5
            )
            
            let thirdTransform = CGAffineTransform(
                scaleX: percentHorizontalOffset,
                y: percentHorizontalOffset
            )
            
            slides[1].setPageLabelTransform(transform: secondTransform)
            slides[2].setPageLabelTransform(transform: thirdTransform)
            slides[1].setPageDescriptionTransform(transform: secondTransform)
            slides[2].setPageDescriptionTransform(transform: thirdTransform)
        }
    }
}

extension OnboardingViewController {
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(15)
            make.leading.equalTo(view.snp.leading).inset(30)
            make.trailing.equalTo(view.snp.trailing).inset(30)
            make.height.equalTo(50)
        }
    }
}
