/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bibtextingcompany.bibtexting;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author mikromafia
 */
public class StringValidatorTest {
    
    public StringValidatorTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of Validate method, of class StringValidator.
     */
    @Test
    public void testNull() {
        String input = null;
        String expResult = "<null>";
        String result = StringValidator.Validate(input);
        
        System.out.println("Validate a null input to Validator. Result: "+result);
        assertEquals(result, expResult);

    }
    
        /**
     * Test of Validate method, of class StringValidator.
     */
    @Test
    public void testEmpty() {
        String input = "";
        String expResult = "<empty>";
        String result = StringValidator.Validate(input);
        
        System.out.println("Validate a empty  input to Validator. Result: "+result);
        assertEquals(result, expResult);

    }

           /**
     * Test of Validate method, of class StringValidator.
     */
    @Test
    public void testScandic() {
        String input = "Äää Ö Å å";
        String expResult = "\\\"{A}\\\"{a}\\\"{a} \\\"{o} \\AA \\aa";
        String result = StringValidator.Validate(input);
        
        System.out.println("Validate a Scandic String to Validator. Result: "+result);
        assertEquals(result, expResult);

    }
    
           /**
     * Test of Validate method, of class StringValidator.
     */
    @Test
    public void testStandardAsciiInput() {
        String input = "Abc";
        String expResult = "Abc";
        String result = StringValidator.Validate(input);
        
        System.out.println("Validate a std ASCII String to Validator. Result: "+result);
        assertEquals(result, expResult);

    }
    
        
           /**
     * Test of Validate method, of class StringValidator.
     */
    @Test
    public void testOtherSpecialChars() {
        String input = "$€¤";
        String expResult = "\\$<?><?>";
        String result = StringValidator.Validate(input);
        
        System.out.println("Validate a mixed ASCII/non-ASCII String to Validator. Result: "+result);
        assertEquals(result, expResult);

    }
    
    
}
