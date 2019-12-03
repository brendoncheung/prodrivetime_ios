//
//  RequestDetailInteractor.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/23/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol RequestDetailInteractor: BaseInteractor {
    func handleAcceptButtonTapped()
    func handleCallButtonTapped()
    // should be abstracted out of this protocol into requirement
    func bindUserProfile(user: User?)
    func bindRequest(request: JobRequest?)
}

class RequestDetailInteractorImpl: RequestDetailInteractor {
    
    private let acceptRequestUseCase: AcceptJobRequestUseCase
    private let factory: URLRequestFactory
    private let presenter: RequestDetailPresenter
    
    private var user: User?
    private var request: JobRequest?
    
    init(acceptRequestUseCase: AcceptJobRequestUseCase,
         factory: URLRequestFactory,
         presenter: RequestDetailPresenter) {
        self.acceptRequestUseCase = acceptRequestUseCase
        self.factory = factory
        self.presenter = presenter
    }
    
    func onStart() {
        acceptRequestUseCase.registerObserver(observer: self)
        presenter.showRequestDetails(request: request)
    }
    
    func onStop() {
        acceptRequestUseCase.unregisterObserver()
    }
    
    func bindUserProfile(user: User?) {
        self.user = user
    }
    
    func bindRequest(request: JobRequest?) {
        self.request = request
    }
    

    func handleAcceptButtonTapped() {
        acceptJob()
    }
    
    func handleCallButtonTapped() {
        log.debug("handleCallButtonTapped clicked")
    }
    
    private func acceptJob() {
        guard let requestId = request?.requestID, let driverEmail = user?.email, let driverId = user?.driverId else { return }
        guard let request = factory.createAcceptJobRequestURLRequest(requestId: requestId, driverEmail: driverEmail, driverId: driverId) else {fatalError("request can't be nil")}
        acceptRequestUseCase.acceptJobRequest(with: request)
    }
}

extension RequestDetailInteractorImpl: AcceptJobRequestUseCaseDelegate {
    
    func onRequestingAcceptJob() {
        log.debug("onRequestingAcceptJob")
        presenter.onAcceptRequestProcessing()
    }
    
    func onRequestAcceptJobSuccessful() {
        log.debug("onRequestAcceptJobSuccessful")
        presenter.acceptJobRequestSuccessful()
    }
    
    func onRequestAcceptJobFailed(error: AcceptJobRequestUseCaseError) {
        log.debug("onRequestAcceptJobFailed")
    }
}