//
//  BaseInteractor.swift
//  Prodrivetime_ios
//
//  Created by Wing Sun Cheung on 11/18/19.
//  Copyright © 2019 Wing Sun Cheung. All rights reserved.
//

import Foundation

protocol BaseInteractor {
    
    // onStart and onStop manages the listeners
    
    func onStart()
    func onStop()
}
