//
/**
 * @file      SlideInPresentationController.swift
 * @brief
 * @details
 * @see
 * @author    Shrinivas Uttamrao Gutte, shrinivasgutte@elear.solutions
 * @copyright Copyright (c) 2019 Elear Solutions Tech Private Limited.
 *            All rights reserved.
 * @license   To any person (the "Recipient") obtaining a copy of this software
 *            and associated documentation files (the "Software"):
 *            All information contained in or disclosed by this software is
 *            confidential and proprietary information of Elear Solutions Tech
 *            Private Limited and all rights therein are expressly reserved.
 *            By accepting this material the recipient agrees that this material
 *            and the information contained therein is held in confidence and
 *            in trust and will NOT be used, copied, modified, merged,
 *            published, distributed, sublicensed, reproduced in whole or
 *            in part, nor its contents revealed in any manner to others
 *            without the express written permission of Elear Solutions Tech
 *            Private Limited.
 */

import UIKit

final class SlideInPresentationController: UIPresentationController {
    
    // MARK: - Properties
    fileprivate var dimmingView: UIView!
    private var direction: PresentationDirection
    private var isInviteScreen = false
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width*(1.0/3.0)
        case .bottom:
            switch isInviteScreen {
            case true:
                let screenHeight = UIScreen.main.bounds.height
                switch screenHeight {
                case 568: // iPhone 5s/Se screen
                    frame.origin.y = containerView!.frame.height*(1.0/3.7)
                case 812: // iPhone Xs/X screen
                    frame.origin.y = containerView!.frame.height*(1.0/4.9)
                case 896: // iPhone Xr
                    frame.origin.y = containerView!.frame.height*(1.0/3.6)
                case 736: // iPhone 8plus
                    frame.origin.y = containerView!.frame.height*(1.0/4.4)
                default:
                    frame.origin.y = containerView!.frame.height*(1.0/3.0)
                }
            default:
                frame.origin.y = containerView!.frame.height*(1.0/3.0)
            }
        default:
            frame.origin = .zero
        }
        return frame
    }
    
    // MARK: - Initializers
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection, isInviteScreen: Bool? = false) {
        self.direction = direction
        self.isInviteScreen = isInviteScreen ?? false
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
        case .bottom, .top:
            switch isInviteScreen {
            case true:
                let screenHeight = UIScreen.main.bounds.height
                switch screenHeight {
                case 568: // iPhone 5s/Se screen
                    return CGSize(width: parentSize.width, height: parentSize.height*(1))
                case 812: // iPhone Xs/X screen
                    return CGSize(width: parentSize.width, height: parentSize.height*(0.85))
                case 896: // iPhone Xr
                    return CGSize(width: parentSize.width, height: parentSize.height*(1))
                case 736: // iPhone 8+
                    return CGSize(width: parentSize.width, height: parentSize.height*(0.8))
                default:
                    return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
                }
            default:
                return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
            }
        }
    }
}

// MARK: - Private
private extension SlideInPresentationController {
    
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        //        presentingViewController.dismiss(animated: true)
        NotificationCenter.default.post(name: Notification.Name("postNotifi"), object: self)
    }
}
