/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import DTOs.UserDTO;
import basicBeans.UsersFacade;
import entities.AvailableRoles;
import entities.Users;
import DTOs.RolesEnum;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Singleton;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;



/**
 *
 * @author Jons
 */
@Singleton
@Stateless
public class UserManagerBean implements UserManagerBeanRemote {
    @EJB
    private UsersFacade usersFacade;
    
    @PersistenceContext(unitName = "SLIT_v02-ejbPU")
    private EntityManager em;

    private static Users currentUser;

    public static Users getCurrentUser() {
        return currentUser;
    }
    
    

    /**
     * @author JH
     * selfexplaining :P
     * @param userID
     * @return 
     */
    @Override
    public String getUserName(int userID){
        Users user = em.find(Users.class, userID);
        String name = user.getFirstname() + " " + user.getLastname();
        return name;
    }
    
    
    public void persist(Object object) {
        em.persist(object);
                List<Users> myUsers = new ArrayList<>();
    }

    /**
     * creates and returns a list of userDTOs 
     * @return 
     */
    @Override
    public List<UserDTO> getUserList() {
        
        List<Users> databaseUser = usersFacade.findAll();
                
        List<UserDTO> userDTO = new ArrayList<>();
        
        for(Users u : databaseUser){
            System.out.println("Creating user " + u.getFirstname() + " " + u.getLastname());
            String name = u.getFirstname() + " " + u.getLastname();
            double progress = 0.22; //u.getProgressCollection();
            UserDTO UserToAdd = new UserDTO(u.getIduser(),name, u.getEmail());
            userDTO.add(UserToAdd);
        }
        return userDTO;
        
    }
    
    
}
