/* 
 PureMVC MultiCore haXe Port by Marco Secchi <marco.secchi@puremvc.org>
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
package org.puremvc.haxe.multicore.patterns.command;

/**
 * A MacroCommand subclass used by MacroCommandTest.
 */
class MacroCommandTestCommand extends MacroCommand
{
	/**
	 * Constructor.
	 */
	public function new()
	{
		super();
	}
		
	/**
	 * Initialize the MacroCommandTestCommand by adding
	 * its 2 SubCommands.
	 */
	override private function initializeMacroCommand(): Void
	{
		addSubCommand( org.puremvc.haxe.multicore.patterns.command.MacroCommandTestSub1Command );
		addSubCommand( org.puremvc.haxe.multicore.patterns.command.MacroCommandTestSub2Command );
	}
	
}