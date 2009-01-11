/* 
 PureMVC MultiCore haXe Port by Marco Secchi <marco.secchi@puremvc.org>
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
package org.puremvc.haxe.multicore.core;

import org.puremvc.haxe.multicore.core.Controller;
import org.puremvc.haxe.multicore.interfaces.IController;
import org.puremvc.haxe.multicore.interfaces.IView;
import org.puremvc.haxe.multicore.patterns.observer.Notification;
 	
/**
 * Test the PureMVC Controller class.
 */
class ControllerTest extends haxe.unit.TestCase
{  		
	/**
	 * Tests the Controller Multiton Factory Method 
	 */
	public function testGetInstance(): Void {
  			
 		// Test Factory Method
 		var controller: IController = Controller.getInstance( 'ControllerTestKey1' );
  			
 		// test assertions
 		assertTrue( controller != null );
 		assertTrue( Std.is( controller, IController ) );
 	}

	/**
	 * Tests Command registration and execution.
	 * 
	 * <p>This test gets the Multiton Controller instance 
	 * and registers the ControllerTestCommand class 
	 * to handle 'ControllerTest' Notifications.</p>
	 * 
	 * <p>It then constructs such a Notification and tells the 
	 * Controller to execute the associated Command.
	 * Success is determined by evaluating a property
	 * on an object passed to the Command, which will
	 * be modified when the Command executes.</p>
	 * 
	 */
	public function testRegisterAndExecuteCommand(): Void 
	{			
		// Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
		var controller: IController = Controller.getInstance( 'ControllerTestKey2' );
		controller.registerCommand( 'ControllerTest', org.puremvc.haxe.multicore.core.ControllerTestCommand );
  			
		// Create a 'ControllerTest' note
		var vo: ControllerTestVO = new ControllerTestVO( 12.0 );
		var note: Notification = new Notification( 'ControllerTest', vo );

		// Tell the controller to execute the Command associated with the note
		// the ControllerTestCommand invoked will multiply the vo.input value
		// by 2 and set the result on vo.result
		controller.executeCommand( note );
   			
		// test assertions 
		assertEquals( vo.result, 24.0 );
	}
   		
	/**
	 * Tests Command registration and removal.
	 * 
	 * <p>Tests that once a Command is registered and verified
	 * working, it can be removed from the Controller.</p>
	 */
	public function testRegisterAndRemoveCommand(): Void
	{	
		// Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
		var controller: IController = Controller.getInstance( 'ControllerTestKey3' );
		controller.registerCommand( 'ControllerRemoveTest', org.puremvc.haxe.multicore.core.ControllerTestCommand );
   			
		// Create a 'ControllerTest' note
		var vo: ControllerTestVO = new ControllerTestVO( 12 );
		var note: Notification = new Notification( 'ControllerRemoveTest', vo );

		// Tell the controller to execute the Command associated with the note
		// the ControllerTestCommand invoked will multiply the vo.input value
		// by 2 and set the result on vo.result
		controller.executeCommand( note );
   			
		// test assertions 
		assertEquals( vo.result, 24.0 );
   			
		// Reset result
		vo.result = 0;
   			
		// Remove the Command from the Controller
		controller.removeCommand( 'ControllerRemoveTest' );
			
		// Tell the controller to execute the Command associated with the
		// note. This time, it should not be registered, and our vo result
		// will not change   			
		controller.executeCommand( note );
   			
		// test assertions 
		assertEquals( vo.result, 0 );		
	}

	/**
	 * Test hasCommand method.
	 */
	public function testHasCommand(): Void
	{
		
		// register the ControllerTestCommand to handle 'hasCommandTest' notes
		var controller: IController = Controller.getInstance( 'ControllerTestKey4' );
		controller.registerCommand( 'hasCommandTest', org.puremvc.haxe.multicore.core.ControllerTestCommand );
		
		// test that hasCommand returns true for hasCommandTest notifications 
		assertTrue( controller.hasCommand( 'hasCommandTest' ) );
		
		// Remove the Command from the Controller
		controller.removeCommand( 'hasCommandTest' );
		
		// test that hasCommand returns false for hasCommandTest notifications 
		assertFalse( controller.hasCommand('hasCommandTest') );
		
	}

	/**
 	* Tests Removing and Reregistering a Command
 	* 
 	* <p>Tests that when a Command is re-registered that it isn't fired twice.
 	* This involves, minimally, registration with the controller but
 	* notification via the View, rather than direct execution of
 	* the Controller's executeCommand method as is done above in 
 	* testRegisterAndRemove. The bug under test was fixed in haXe Standard 
 	* Version 1.0.2. If you run the unit tests with 1.0.1 this
 	* test will fail.</p>
 	*/
	public function testReregisterAndExecuteCommand(): Void
	{
	 
		// Fetch the controller, register the ControllerTestCommand2 to handle 'ControllerTest2' notes
		var controller: IController = Controller.getInstance( 'ControllerTestKey5' );
		controller.registerCommand( 'ControllerTest2', org.puremvc.haxe.multicore.core.ControllerTestCommand2 );
	
		// Remove the Command from the Controller
		controller.removeCommand( 'ControllerTest2' );
	
		// Re-register the Command with the Controller
		controller.registerCommand( 'ControllerTest2', org.puremvc.haxe.multicore.core.ControllerTestCommand2 );

		// Create a 'ControllerTest2' note
		var vo: ControllerTestVO = new ControllerTestVO( 12 );
		var note: Notification = new Notification( 'ControllerTest2', vo );

		// retrieve a reference to the View.
		var view: IView = View.getInstance( 'ControllerTestKey5' );
	
		// send the Notification
		view.notifyObservers( note );
	
		// test assertions 
		// if the command is executed once the value will be 24
		assertEquals( vo.result, 24.0 );

		// Prove that accumulation works in the VO by sending the notification again
		view.notifyObservers( note );
	
		// if the command is executed twice the value will be 48
		assertEquals( vo.result, 48.0 );
	}
	
}