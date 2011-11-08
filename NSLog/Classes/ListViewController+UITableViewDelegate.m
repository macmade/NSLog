/*******************************************************************************
 * Copyright (c) 2010, Jean-David Gadina <macmade@eosgarden.com>
 * Distributed under the Boost Software License, Version 1.0.
 * 
 * Boost Software License - Version 1.0 - August 17th, 2003
 * 
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ******************************************************************************/

/* $Id$ */

#import "ListViewController+UITableViewDelegate.h"
#import "DetailViewController.h"
#import "ASLHelper.h"

@implementation ListViewController( UITableViewDelegate )

- ( void )tableView: ( UITableView * )tableView didSelectRowAtIndexPath: ( NSIndexPath * )indexPath
{
    NSUInteger             messageIndex;
    DetailViewController * controller;
    
    messageIndex       = ( [ [ [ ASLHelper sharedInstance ] messages ] count ] - ( NSUInteger )[ indexPath row ] ) - 1;
    controller         = [ DetailViewController new ];
    controller.message = [ [ [ ASLHelper sharedInstance ] messages ] objectAtIndex: messageIndex ];
    
    [ self.navigationController pushViewController: controller animated: YES ];
    [ tableView deselectRowAtIndexPath: indexPath animated: YES ];
    [ controller release ];
}

- ( CGFloat )tableView: ( UITableView * )tableView heightForRowAtIndexPath: ( NSIndexPath * )indexPath
{
    ( void )tableView;
    ( void )indexPath;
    
    return ( CGFloat )55;
}

- ( CGFloat )tableView: ( UITableView * )tableView heightForHeaderInSection: ( NSInteger )section
{
    ( void )tableView;
    ( void )section;
    
    return ( CGFloat )20;
}

- ( UIView * )tableView: ( UITableView * )tableView viewForHeaderInSection: ( NSInteger )section
{
    UIView   * view;
    UILabel  * label;
    NSString * title;
    
    title = [ tableView.dataSource tableView: tableView titleForHeaderInSection: section ];
    view  = [ [ UIView alloc ] initWithFrame: CGRectZero ];
    label = [ [ UILabel alloc ] initWithFrame: CGRectMake( 10, 0, 0, [ tableView.delegate tableView: tableView heightForHeaderInSection: section ] ) ];
    
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.backgroundColor  = [ UIColor clearColor ];
    label.font             = [ UIFont boldSystemFontOfSize: [ UIFont smallSystemFontSize ] ];
    label.textColor        = [ UIColor whiteColor ];
    
    view.backgroundColor = [ UIColor colorWithPatternImage: [ UIImage imageNamed: @"header-background.png" ] ];
    view.alpha           = ( CGFloat )0.75;
    
    [ label setText: title ];
    [ view addSubview: label ];
    
    [ label release ];
    
    return [ view autorelease ];
}

@end
