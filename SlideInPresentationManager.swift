//
/**
 * @file      SlideInPresentationManager.swift
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

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

final class SlideInPresentationManager: NSObject {
    
    // MARK: - Properties
    var direction = PresentationDirection.bottom
    var disableCompactHeight = true
    var isInviteScreen = false // bool value for request invitation screen
}

// MARK: - UIViewControllerTransitioningDelegate
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if isInviteScreen {
             let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction, isInviteScreen: true)
            presentationController.delegate = self
            return presentationController
        } else {
             let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
            presentationController.delegate = self
            return presentationController
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: false)
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension SlideInPresentationManager: UIAdaptivePresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
            return .overFullScreen
        } else {
            return .none
        }
    }
}
