//
//  UIPopoverListView.swift
//  UIPopViewListViewDemo
//
//  Created by duanchuanfen on 16/5/26.
//  Copyright © 2016年 duanchuanfen. All rights reserved.
//

import UIKit
protocol UIPopoverListViewDelegate: class {
    
    
    func popoverListView(popoverListView:UIPopoverListView,didSelectIndexPath   indexPath:NSIndexPath)
    func popoverListViewCancel(popoverListView:UIPopoverListView)
    func popoverListView(popoverListView:UIPopoverListView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
    func  onCommintAction()
    
    
}

protocol UIPopoverListViewDataSource :class{
    func popoverListView(popoverListView:UIPopoverListView,cellForIndexPath indexPath:NSIndexPath)->UITableViewCell
    func popoverListView(popoverListView:UIPopoverListView,numberOfRowsInSection section:NSInteger)->NSInteger
    
}



class UIPopoverListView: UIView,UITableViewDelegate,UITableViewDataSource{
    
    var listView:UITableView?
    var titleView:UILabel?
    var overlayView:UIControl?
    
    weak var popViewDelegate: UIPopoverListViewDelegate!
    weak var popViewDataSource:UIPopoverListViewDataSource!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defautInit()
        
    }
    
    func defautInit() {
        listView = UITableView(frame: CGRectMake(0, 32.0,self.bounds.size.width,self.bounds.size.height-32.0-30), style: UITableViewStyle.Plain)
        listView!.dataSource = self
        listView!.delegate = self
        self .addSubview(listView!)
        
        titleView = UILabel(frame:CGRectMake(0,0,self.bounds.size.width,40))
        titleView!.font = UIFont.systemFontOfSize(17.0)
        titleView!.backgroundColor = UIColor.blueColor()
        titleView!.textAlignment = NSTextAlignment.Center
        titleView!.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        titleView!.textColor = UIColor.whiteColor()
        self.addSubview(titleView!)
        
        let button:UIButton = UIButton(type:UIButtonType.Custom)
        button.backgroundColor = UIColor.whiteColor()
        button.frame = CGRectMake(0, self.bounds.size.height-40, self.bounds.size.width,40)
        button.setTitle("确定",forState:UIControlState.Normal)
        button.addTarget(self, action:"onCommitAction", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button.backgroundColor = UIColor.greenColor()
        self .addSubview(button)
        
        overlayView = UIControl(frame:UIScreen.mainScreen().bounds)
        overlayView!.backgroundColor = UIColor(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.5)
        overlayView!.addTarget(self, action:"dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        //self.addSubview(overlayView!)
        
        let footView:UIView = UIView()
        footView.backgroundColor = UIColor.whiteColor()
        listView?.tableFooterView = footView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> NSInteger {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> NSInteger {
        if (self.popViewDataSource != nil){
            return (self.popViewDataSource.popoverListView(self, numberOfRowsInSection:section))
        }else{
            return 0
        }
    }
    
    func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.popViewDataSource != nil){
            return self.popViewDataSource.popoverListView(self, cellForIndexPath: indexPath)
        }else{
            let  cell = UITableViewCell()
            return cell
        }
     }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.popViewDelegate != nil){
            self.popViewDelegate.popoverListView(self, didSelectIndexPath: indexPath)
        }
    }
    
    
    //
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (self.popViewDelegate != nil){
            return self.popViewDelegate.popoverListView(self, heightForRowAtIndexPath: indexPath)
        }else{
            return 0;
        }
     
    }
    
    func onCommitAction(){
        if (self.popViewDelegate != nil){
            self.popViewDelegate.onCommintAction()
            
        }
    }
    
    func dismiss(){
        self.fadeOut()
    }
    
    private func fadeIn(){
        self.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.alpha = 0;
        UIView.animateWithDuration(0.35, animations:{
            () -> Void in
            self.alpha = 1;
            self.transform = CGAffineTransformMakeScale(1, 1)
            },completion:{(finished:Bool)-> Void in
                
        })
    }
    
    
    private func fadeOut(){
        UIView.animateWithDuration(0.35, animations:{
            () -> Void in
            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
            self.alpha = 0.0;
            },completion:{(finished:Bool)-> Void in
                if finished{
                    self.overlayView!.removeFromSuperview()
                    self.removeFromSuperview()
                }
        })
    }
    
    
    func show()
    {
        let  keywindow:UIWindow = UIApplication.sharedApplication().keyWindow!
        keywindow.addSubview(self.overlayView!)
        keywindow.addSubview(self)
        
        self.center = CGPointMake(keywindow.bounds.size.width/2.0,
            keywindow.bounds.size.height/2.0)
        self.fadeIn()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.popViewDelegate.popoverListViewCancel(self)
        self.dismiss()
    }
    
    func setTitle(title:NSString)
    {
        titleView!.text = title as String
    }
    
    
}
