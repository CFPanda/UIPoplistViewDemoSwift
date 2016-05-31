//
//  ViewController.swift
//  UIPopViewListViewDemo
//
//  Created by duanchuanfen on 16/5/26.
//  Copyright © 2016年 duanchuanfen. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPopoverListViewDelegate,UIPopoverListViewDataSource{
    
    var popListView:UIPopoverListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button:UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(30, 100, self.view.frame.size.width-60, 100)
        button.backgroundColor = UIColor.cyanColor()
        button.setTitle("展现popView", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "showPopView", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showPopView(){
        
        popListView = UIPopoverListView(frame:CGRectMake(10,(self.view.bounds.size.height-342)/2.0,self.view.bounds.size.width-20.0,342))
        popListView!.popViewDelegate = self;
        popListView!.popViewDataSource = self;
        popListView!.setTitle("这是一个popView列表")
        popListView!.show()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func popoverListView(popoverListView: UIPopoverListView, cellForIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        let string:NSString = NSString(format:"这是第%d行", indexPath.row)
        cell.textLabel?.text = string as String
        return cell
    }
    
    func popoverListView(popoverListView: UIPopoverListView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 62.0
    }
    
    func popoverListView(popoverListView: UIPopoverListView, didSelectIndexPath indexPath: NSIndexPath) {
        self.view.backgroundColor = UIColor.redColor()
    }
    
    func popoverListView(popoverListView: UIPopoverListView, numberOfRowsInSection section: NSInteger) -> NSInteger {
        return 20;
    }
    func popoverListViewCancel(popoverListView: UIPopoverListView) {
        
    }
    
    func onCommintAction() {
        //点击确定按钮做的事情
        popListView!.dismiss()
    }
    
    
}

