//
//  SafariExtensionHandler.swift
//  AdGuard
//
//  Created by tvinzz on 13.07.2021.
//  Copyright © 2021 Adguard Software Ltd. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {

    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        
        NSLog("AG: The extension received a message (%@)", messageName);
        
        if (messageName == "safariVersion") {
            do {
                if (userInfo == nil || userInfo!["safariVersion"] == nil) {
                    NSLog("AG: No Safari version passed with the message");
                    return;
                }
                
                let safariVersion = userInfo?["safariVersion"] as? String ?? "";
                NSLog("AG: Safari version: %@", safariVersion);
            } catch {
                NSLog("AG: Error handling message (\(messageName)): \(error)");
            }
        }
    }
}
