//
//  RequestHistoryDetailViewController.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/30/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation
import UIKit

protocol RequestHistoryDetailViewMvc: class {
    func populateUI(request: JobRequestHistory)
    func showAlertDialog(title: String, message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func onAcceptSuccessful()
    func openCallDialog(url: URL)
    
    func showLoadingIndicatorOnCallButton()
    func hideLoadingIndicatorOnCallButton()
}

class RequestHistoryDetailViewController: BaseViewController, Storyboarded {
    
    var interactor: RequestHistoryDetailInteractor?
    var user: User?
    var request: JobRequestHistory?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var offeringLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var requestIdLabel: UILabel!
    @IBOutlet weak var finalIdLabel: UILabel!
    @IBOutlet weak var pickupAddressLabel: UILabel!
    @IBOutlet weak var dropOffAddress: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var loadWeightLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var callButton: ProdriveButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
        configureInteractor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.onStart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor?.onStop()
    }
    
    // MARK: - Configuration

    
    func configureInteractor() {
        guard let request = request else { fatalError("request cant be nil")}
        interactor?.bindRequest(request: request)
    }
    
    // MARK: - IBActions
    
    @IBAction func onCalledButtonTapped(_ sender: Any) {
        interactor?.handleCallButtonTapped()
    }
}


    // MARK: - Presenter callbacks

extension RequestHistoryDetailViewController: RequestHistoryDetailViewMvc {
    
    func populateUI(request: JobRequestHistory) {
        titleLabel.text = request.title
        offeringLabel.text = StringFormatter.convertStringToCurrency(string: request.offering)
        emailLabel.text = request.businessEmail
        requestIdLabel.text = "\(request.request_id)"
        finalIdLabel.text = request.final_id
        pickupAddressLabel.text = request.pickupAddresss
        pickupAddressLabel.text = request.dropoffAddress
        datePostedLabel.text = request.timeStamp
        deliveryDateLabel.text = request.mandatoryDate
        descriptionLabel.text = request.details
        loadWeightLabel.text = request.loadWeight + " Lbs"
    }
    
    func showAlertDialog(title: String, message: String) {
        
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func onAcceptSuccessful() {
        
    }
    
    func openCallDialog(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func showLoadingIndicatorOnCallButton() {
        callButton.showLoading()
    }
    
    func hideLoadingIndicatorOnCallButton() {
        callButton.hideLoading()
    }
    
}
