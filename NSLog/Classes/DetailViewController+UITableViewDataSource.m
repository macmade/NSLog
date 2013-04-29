/*******************************************************************************
 * Copyright (c) 2010, Jean-David Gadina - www.xs-labs.com
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

#import "DetailViewController+UITableViewDataSource.h"
#import "ASLMessage.h"
#import "GroupedTableViewCellBackgroundView.h"

@implementation DetailViewController( UITableViewDataSource )

- ( NSInteger )numberOfSectionsInTableView: ( UITableView * )tableView
{
    ( void )tableView;
    
    return 2;
}

- ( NSInteger )tableView: ( UITableView * )tableView numberOfRowsInSection: ( NSInteger )section
{
    ( void )tableView;
    ( void )section;
    
    if( section == 0 )
    {
        return 1;
    }
    else
    {
        return 8;
    }
    
    return 0;
}

- ( UITableViewCell * )tableView: ( UITableView * )tableView cellForRowAtIndexPath: ( NSIndexPath * )indexPath
{
    GroupedTableViewCellBackgroundView * background;
    UITableViewCell                    * cell;
    
    ( void )tableView;
    ( void )indexPath;
    
    cell = nil;
    
    if( [ indexPath section ] == 0 )
    {
        cell                           = [ [ UITableViewCell alloc ] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: nil ];
        cell.textLabel.text            = _message.message;
        cell.textLabel.font            = [ UIFont boldSystemFontOfSize: [ UIFont smallSystemFontSize ] ];
        cell.textLabel.textColor       = [ UIColor darkGrayColor ];
        cell.textLabel.numberOfLines   = INT_MAX;
        cell.textLabel.lineBreakMode   = UILineBreakModeWordWrap;
    }
    else
    {
        cell                                 = [ [ UITableViewCell alloc ] initWithStyle: UITableViewCellStyleValue2 reuseIdentifier: nil ];
        cell.textLabel.font                  = [ UIFont systemFontOfSize: [ UIFont smallSystemFontSize ] ];
        cell.detailTextLabel.font            = [ UIFont systemFontOfSize: [ UIFont smallSystemFontSize ] ];
        cell.textLabel.textColor             = [ UIColor colorWithHue: ( CGFloat )0.575 saturation: ( CGFloat )0.5 brightness: ( CGFloat )0.75 alpha: ( CGFloat )1 ];
        cell.detailTextLabel.textColor       = [ UIColor darkGrayColor ];
        cell.textLabel.backgroundColor       = [ UIColor clearColor ];
        cell.detailTextLabel.backgroundColor = [ UIColor clearColor ];
        background                           = [ [ GroupedTableViewCellBackgroundView alloc ] initWithFrame: CGRectZero ];
        
        if( [ indexPath row ] % 2 )
        {
            background.fillColor = [ UIColor colorWithPatternImage: [ UIImage imageNamed: @"cell-background-alternate.png" ] ];
        }
        else
        {
            background.fillColor = [ UIColor colorWithPatternImage: [ UIImage imageNamed: @"cell-background-normal.png" ] ];
        }
        
        switch( [ indexPath row ] )
        {
            case 0:
                
                background.backgroundViewType = GroupedTableViewCellBackgroundViewTypeTop;
                break;
                
            case 7:
                
                background.backgroundViewType = GroupedTableViewCellBackgroundViewTypeBottom;
                break;
                
            default:
                
                background.backgroundViewType = GroupedTableViewCellBackgroundViewTypeMiddle;
                break;
        }
        
        cell.backgroundView = background;
        
        [ background release ];
        
        switch( [ indexPath row ] )
        {
            case 0:
                
                cell.textLabel.text       = NSLocalizedString( @"DetailViewSender", nil );
                cell.detailTextLabel.text = _message.sender;;
                break;
                
            case 1:
                
                cell.textLabel.text       = NSLocalizedString( @"DetailViewLevel", nil );
                cell.detailTextLabel.text = _message.sender;
                break;
                
            case 2:
                
                cell.textLabel.text       = NSLocalizedString( @"DetailViewFacility", nil );
                cell.detailTextLabel.text = _message.facility;
                break;
                
            case 3:
                
                cell.textLabel.text       = NSLocalizedString( @"DetailViewHost", nil );
                cell.detailTextLabel.text = _message.host;
                break;
                
            case 4:
                
                cell.textLabel.text       = NSLocalizedString( @"DetailViewTime", nil );
                cell.detailTextLabel.text = _message.sender;
                break;
                
            case 5:
                
                cell.textLabel.text       = NSLocalizedString( @"DetailViewPID", nil );
                cell.detailTextLabel.text = [ NSString stringWithFormat: @"%u", _message.pid ];
                break;
                
            case 6:
                
                cell.textLabel.text       = NSLocalizedString( @"DetailViewUID", nil );
                cell.detailTextLabel.text = [ NSString stringWithFormat: @"%u", _message.uid ];
                break;
                
            case 7:
                
                cell.textLabel.text       = NSLocalizedString( @"DetailViewGID", nil );
                cell.detailTextLabel.text = [ NSString stringWithFormat: @"%u", _message.gid ];
                break;
                
            default:
                
                break;
        }
    }
    
    return [ cell autorelease ];
}

- ( NSString * )tableView: ( UITableView * )tableView titleForHeaderInSection: ( NSInteger )section
{
    ( void )tableView;
    
    if( section == 0 )
    {
        return NSLocalizedString( @"Message", nil );
    }
    else
    {
        return NSLocalizedString( @"Details", nil );
    }
    
    return nil;
}

@end
