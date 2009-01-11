/* 
 PureMVC MultiCore haXe Port by Marco Secchi <marco.secchi@puremvc.org>
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
package org.puremvc.haxe.multicore.core;

/**
 * A utility class used by ControllerTest.
 */
class ControllerTestVO
{
	/**
	 * Constructor.
	 */
	public function new( input: Float )
	{
		this.input = input;
		this.result = 0;
	}

	public var input: Float;
	public var result: Float;
}