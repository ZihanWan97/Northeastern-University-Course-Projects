package Test.Ecosystem.Movie; 

import Ecosystem.Movie.Movie;
import org.junit.Assert;
import org.junit.Test;
import org.junit.Before; 
import org.junit.After; 

/** 
* Movie Tester. 
* 
* @author <> 
* @since <pre>12月 12, 2021</pre> 
* @version 1.0 
*/ 
public class MovieTest { 

@Before
public void before() throws Exception { 
} 

@After
public void after() throws Exception { 
} 
/** 
* 
* Method: getName() 
* 
*/ 
@Test
public void testGetName() throws Exception { 
//TODO: Test goes here...
    Movie m = new Movie("movieName");
    Assert.assertEquals("movieName",m.getName());
} 

/** 
* 
* Method: getID() 
* 
*/ 
@Test
public void testGetID() throws Exception { 
//TODO: Test goes here...
    Movie m = new Movie("m");
    Assert.assertNotNull(m.getID());
} 

} 
