//
//  DetailViewController.swift
//  JSQMessagesMasterDetail
//
//  Created by Trey Ethridge on 2/14/17.
//  Copyright © 2017 Republic Wireless. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class DetailViewController: JSQMessagesViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var messages = [JSQMessage]()
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!

    func configureView() {
        // Update the user interface for the detail item.
//        if let detail = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.description
//            }
//        }
        
        for i in 1...10 {
            messages.append(JSQMessage(senderId: "me", displayName: "Me", text: "Message \(i)"))
        }
        collectionView?.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSender()
        incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.lightGray)
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        
        return messages[indexPath.item].senderId == self.senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        
        return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: "ME", backgroundColor: UIColor.jsq_messageBubbleGreen(), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12), diameter: 50)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        let can = super.collectionView(collectionView, canPerformAction: action, forItemAt: indexPath, withSender: sender)
//        let isSelect = action == #selector(UIResponderStandardEditActions.select(_:))
//        return can || isSelect
//    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let select = super.collectionView(collectionView, shouldSelectItemAt: indexPath)
        print("Row selected at: \(indexPath.item)")
        return select
    }
    
    // This is the supposed fix for the bad layout on ipad.  See: https://github.com/jessesquires/JSQMessagesViewController/issues/1042  It doesn't fix the issue for me.
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        let ctx = JSQMessagesCollectionViewFlowLayoutInvalidationContext()
//        ctx.invalidateFlowLayoutMessagesCache = true
//        collectionView?.collectionViewLayout?.invalidateLayout(with: ctx)
//    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    private func setSender() {
        self.senderId = "me"
        self.senderDisplayName = "Me"
    }

}
