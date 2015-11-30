/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseSetup;

import beans.InitializeDatabaseBeanRemote;
import javax.ejb.EJB;

/**
 *
 * @author Jons
 */
public class SampleDataCreator {
        @EJB
    private static InitializeDatabaseBeanRemote dataCreator;

    public static InitializeDatabaseBeanRemote getDataCreator() {
        return dataCreator;
    }
    
    /**
     * Creates some sample Data in the database using ejb
     * @param args 
     */
    public static void main(String args[]){
        System.out.println("Create sample Data now..... Look at server output for more details");
                dataCreator.createDatabase();
    }

}