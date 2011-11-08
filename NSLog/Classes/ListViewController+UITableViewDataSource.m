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

#import "ListViewController+UITableViewDataSource.h"
#import "ListViewController+Private.h"
#import "ASLHelper.h"
#import "ASLMessage.h"
#import "MessageCell.h"

static NSString * const __listCellID    = @"ListCellID";
static NSString * const __settingCellID = @"SettingCellID";

@implementation ListViewController( UITableViewDataSource )

- ( NSInteger )numberOfSectionsInTableView: ( UITableView * )tableView
{
    ( void )tableView;
    
    return ( NSInteger )[ [ [ ASLHelper sharedInstance ] messagesByDay ] count ];
}

- ( NSInteger )tableView: ( UITableView * )tableView numberOfRowsInSection: ( NSInteger )section
{
    NSArray  * keys;
    NSUInteger keyIndex;
    NSString * key;
    
    ( void )tableView;
    ( void )section;
    
    keys     = [ [ [ [ ASLHelper sharedInstance ] messagesByDay ] allKeys ] sortedArrayUsingSelector: @selector( compare: ) ];
    keyIndex = ( [ keys count ] - ( NSUInteger )section ) - 1;
    key      = [ keys objectAtIndex: keyIndex ];
    
    return ( NSInteger )[ [ [ [ ASLHelper sharedInstance ] messagesByDay ] objectForKey: key ] count ];
}

- ( UITableViewCell * )tableView: ( UITableView * )tableView cellForRowAtIndexPath: ( NSIndexPath * )indexPath
{
    NSUInteger    messageIndex;
    ASLMessage  * msg;
    MessageCell * cell;
    
    ( void )indexPath;
    
    messageIndex = ( [ [ [ ASLHelper sharedInstance ] messages ] count ] - ( NSUInteger )[ indexPath row ] ) - 1;
    
    cell = [ tableView dequeueReusableCellWithIdentifier: MessageCellID ];
    msg  = [ [ [ ASLHelper sharedInstance ] messages ] objectAtIndex: messageIndex ];
    
    if( cell == nil )
    {
        cell = [ MessageCell new ];
        
        [ cell autorelease ];
    }
    
    cell.message   = msg;
    cell.alternate = ( [ indexPath row ] % 2 ) ? YES : NO;
    
    return cell;
}

- ( NSString * )tableView: ( UITableView * )tableView titleForHeaderInSection: ( NSInteger )section
{
    NSArray  * keys;
    NSUInteger keyIndex;
    
    ( void )tableView;
    
    keys     = [ [ [ [ ASLHelper sharedInstance ] messagesByDay ] allKeys ] sortedArrayUsingSelector: @selector( compare: ) ];
    keyIndex = ( [ keys count ] - ( NSUInteger )section ) - 1;
    
    return [ keys objectAtIndex: keyIndex ];
}

@end
