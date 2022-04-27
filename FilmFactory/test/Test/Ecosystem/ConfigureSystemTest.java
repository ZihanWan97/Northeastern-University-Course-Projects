package Test.Ecosystem; 

import Ecosystem.ConfigureSystem;
import Ecosystem.FilmFactorySystem;
import org.junit.Assert;
import org.junit.Test;
import org.junit.Before; 
import org.junit.After; 

/** 
* ConfigureSystem Tester. 
* 
* @author <Authors name> 
* @since <pre>12月 12, 2021</pre> 
* @version 1.0 
*/ 
public class ConfigureSystemTest { 

@Before
public void before() throws Exception { 
} 

@After
public void after() throws Exception { 
} 

/** 
* 
* Method: configure() 
* 
*/ 
@Test
public void testConfigure() throws Exception { 
//TODO: Test goes here...
    FilmFactorySystem s = ConfigureSystem.configure();
    Assert.assertNotNull(s);
} 


} 
