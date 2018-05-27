//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Liu Teng Hou on 11/16/17.
//  Copyright © 2017 Blue Anchor. All rights reserved.
//
// custom class to control star ratings

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK Properties
    private var ratingButtons = [UIButton]();
    var rating = 0{
        didSet{
            updateButtonSelectionStates();
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width:44.0, height:44.0){
        didSet{
            setupButtons();
        }
    }
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons();
        }
    }
    
    
    //MARK: initialization
    override init(frame: CGRect) { //programatic
        super.init(frame:frame);
        setupButtons();
    }
    
    required init(coder: NSCoder){ //IB
        super.init(coder:coder);
        setupButtons();
    }
    //MARK: private methods
    private func setupButtons(){
        //clear existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button);
            button.removeFromSuperview();
        }
        ratingButtons.removeAll();
        
        //Load Button Images
        let bundle = Bundle(for: type(of:self));
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection);
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection);
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection);

        
        //creates 5 buttons
        for index in 0..<starCount{
            //Create the button
            let button = UIButton();
            //sets button star image
            button.setImage(emptyStar, for: .normal);
            button.setImage(filledStar, for: .selected);
            button.setImage(highlightedStar, for: .highlighted);
            button.setImage(highlightedStar, for: [.highlighted, .selected]);
            //button constraints
            button.translatesAutoresizingMaskIntoConstraints = false;
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true;
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true;
            
            //sets accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating";
            
            //setup button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside);
            //add the button to the stack
            addArrangedSubview(button);
            //add the new button to the rating button array
            ratingButtons.append(button);
        }
        
        updateButtonSelectionStates();
    }
    
    //MARK: button action
    func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.index(of: button) else{
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)");
        }
        
        //calculate the rating of the selected star
        let selectedRating = index + 1;
        if (selectedRating == rating){
            rating = 0;
        }else{
            rating = selectedRating;
        }
        print("Button Pressed");
    }
    
    //update the button's appearance
    private func updateButtonSelectionStates(){
        for(index, button) in ratingButtons.enumerated(){
            //update the button's appearance
            button.isSelected = index < rating;
            
            //set the hint string for the currently selected star
            let hintString: String?
            if (rating == index+1){
                hintString = "Tap to reset rating to zero.";
            }else{
                hintString = nil;
            }
            
            //calculate the value string
            let valueString:String;
            switch(rating){
            case 0:
                valueString = "No rating set.";
            case 1:
                valueString = "One star set.";
            default:
                valueString = "\(rating) stars set.";
            }
            
            //assign hint and value strings
            button.accessibilityHint = hintString;
            button.accessibilityValue = valueString;
        }
    }
}
