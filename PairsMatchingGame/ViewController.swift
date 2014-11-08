//
//  ViewController.swift
//  PairsMatchingGame
//
//  Created by yrom on 14-11-7.
//  Copyright (c) 2014年 yrom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var stepper: UIStepper!
    weak var revealButton: UIButton!
    weak var shuffleButton: UIButton!
    
    /// read-only
    var pairsCount: Int {
        return Int(self.stepper.value)
    }
    
    var cardsCount: Int {
        get{
            return self.pairsCount * 2
        }
    }
    
    var cardViews = [CardView]()
    
    var matchedPairs: Int = 0 {
        didSet {
            if matchedPairs == pairsCount {
                showDialog()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
        setupCards()
//========20=====
//        for rect in GameLayout().grid {
//            let cardView = CardView(frame: rect)
//            cardViews.append(cardView)
//            self.view.addSubview(cardView)
//        }
   }

    
    func setupControls() {
        // An UIStepper
        let stepperFrame = CGRect(x: 113, y: 20, width: 94, height: 29)
        // An UIButton
        let revealButtonFrame = CGRect(x: 16, y: 20, width: 47, height: 30)
        // An UIButton
        let shuffleButtonFrame = CGRect(x: 256, y: 20, width: 48, height: 30)
        
        // Add the UI controls in code.
        let revealButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        revealButton.frame = revealButtonFrame
        revealButton.setTitle("Reveal", forState: UIControlState.Normal)
        revealButton.addTarget(self, action: "revealAll:", forControlEvents: UIControlEvents.TouchUpInside)
        self.revealButton = revealButton
        let shuffleButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        shuffleButton.frame = shuffleButtonFrame
        shuffleButton.setTitle("Shuffle", forState: UIControlState.Normal)
        shuffleButton.addTarget(self, action: "shuffleCards:", forControlEvents: UIControlEvents.TouchUpInside)
        self.shuffleButton = shuffleButton
        
        // Configure the stepper to allow values beween 1 and 10 (default: 4).
        // The step increment should be 1.
        let stepper = UIStepper(frame: stepperFrame)
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = 4
        stepper.stepValue = 1
        stepper.addTarget(self, action: "stepperValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.stepper = stepper

        self.view.addSubview(revealButton)
        self.view.addSubview(shuffleButton)
        self.view.addSubview(stepper)
    }
    
    func revealAll(button: UIButton) {
        self.foreach {
            $0.selected = true
        }

    }
    
    var lastSelectedCardView: CardView?
    
    func tappedCard(cardview: CardView) {
//        cardview.selected = !cardview.selected
        if cardview.selected { return }
        cardview.selected = true
        if let view = lastSelectedCardView{
            if view.card! == cardview.card! {
                matchedPairs++
            } else {
                delay(0.3, { self.hideCardView(view); self.hideCardView(cardview)})
            }
            lastSelectedCardView = nil
        } else {
            lastSelectedCardView = cardview
        }
        
    }
    
    func shuffleCards(button: UIButton) {
        shuffleCards()
    }
    
    func shuffleCards() {
        matchedPairs = 0
        assignCards()
        revealAll(self.revealButton)
        delay(1, hideCards)
    }
    
    func hideCards() {
        self.foreach {
            self.hideCardView($0)
        }
 
    }
    
    func hideCardView(cardview: CardView) {
        cardview.selected = false
    }
    
    
    func foreach(block: (CardView)->() ){
        for cardview in self.cardViews {
            block(cardview)
        }
    }
    
    lazy var cards = Card.fullDeck()
    /// assign cards to cardViews
    func assignCards() {
        shuffle(&self.cards)
        var pairs = [Card]()
        // double
        pairs += self.cards[0..<self.pairsCount]
        pairs += pairs
        shuffle(&pairs)
        
        for (i,cardView) in enumerate(self.cardViews) {
            cardView.card = pairs[i]
        }

    }
    
    func setupCards() {
        let rects = GameLayout().forPairs(self.pairsCount)
        // remove all cards
        foreach { $0.removeFromSuperview() }
        self.cardViews.removeAll(keepCapacity: false)
        // add new cards
        for rect in rects {
            let cardview = CardView(frame: rect)
            cardViews.append(cardview)
            cardview.addTarget(self, action: "tappedCard:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(cardview)
        }
        lastSelectedCardView = nil
        assignCards()
    }
    
    func stepperValueChanged(stepper: UIStepper) {
        setupCards()
        
//====================
//        var toRemove = self.cardViews.count - self.cardsCount
//        // Remove excess card views
//        if toRemove > 0 {
//            for i in 0..<toRemove{
//                let cardView = self.cardViews.removeLast()
//                cardView.removeFromSuperview()
//            }
//        }
//        var toAdd = self.cardsCount - self.cardViews.count
//        // Add card views
//        if toAdd > 0 {
//            let grid = GameLayout().grid
//            for i in self.cardViews.count..<self.cardsCount{
//                let rect = grid[i]
//                let cardView = CardView(frame: rect)
//                cardViews.append(cardView)
//                self.view.addSubview(cardView)
//            }
//        }
//        
//        // After modifying cardViews, the following should be true:
//        assert(self.cardViews.count == self.cardsCount)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func showDialog() {
        let alert = UIAlertController(title: "You Won", message: "Play another game!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let shuffle = UIAlertAction(title: "Shuffle", style: UIAlertActionStyle.Default, handler: {
            _ in
            self.shuffleCards()
        })
        
        alert.addAction(shuffle)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

