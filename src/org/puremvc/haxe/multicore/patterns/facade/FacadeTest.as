/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.patterns.facade
{
 	import flash.display.Sprite;

	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
 	
 	import org.puremvc.as3.multicore.interfaces.*;
 	import org.puremvc.as3.multicore.patterns.proxy.*;
 	import org.puremvc.as3.multicore.patterns.observer.*;
 	import org.puremvc.as3.multicore.patterns.mediator.*;
 	
	/**
	 * Test the PureMVC Facade class.
	 *
  	 * @see org.puremvc.as3.multicore.patterns.facade.FacadeTestVO FacadeTestVO
  	 * @see org.puremvc.as3.multicore.patterns.facade.FacadeTestCommand FacadeTestCommand
	 */
 	public class FacadeTest extends TestCase {
  		
  		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
  	    public function FacadeTest( methodName:String ) {
   			super( methodName );
           }
  	
		/**
		 * Create the TestSuite.
		 */
  		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new FacadeTest( "testGetInstance" ) );
   			ts.addTest( new FacadeTest( "testRegisterCommandAndSendNotification" ) );
   			ts.addTest( new FacadeTest( "testRegisterAndRemoveCommandAndSendNotification" ) );
   			ts.addTest( new FacadeTest( "testRegisterAndRetrieveProxy" ) );
   			ts.addTest( new FacadeTest( "testRegisterAndRemoveProxy" ) );
 			ts.addTest( new FacadeTest( "testRegisterRetrieveAndRemoveMediator" ) );
 			ts.addTest( new FacadeTest( "testHasProxy" ) );
 			ts.addTest( new FacadeTest( "testHasMediator" ) );
 			ts.addTest( new FacadeTest( "testHasCommand" ) );
   			
   			return ts;
   		}
  		
  		/**
  		 * Tests the Facade Multiton Factory Method 
  		 */
  		public function testGetInstance():void {
  			
   			// Test Factory Method
   			var facade:IFacade = Facade.getInstance('FacadeTestKey1');
   			
   			// test assertions
   			assertTrue( "Expecting instance not null", facade != null );
   			assertTrue( "Expecting instance implements IFacade", facade is IFacade );
   			
   		}

  		/**
  		 * Tests Command registration and execution via the Facade.
  		 * 
  		 * <P>
  		 * This test gets a Multiton Facade instance 
  		 * and registers the FacadeTestCommand class 
  		 * to handle 'FacadeTest' Notifcations.<P>
  		 * 
  		 * <P>
  		 * It then sends a notification using the Facade. 
  		 * Success is determined by evaluating 
  		 * a property on an object placed in the body of
  		 * the Notification, which will be modified by the Command.</P>
  		 * 
  		 */
  		public function testRegisterCommandAndSendNotification():void {
  			
   			// Create the Facade, register the FacadeTestCommand to 
   			// handle 'FacadeTest' notifications
   			var facade:IFacade = Facade.getInstance('FacadeTestKey2');
   			facade.registerCommand('FacadeTestNote', org.puremvc.as3.multicore.patterns.facade.FacadeTestCommand);
   			

			// Send notification. The Command associated with the event
			// (FacadeTestCommand) will be invoked, and will multiply 
			// the vo.input value by 2 and set the result on vo.result
   			var vo:Object = new FacadeTestVO( 32 );
   			facade.sendNotification( 'FacadeTestNote', vo );
   			
   			// test assertions 
   			assertTrue( "Expecting vo.result == 64", vo.result == 64 );
   		}

  		/**
  		 * Tests Command removal via the Facade.
  		 * 
  		 * <P>
  		 * This test gets a Multiton Facade instance 
  		 * and registers the FacadeTestCommand class 
  		 * to handle 'FacadeTest' Notifcations. Then it removes the command.<P>
  		 * 
  		 * <P>
  		 * It then sends a Notification using the Facade. 
  		 * Success is determined by evaluating 
  		 * a property on an object placed in the body of
  		 * the Notification, which will NOT be modified by the Command.</P>
  		 * 
  		 */
  		public function testRegisterAndRemoveCommandAndSendNotification():void {
  			
   			// Create the Facade, register the FacadeTestCommand to 
   			// handle 'FacadeTest' events
   			var facade:IFacade = Facade.getInstance('FacadeTestKey3');
   			facade.registerCommand('FacadeTestNote', org.puremvc.as3.multicore.patterns.facade.FacadeTestCommand);
   			facade.removeCommand('FacadeTestNote');
   			

			// Send notification. The Command associated with the event
			// (FacadeTestCommand) will NOT be invoked, and will NOT multiply 
			// the vo.input value by 2 
   			var vo:Object = new FacadeTestVO( 32 );
   			facade.sendNotification('FacadeTestNote', vo);
   			
   			// test assertions 
   			assertTrue( "Expecting vo.result != 64", vo.result != 64 );
   		}

  		/**
  		 * Tests the regsitering and retrieving Model proxies via the Facade.
  		 * 
  		 * <P>
  		 * Tests <code>registerProxy</code> and <code>retrieveProxy</code> in the same test.
  		 * These methods cannot currently be tested separately
  		 * in any meaningful way other than to show that the
  		 * methods do not throw exception when called. </P>
  		 */
  		public function testRegisterAndRetrieveProxy():void {
  			
   			// register a proxy and retrieve it.
   			var facade:IFacade = Facade.getInstance('FacadeTestKey4');
			facade.registerProxy( new Proxy('colors', ['red', 'green', 'blue']) );
			var proxy:Proxy = Proxy( facade.retrieveProxy( 'colors' ) );
			
			// test assertions
   			assertTrue( "Expecting proxy is IProxy", proxy is IProxy);

			// retrieve data from proxy
			var data:Array = proxy.getData() as Array;
			
			// test assertions
   			assertNotNull( "Expecting data not null", data );
   			assertTrue( "Expecting data is Array", data is Array );
   			assertTrue( "Expecting data.length == 3", data.length == 3 );
   			assertTrue( "Expecting data[0] == 'red'", data[0]  == 'red' );
   			assertTrue( "Expecting data[1] == 'green'", data[1]  == 'green' );
   			assertTrue( "Expecting data[2] == 'blue'", data[2]  == 'blue' );
   		}
  		
  		/**
  		 * Tests the removing Proxies via the Facade.
  		 */
  		public function testRegisterAndRemoveProxy():void {
  			
   			// register a proxy, remove it, then try to retrieve it
   			var facade:IFacade = Facade.getInstance('FacadeTestKey5');
   			var proxy:IProxy = new Proxy('sizes', ['7', '13', '21'] );
			facade.registerProxy( proxy );
			
			// remove the proxy
			var removedProxy:IProxy = facade.removeProxy('sizes');

			// assert that we removed the appropriate proxy
   			assertTrue( "Expecting removedProxy.getProxyName() == 'sizes'", 
   						removedProxy.getProxyName() == 'sizes' );
			
			// make sure we can no longer retrieve the proxy from the model
			proxy = facade.retrieveProxy( 'sizes' );
			
			// test assertions
   			assertNull( "Expecting proxy is null", proxy );
   		}

   		
  		/**
  		 * Tests registering, retrieving and removing Mediators via the Facade.
  		 */
  		public function testRegisterRetrieveAndRemoveMediator():void {
  			
   			// register a mediator, remove it, then try to retrieve it
   			var facade:IFacade = Facade.getInstance('FacadeTestKey6');
			facade.registerMediator( new Mediator( Mediator.NAME, new Sprite() ) );
			
			// retrieve the mediator
   			assertNotNull( "Expecting mediator is not null", facade.retrieveMediator( Mediator.NAME ) );

			// remove the mediator
			var removedMediator:IMediator = facade.removeMediator(Mediator.NAME);

			// assert that we have removed the appropriate mediator
   			assertTrue( "Expecting removedMediator.getMediatorName() == Mediator.NAME", 
						removedMediator.getMediatorName() == Mediator.NAME);
				
			// assert that the mediator is no longer retrievable
   			assertTrue( "Expecting facade.retrieveMediator( Mediator.NAME ) == null )", 
   						facade.retrieveMediator( Mediator.NAME ) == null );
						  			
   		}

  		/**
  		 * Tests the hasProxy Method
  		 */
  		public function testHasProxy():void {
  			
   			// register a Proxy
			var facade:IFacade = Facade.getInstance('FacadeTestKey7');
			facade.registerProxy( new Proxy( 'hasProxyTest', [1,2,3] ) );
			
   			// assert that the model.hasProxy method returns true
   			// for that proxy name
   			assertTrue( "Expecting facade.hasProxy('hasProxyTest') == true", 
   						facade.hasProxy('hasProxyTest') == true);
			
   		}

  		/**
  		 * Tests the hasMediator Method
  		 */
  		public function testHasMediator():void {
  			
   			// register a Mediator
			var facade:IFacade = Facade.getInstance('FacadeTestKey8');
			facade.registerMediator( new Mediator( 'facadeHasMediatorTest', new Sprite() ) );
			
   			// assert that the facade.hasMediator method returns true
   			// for that mediator name
   			assertTrue( "Expecting facade.hasMediator('facadeHasMediatorTest') == true", 
   						facade.hasMediator('facadeHasMediatorTest') == true);
   						
   			facade.removeMediator( 'facadeHasMediatorTest' );
   			
   			// assert that the facade.hasMediator method returns false
   			// for that mediator name
   			assertTrue( "Expecting facade.hasMediator('facadeHasMediatorTest') == false", 
   						facade.hasMediator('facadeHasMediatorTest') == false);
			
   		}

  		/**
  		 * Test hasCommand method.
  		 */
  		public function testHasCommand():void {
  			
   			// register the ControllerTestCommand to handle 'hasCommandTest' notes
   			var facade:IFacade = Facade.getInstance('FacadeTestKey10');
   			facade.registerCommand('facadeHasCommandTest', org.puremvc.as3.multicore.patterns.facade.FacadeTestCommand);
   			
   			// test that hasCommand returns true for hasCommandTest notifications 
   			assertTrue( "Expecting facade.hasCommand('facadeHasCommandTest') == true", facade.hasCommand('facadeHasCommandTest') == true );
   			
   			// Remove the Command from the Controller
   			facade.removeCommand('facadeHasCommandTest');
			
   			// test that hasCommand returns false for hasCommandTest notifications 
   			assertTrue( "Expecting facade.hasCommand('facadeHasCommandTest') == false", facade.hasCommand('facadeHasCommandTest') == false );
   			
   		}

  	}
}