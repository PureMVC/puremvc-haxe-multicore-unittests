/* 
 PureMVC MultiCore haXe Port by Marco Secchi <marco.secchi@puremvc.org>
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved. 
 Your reuse is governed by the Creative Commons Attribution 3.0 License 
 */
import org.puremvc.haxe.multicore.patterns.observer.NotificationTest;
import org.puremvc.haxe.multicore.patterns.observer.ObserverTest;
import org.puremvc.haxe.multicore.patterns.facade.FacadeTest;
import org.puremvc.haxe.multicore.patterns.command.MacroCommandTest;
import org.puremvc.haxe.multicore.patterns.command.SimpleCommandTest;
import org.puremvc.haxe.multicore.patterns.mediator.MediatorTest;
import org.puremvc.haxe.multicore.core.ModelTest;
import org.puremvc.haxe.multicore.core.ViewTest;
import org.puremvc.haxe.multicore.core.ControllerTest;
import org.puremvc.haxe.multicore.patterns.proxy.ProxyTest;

class PureMVCMultiCoreTestRunner
{
	static function main()
	{
		var tr = new haxe.unit.TestRunner();

		tr.add( new NotificationTest() );
		tr.add( new ObserverTest() );
		tr.add( new SimpleCommandTest() );
		tr.add( new MacroCommandTest() );
		tr.add( new ProxyTest() );
		tr.add( new ModelTest() );
		tr.add( new MediatorTest() );
		tr.add( new ViewTest() );
		tr.add( new ControllerTest() );
		tr.add( new FacadeTest() );

		tr.run();
	}
}