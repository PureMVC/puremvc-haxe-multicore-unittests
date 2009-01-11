/* 
 PureMVC MultiCore haXe Port by Marco Secchi <marco.secchi@puremvc.org>
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
package org.puremvc.haxe.multicore.core;

import org.puremvc.haxe.multicore.interfaces.INotification;
import org.puremvc.haxe.multicore.patterns.command.SimpleCommand;

/**
 * A SimpleCommand subclass used by ControllerTest.
 */
class ControllerTestCommand2 extends SimpleCommand
{
	/**
	 * Fabricate a result by multiplying the input by 2 and adding to the existing result
	 *
	 * <p>This tests accumulation effect that would show if the command were executed more than once.<p/>
	 */
	override public function execute( note: INotification ): Void
	{
		var vo: ControllerTestVO = note.getBody();
			
		// Fabricate a result
		vo.result = vo.result + ( 2 * vo.input );
	}
		
}