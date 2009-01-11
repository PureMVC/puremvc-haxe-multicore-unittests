/* 
 PureMVC MultiCore haXe Port by Marco Secchi <marco.secchi@puremvc.org>
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
package org.puremvc.haxe.multicore.core;

import org.puremvc.haxe.multicore.interfaces.IMediator;
import org.puremvc.haxe.multicore.interfaces.INotification;
import org.puremvc.haxe.multicore.patterns.mediator.Mediator;
	
/**
 * A Mediator class used by ViewTest.
 */
class ViewTestMediator<T> extends Mediator
{
	/**
	 * The Mediator name
	 */
	public static var NAME: String = 'ViewTestMediator';
		
	/**
	 * Constructor
	 */
	public function new( view: T ) {
		super( NAME, view );
	}

	override public function listNotificationInterests(): Array<String>
	{
		// be sure that the mediator has some Observers created
		// in order to test removeMediator
		return [ 'ABC', 'DEF', 'GHI'  ];
	}

}