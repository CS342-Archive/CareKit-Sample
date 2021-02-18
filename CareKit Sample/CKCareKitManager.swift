//
//  CKCareKitManager.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 12/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CareKit
import CareKitStore
import ResearchKit // TODO remove


class CKCareKitManager: NSObject {
    
    let coreDataStoreType: OCKCoreDataStoreType = .inMemory
    let prefCareKitCoreDataInitDate = "PREF_CORE_DATA_INIT_DATE"
    
    var coreDataStore: OCKStore!
    private(set) var synchronizedStoreManager: OCKSynchronizedStoreManager!
    
    static let shared = CKCareKitManager()
    
    override init() {
        super.init()
        
        coreDataStore = OCKStore(name: "CKSampleCareKitStore", securityApplicationGroupIdentifier: nil, type: coreDataStoreType, remote: CKCareKitRemoteSyncWithFirestore())
        
        initStore(forceUpdate: coreDataStoreType == .inMemory)

        let coordinator = OCKStoreCoordinator()
        coordinator.attach(store: coreDataStore)

        synchronizedStoreManager = OCKSynchronizedStoreManager(wrapping: coordinator)
        
    }
    
    fileprivate func initStore(forceUpdate: Bool = false) {
        if forceUpdate || UserDefaults.standard.object(forKey: prefCareKitCoreDataInitDate) == nil {
            coreDataStore.populateSampleData()
            
            UserDefaults.standard.set(Date(), forKey: prefCareKitCoreDataInitDate)
        }
    }
    
}
