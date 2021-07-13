import Foundation
import SafariServices

let SFExtensionMessageKey = "message"

struct ExtensionMessage {
    var type: String
    var data: [String: Any]?

    init(message: [String: Any]) {
        type = message["type"] as! String
        data = message["data"] as? [String : Any]
    }
}

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        let item = context.inputItems[0] as! NSExtensionItem
        let rawMessage = item.userInfo?[SFExtensionMessageKey] as! [String: Any]

        let message = ExtensionMessage(message: rawMessage)

        NSLog("AG: The extension received a message (%@)", message.type);

        // Content script requests scripts and css for current page
        if (message.type == "get_rules") {
            do {
                let text = try String(contentsOfFile: AESharedResources.advancedBlockingContentRulesUrlString()!, encoding: .utf8);
                
                let response = NSExtensionItem()
                response.userInfo = [SFExtensionMessageKey: ["data": text]]

                context.completeRequest(returningItems: [response], completionHandler: nil)
            } catch {
                NSLog("AG: Error handling message (\(message.type)): \(error)");
            }
        }
    }
}
