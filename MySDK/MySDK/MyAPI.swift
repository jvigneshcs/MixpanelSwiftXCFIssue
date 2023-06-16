//
//  MyAPI.swift
//  MySDK
//
//  Created by Vignesh Jeyaraj on 16/06/23.
//

import Mixpanel

public class MyAPI {
    private let mixpanel: MixpanelInstance
    
    public init(token: String) {
        self.mixpanel = Mixpanel.initialize(token: token,
                                            trackAutomaticEvents: false)
    }
    
    public func track(event: String) {
        mixpanel.track(event: event)
    }
}
